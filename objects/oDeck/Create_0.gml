/***********************************************************************************
*
* This array tracks the randomly assigned order of cards for a given match.
* For example: if the first int at deckOrder[0] = 39, we would get
* global.PlayerCards[39] as the first card drawn in our deck. This would be the Ace
* of Diamonds if the deck hasn't been modified by the player yet.
*
***********************************************************************************/
deckOrder[0] = 0;

//used to specify x cards can be drawn on turn n, where CardsPerTurn[n] = x
cardsPerTurn[0]=undefined;
pDeck=false;

firstHand=0;
curCard=0;
cardsDrawn=0;

function DeckSetup()
{
	if(pDeck) {x=292; y=800; sprite_index = sprBlueDeck;}
	else {x=1307; y=100; sprite_index = sprRedDeck;}
	
	//check if the match manager has a premade deck for us to use
	if(instance_exists(oMatchManager) &&
		((pDeck&&instance_find(oMatchManager,0).pDeckSort!=undefined)||
		(!pDeck&&instance_find(oMatchManager,0).opDeckSort!=undefined)))
	{
		//using a ternary operator to set the correct deck based on pDeck
		deckOrder = (pDeck) ? instance_find(oMatchManager,0).pDeckSort : instance_find(oMatchManager,0).opDeckSort;
	}
	//otherwise we set up the deck as normal
	else
	{
		//keep track of previously chosen cards
		cardsSelected[0] = 0;
	
		for(var c=0; c<52; c++)
		{
			//set the given card to random int between 0-51
			deckOrder[c] = irandom_range(0,51);
		
			//if it's the first card then we don't need to check for dupes
			if(c>0)
			{
				var chosen = false;
				for(var i=0; i<array_length(cardsSelected);i++)
				{
					//check our current card against all previously chosen cards
					if(deckOrder[c]==cardsSelected[i]){chosen = true;}
				}
				//if the card was previously chosen
				while(chosen)
				{
					//increment between 0-51, wrapping the number when we reach 51
					deckOrder[c] = (deckOrder[c]<51) ? deckOrder[c]+1 : 0;
				
					var newCard=true;
					for(var i=0; i<array_length(cardsSelected);i++)
					{
						//check this new number against previously chosen cards
						if(deckOrder[c]==cardsSelected[i]){newCard=false;}
					}
					//if the new number hasn't been chosen before, we break the loop
					if(newCard){chosen=false;}
				}
			}
			//now that we've confirmed it's a new card, we can assign it to our
			//previously drawn card array
			cardsSelected[c] = deckOrder[c];
		}
	}
	
	//if we have a set cardsPerTurn use it
	if(instance_exists(oMatchManager)&&
		((pDeck&&instance_find(oMatchManager,0).pCardsPerTurn!=undefined)
		||(!pDeck&&instance_find(oMatchManager,0).opCardsPerTurn!=undefined)))
	{
		cardsPerTurn = (pDeck) ? instance_find(oMatchManager,0).pCardsPerTurn : instance_find(oMatchManager,0).opCardsPerTurn;
	}
	//otherwise set up our cards per turn on the fly
	else
	{
		//we start at 5 to account for our first hand
		var totalCards=5;
		//keeps track of which turn we're setting for
		var turn = 0;
		//min number of cards we should draw
		var minimum = 1;
		
		//as more cards are drawn our odds of drawing a joker should increase
		while(totalCards<52)
		{
			if(totalCards<10)
			{
				//max turns would be 3; 5+1+2+3=11;
				if(turn>0){minimum++;}
				cardsPerTurn[turn] = irandom_range(minimum,10);
			}
			else if(totalCards<20)
			{
				//max would be 5; 5+1+2+3+4+5=20;
				if(turn>3){minimum++;}
				cardsPerTurn[turn] = irandom_range(minimum,8);
			}
			//we want to increase the minimum to account for good draws
			//because it only decreases from here and we don't want the player
			//to only draw a string of ones
			else if(totalCards<30)
			{
				if(minimum<5){minimum++;}
				cardsPerTurn[turn] = irandom_range(minimum,7);
			}
			//and now we start decreasing the max min so the player starts to feel it
			else if(totalCards<40)
			{
				if(minimum>4){minimum--;}
				cardsPerTurn[turn] = irandom_range(minimum,5);
			}
			//min could be 4 so we need to drop it to at least 3
			else if(totalCards<50)
			{
				if(minimum>3){minimum--;}
				cardsPerTurn[turn] = irandom_range(minimum,3);
			}
			//we cant go over 52 so we need to limit it
			else if(totalCards<52)
			{
				if(totalCards==51){cardsPerTurn[turn]=1;}
				else{cardsPerTurn[turn] = irandom_range(1,2);}
			}
			
			totalCards += cardsPerTurn[turn];
			turn++;
			
			//with this algorithm it takes a min of 8 turns to draw every card
			//and (if I did the math correctly) a max of 14 turns
			//by turn 15 we should be solidly into the midgame.
		}
	}
	
	//set our alarm to draw our starting hand next frame
	alarm[0] = 1;
}

function DrawCard()
{
	if(curCard<52 && cardsDrawn<cardsPerTurn[instance_find(oMatchManager,0).Turn])
	{
		if(pDeck){CreateCard(global.PlayerCards[deckOrder[curCard]]);}
		else{CreateCard(global.opCards[deckOrder[curCard]]);}
		curCard++;
		cardsDrawn++;
	}
	else
	{
		TurnOver();
	}
}

///@param newCard
function CreateCard(newCard)
{
	//create a standard card
	card = instance_create_layer(x,y,"Instances",oStandardCard);
	//assign the card to either the players hand or the opponents
	card.pCard = pDeck;
	card.card = newCard;
	card.Setup();
}

function TurnOver()
{
	cardsDrawn=0;
	instance_create_layer(x,y,"Instances",oJoker);
}