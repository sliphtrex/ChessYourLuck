pHand=false;

cardsHeld = [];
maxHandSize = 5;
handX = 525;
handY=740;
c1 = undefined;
c2 = undefined;
cardSelected = undefined;

//Adds cards to the 5 card hand and removes the oldest one if too many.
function AddToHand(obj)
{
	if(pHand){handX=590; handY=800;}
	else{handX=1010;handY=95;}
	
	array_push(cardsHeld,obj);
	cardsHeld[array_length(cardsHeld)-1].y=handY;
	if(array_length(cardsHeld)>maxHandSize)
	{DiscardCard(0);}
	
	//set position
	for(var i=0;i<array_length(cardsHeld);i++)
	{
		if(pHand){cardsHeld[array_length(cardsHeld)-1-i].x = handX + (105*i);}
		else{cardsHeld[array_length(cardsHeld)-1-i].x = handX - (105*i);}
	}
}

function FindAndDestroy(card)
{
	for(var i=0;i<array_length(cardsHeld);i++)
	{
		if(cardsHeld[i]=card)
		{
			DiscardCard(i);
			break;
		}
	}
	
	//reset position
	for(var i=0;i<array_length(cardsHeld);i++)
	{
		if(pHand){cardsHeld[array_length(cardsHeld)-1-i].x = handX + (105*i);}
		else{cardsHeld[array_length(cardsHeld)-1-i].x = handX - (105*i);}
	}
}

function DiscardCard(num)
{
	//send to the discard pile
	if(pHand)
	{
		global.pDiscard.Discard(cardsHeld[num]);
		cardsHeld[num].x=global.pDiscard.x;
		cardsHeld[num].y=global.pDiscard.y;
		cardsHeld[num].depth = global.pDiscard.depth
			-array_length(global.pDiscard.discards);
	}
	else
	{
		global.opDiscard.Discard(cardsHeld[num]);
		cardsHeld[num].x=global.opDiscard.x;
		cardsHeld[num].y=global.opDiscard.y;
		cardsHeld[num].depth = global.opDiscard.depth
			-array_length(global.opDiscard.discards);
	}
	
	cardsHeld[num].discarded=true;
	//remove from hand
	array_delete(cardsHeld,num,1);
}

function CombineCards()
{	
	if(c1.pips+c2.pips <= 14)
	{
		//If either card is not an amalgam we need to remove an extra club
		//and/or heart. This is because hearts and clubs get set to 1 by
		//default so the resulting piece has a base health and attack
		if(!c1.amalgam)
		{
			if(c1.suit!=0){--c1.clubs;}
			if(c1.suit!=1){--c1.hearts;}
		}
		if(!c2.amalgam)
		{
			if(c2.suit!=0){--c2.clubs;}
			if(c2.suit!=1){--c2.hearts;}
		}
	
		//create the card and establish its pip values
		card = instance_create_layer(x,y,"Instances",oAmalgamCard);
		audio_play_sound(sndCombineCards,1,false);
		card.clubs = c1.clubs + c2.clubs;
		card.hearts = c1.hearts + c2.hearts;
		card.spades = c1.spades + c2.spades;
		card.diamonds = c1.diamonds + c2.diamonds;
		card.pips = card.clubs+card.hearts+card.spades+card.diamonds;
		
		//assign it to the correct hand of cards
		card.pCard = c1.pCard;
		
		//remove c1 and c2 from cardsHeld and delete them
		for(var i=0;i<array_length(cardsHeld);i++)
		{
			if(c1==cardsHeld[i])
			{
				DiscardCard(i);
				c1 = undefined;
			}
		}
		for(var i=0;i<array_length(cardsHeld);i++)
		{
			if(c2==cardsHeld[i])
			{
				DiscardCard(i);
				c2 = undefined;
			}
		}
		card.Setup();
	}
}