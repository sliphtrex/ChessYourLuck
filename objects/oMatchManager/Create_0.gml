//do we have a specific player deck for this match
userDeck = global.PlayerCards;
//used to specify a specific arrangement of cards;
pDeckSort = undefined;
opDeckSort = undefined;
//used to specify x cards can be drawn on turn n, where CardsPerTurn[n] = x
pCardsPerTurn=undefined;
opCardsPerTurn=undefined;

//Any objects being created in the manager that will be referenced often need to be
//stored as a global var. Trust me. It's a headache otherwise!!

//the oHand objects for the player and opponent respectively
global.pHand = undefined;
global.opHand = undefined;
//the oDeck objects
global.pDeck = undefined;
global.opDeck = undefined;
//the oDiscardPile objects
global.pDiscard = undefined;
global.opDiscard= undefined;
//the oSpadeCounter objects
global.pSpade=undefined;
global.opSpade=undefined;

//represents the opponents default deck, can be edited in the child
//NOTE: global.PlayerCards is stored in scrGameGlobals because we'll track that
//throughout the entire game.
global.opCards=[1,2,3,4,5,14,15,16,17,18,27,28,29,30,31,40,41,42,43,44];

//the depth that the side bars are being drawn at
pBorderDepth=undefined;
opBorderDepth=undefined;

//the oSpecialAbility objects for both players
PSA1=undefined;		OSA1=undefined;
PSA2=undefined;		OSA2=undefined;
PSA3=undefined;		OSA3=undefined;

//the field object which handles setting up grid tiles
field=undefined;

//The opponent's diamonds in a given match
opDiamonds=0;
//NOTE: the player's diamonds are stored in a global var in scrGameGlobals because
//we'll want to track them from match to match and in the Rainy Knight's Cafe.

//does the player make the first move?
//Note: This should also determine the color of our chess pieces
pStart=true;
//is it currently the players turn
pTurn = pStart;
//turn number
Turn=0;

//has the AI drawn a card yet
firstDraw=true;
//pairs of cards that could be combined
//see CheckValidComboPairs() for details
comboPairs = undefined;
//how many moves have we made this turn
//set in Alarm 0
decisionsMade=0;
//how much emphasis do we put on drawing a card
draw_weight=5;
//how much emphasis do we put on combining a card
combine_weight=5;
//how much emphasis do we put on playing a card
play_weight=5;
//how much emphasis do we put on moving pieces
move_weight=5;
//how much emphasis do we put on using special abilities
spAb_weight=5;

//the number of frames we wait between actions
waitTime = room_speed*1;
NextMove = undefined;

function Setup()
{
	#region player setup
	//setup player Hand
	global.pHand = instance_create_layer(800,800,"CardObjects",oHand);
	global.pHand.pHand=true;
	//setup player Deck
	global.pDeck = instance_create_layer(292,800,"CardObjects",oDeck);
	global.pDeck.pDeck=true;
	global.pDeck.DeckSetup2();
	//setup player discard pile
	global.pDiscard = instance_create_layer(1307,805,"CardObjects",oDiscardPile);
	global.pDiscard.pDiscardPile = true;
	//setup player side border
	pBorderDepth = instance_create_layer(0,0,"UILayer",oVoidBorder).depth;
	//setup player diamond counter
	global.pDiamondCounter = instance_create_layer(0,635,"UILayer",oDiamondCounter);
	global.pDiamondCounter.depth = pBorderDepth-1;
	//setup player spade counter
	global.pSpade = instance_create_layer(100,100,"UILayer",oSpadeCounter);
	global.pSpade.pSpades=true;
	global.pSpade.depth = pBorderDepth-1;
	
	//NOTE: we can set the player's abilities here because we are using a constant
	//global variable as opposed to what's essentially a lookup table for the enemy
	//setup Player SpAbs
	PSA1 = instance_create_layer(100, 550, "UILayer", oSpecialAbility);
	PSA1.depth = pBorderDepth-2;
	PSA1.specialAbility = global.PlayerSpecialAbility1;
	PSA1.playerAb = true;
	PSA1.Setup();
	PSA2 = instance_create_layer(100, 400, "UILayer", oSpecialAbility);
	PSA2.depth = pBorderDepth-2;
	PSA2.specialAbility = global.PlayerSpecialAbility2;
	PSA2.playerAb = true;
	PSA2.Setup();
	PSA3 = instance_create_layer(100, 250, "UILayer", oSpecialAbility);
	PSA3.depth = pBorderDepth-2;
	PSA3.specialAbility = global.PlayerSpecialAbility3;
	PSA3.playerAb = true;
	PSA3.Setup();
	//setup player end turn button
	var pet = instance_create_layer(0,760,"UILayer",oEndTurn);
	pet.pTurn=true;
	pet.depth = pBorderDepth-1;
	#endregion
	
	#region opponent setup
	//setup opponent's hand
	global.opHand = instance_create_layer(800,20,"CardObjects",oHand);
	//setup opponent's deck
	global.opDeck = instance_create_layer(1307,100,"CardObjects",oDeck);
	
	
	
	global.opDeck.DeckSetup2();
	//setup opponent's discard pile
	global.opDiscard = instance_create_layer(292,95,"CardObjects",oDiscardPile); 
	//setup opponent's side border
	opBorderDepth = instance_create_layer(1400,0,"UILayer",oVoidBorder).depth;
	//setup opponent's diamond counter
	global.opDiamondCounter = instance_create_layer(1400,185,"UILayer",oDiamondCounter);
	global.opDiamondCounter.pCounter=false;
	global.opDiamondCounter.depth = opBorderDepth-1;
	//setup opponent spade counter
	global.opSpade = instance_create_layer(1500,800,"UILayer",oSpadeCounter);
	global.opSpade.depth = opBorderDepth-1;
	
	//NOTE: We don't set up the opponents SpAbs yet because they will be different
	//each match. Instead we create these after the function call in the specific
	//manager that inherits from this.
	
	//setup opponent's end turn button
	var opet = instance_create_layer(1400,60,"UILayer",oEndTurn);
	opet.depth = opBorderDepth-1;
	#endregion
	
	//setup chess board
	field = instance_create_layer(800,450,"BoardLayer",oField);
	field.SetupBoard();
}

//draws a card from the opponent's deck
function DrawCardFromDeck()
{
	var curTurn=pTurn;
	global.opDeck.DrawCard2();
	show_debug_message("The AI drew a card. Cards drawn: "+string(global.opDeck.cardsDrawn));
	//if we draw a joker our pTurn should be different than our curTurn
	//this will end the state machine
	if(curTurn==pTurn){alarm[0]=waitTime;}
}

function CheckValidComboPairs()
{
	//a multidimentional array that stores c1 and c2 as [pair#][c1,c2]
	comboPairs = undefined;
	
	//check if we have any pairs that can be combined
	for(var i=0; i<array_length(global.opHand.cardsHeld)-1; i++)
	{
		for(var j=1; i+j<array_length(global.opHand.cardsHeld); j++)
		{
			if(global.opHand.cardsHeld[i].pips+global.opHand.cardsHeld[i+j].pips<=14)
			{
				if(comboPairs==undefined){comboPairs[0] = [i,i+j];}
				else{array_push(comboPairs,[i,i+j]);}
			}
		}
	}
	return comboPairs;
}