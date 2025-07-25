event_inherited();

pDeckSort = [29,40,1,4,16,10,3,20,26,49,15,31,9,0,2,5,6,7,8,11,12,13,14,17,18,19,21,22,23,24,25,27,28,30,32,33,34,35,36,37,38,39,41,42,43,44,45,46,47,48,50,51];
pCardsPerTurn = [3,5,5,5,5,5,5,5,5,4];
opDeckSort =[50,14,27,18,4,5,6,7,8,9,10,11,12,13,1,15,16,17,3,19,20,21,22,23,24,25,26,2,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,0,51];
opCardsPerTurn = undefined;
opDiamonds=0;
charSelected=false;

global.PlayerSpecialAbility1 = 34;
global.PlayerSpecialAbility2 = -1;
global.PlayerSpecialAbility3 = -1;

queenSelected=false;
queenSelectedFrames=0;

selected6H=false;
selected6HFrames=0;

with(instance_create_layer(x,y,"Text",oVoidTextBox))
{
	Add_Text("Welcome weary traveller.",1,undefined,575,375);
	Add_Text("Be not alarmed.",1,undefined,650,375);
	Add_Text("Although it may look like you're in the vastness of space.",1,undefined,300,375);
	Add_Text("I assure you, you are within the confines of the Rainy Knight's Cafe.",1,undefined,250,375);
	Add_Text("Here our guests play a rather unique chess variant.",1,undefined,250,375);
	Add_Text("Would you like me to show you how?",1,undefined,400,375);
	Add_Option("Yes",PlayTut);
	Add_Option("No",AreYouSure);
}

function AreYouSure()
{
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("So you remember then?",1,undefined,550,375);
		Add_Option("Yes",DefineForm);
		Add_Option("No",AsIThought);
	}
}

function AsIThought()
{
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("As I thought.",1,undefined,650,375);
		NextMove = PlayTut;
	}
}

function PlayTut()
{
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Then let us begin.",1,undefined,625,375);
		NextMove = SetupTut;
	}
}

function SetupTut()
{
	//We will need to set these as global vars so other objects can access them quickly
	
	//setup player Hand
	global.pHand = instance_create_layer(800,800,"CardObjects",oHand);
	global.pHand.pHand=true;
	//setup player Deck
	global.pDeck = instance_create_layer(292,800,"CardObjects",oDeck);
	global.pDeck.pDeck=true;
	global.pDeck.DeckSetup();
	//setup player's discard pile
	global.pDiscard = instance_create_layer(1307,805,"CardObjects",oDiscardPile);
	global.pDiscard.pDiscardPile = true;
	//setup opponent's hand
	//Note: pHand is set false by default so we don't need to set anything for opHand
	global.opHand = instance_create_layer(800,20,"CardObjects",oHand);
	//setup opponent's deck
	global.opDeck = instance_create_layer(1307,100,"CardObjects",oDeck);
	global.opDeck.DeckSetup();
	//setup opponent's discard pile
	global.opDiscard = instance_create_layer(292,95,"CardObjects",oDiscardPile);
	
	field = instance_create_layer(800,450,"BoardLayer",oField);
	field.SetupBoard();
	
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("You start with a single king each, and a hand of 5 cards.",1,undefined, undefined,400);
		Add_Text("These cards are your primary method of summoning more chess pieces.",1,undefined,undefined,600);
		Add_Text("Let's try playing a card.",1,undefined,525,650);
		Add_Text("Left click that 4 of Hearts.",1,undefined,500,650,CheckFourOfHeartsSelected);
		Add_Text("Now click the space diagonally right of your king",1,undefined,undefined,375,CheckFourOfHeartsPlayed);
		Add_Text("Excellent! As you can see, your 4 of Hearts became a pawn.",1,undefined,undefined,350);
		Add_Text("Now, let's place that 5 of Clubs diagonally to the left of the king.",1,undefined,undefined,350,CheckFiveOfClubsPlayed);
		Add_Text("Now you have a knight.",1,undefined, 530,400);
		Add_Text("As you may have guessed the value of the card translates to the strength of the piece.",1);
		Add_Text("A card with a value of 2-4 becomes a pawn,",1,undefined,250);
		Add_Text("5-7 a knight,",1,undefined,625);
		Add_Text("and 8-10 a bishop.",1,undefined,600);
		Add_Text("Try drawing another card from the deck by clicking on it.",1,undefined,undefined,590,CheckJackOfClubsInHand);
		Add_Text("What luck, you've just drawn a Jack of Clubs.",1,undefined,250,650);
		Add_Text("Try playing that front and center.",1,undefined,425,375,CheckJackOfClubsPlayed);
		Add_Text("In this game, jacks translate as rooks.",1,undefined,400,400);
		Add_Text("Go ahead and draw two more cards.",1,undefined,200,650,Check8HAnd4C);
		Add_Text("Now for the fun part.",1,undefined,575,650);
		Add_Text("Try dragging that 8 of Hearts onto the 2 of Clubs.",1,undefined,undefined,650,CheckFor10Amalgam);
		Add_Text("Now you're starting to see the ingenuity of this game.",1,undefined,undefined,650);
		Add_Text("When you combine two cards, they create an amalgam.",1);
		Add_Text("So long as the value of the two cards does not exceed 14,",1);
		Add_Text("You can continue combining cards as much as you wish.",1);
		Add_Text("The total value of the amalgam determines the rank of the chess piece.",1);
		Add_Text("But now let's focus on the importance of suits.",1);
		Add_Text("Combine your 2 of Diamonds with the amalgam you just created.",1,undefined,undefined,600,CheckForQueenAmalgam);
		Add_Text("Play the newly created Queen amalgam to the right of the king.",1,undefined,undefined,375,CheckForQueenPlayed);
		NextMove = CreateSideBars;
	}
}

function CheckFourOfHeartsSelected()
{
	if(instance_exists(global.pHand.cardSelected)
	&&global.pHand.cardSelected.suit==1
	&&global.pHand.cardSelected.pips==4)
	{return true;}
	else{return false;}
}

function CheckFourOfHeartsPlayed()
{
	if(instance_exists(instance_find(oField,0).grid[3][5].myPiece)
	&&instance_find(oField,0).grid[3][5].myPiece.object_index==oPawnW
	&&instance_find(oField,0).grid[3][5].myPiece.Health==4)
	{return true;}
	else{return false;}
}

function CheckFiveOfClubsPlayed()
{
	if(instance_exists(instance_find(oField,0).grid[3][3].myPiece)
	&&instance_find(oField,0).grid[3][3].myPiece.object_index==oKnightW
	&&instance_find(oField,0).grid[3][3].myPiece.Attack==5)
	{return true;}
	else{return false;}
}

function CheckJackOfClubsInHand()
{
	var cardInHand=false;
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		if(global.pHand.cardsHeld[i].pips==11
			&&global.pHand.cardsHeld[i].clubs==11)
		{cardInHand=true;}
	}
	return cardInHand;
}

function CheckJackOfClubsPlayed()
{
	if(instance_exists(instance_find(oField,0).grid[3][4].myPiece)
	&&instance_find(oField,0).grid[3][4].myPiece.object_index==oRookW
	&&instance_find(oField,0).grid[3][4].myPiece.Attack==10)
	{return true;}
	else{return false;}
}

function Check8HAnd4C()
{
	var cardInHand=false;
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		if(global.pHand.cardsHeld[i].pips==8
			&&global.pHand.cardsHeld[i].hearts==8)
		{cardInHand=true;}
	}
	return cardInHand;
}

function CheckFor10Amalgam()
{
	var cardInHand=false;
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		show_debug_message("Card "+string(i)+" clubs: " + string(global.pHand.cardsHeld[i].clubs));
		if(global.pHand.cardsHeld[i].pips==10
			&&global.pHand.cardsHeld[i].clubs==2
			&&global.pHand.cardsHeld[i].hearts==8)
		{cardInHand=true;}
	}
	return cardInHand;
}

function CheckForQueenAmalgam()
{
	var cardInHand=false;
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		if(global.pHand.cardsHeld[i].pips==12
			&&global.pHand.cardsHeld[i].clubs==2
			&&global.pHand.cardsHeld[i].hearts==8
			&&global.pHand.cardsHeld[i].diamonds==2)
		{cardInHand=true;}
	}
	return cardInHand;
}

function CheckForQueenPlayed()
{
	if(instance_exists(instance_find(oField,0).grid[4][5].myPiece)
	&&instance_find(oField,0).grid[4][5].myPiece.object_index==oQueenW
	&&instance_find(oField,0).grid[4][5].myPiece.Attack==2
	&&instance_find(oField,0).grid[4][5].myPiece.Health==8)
	{return true;}
	else{return false;}
}

function CreateSideBars()
{
	instance_find(oMatchManager,0).pBorderDepth = instance_create_layer(0,0,"UILayer",oVoidBorder).depth;
	instance_find(oMatchManager,0).opBorderDepth = instance_create_layer(1400,0,"UILayer",oVoidBorder).depth
	var pc = instance_create_layer(0,635,"UILayer",oDiamondCounter);
	pc.depth = instance_find(oMatchManager,0).opBorderDepth-1;
	var opc = instance_create_layer(1400,185,"UILayer",oDiamondCounter);
	opc.pCounter=false;
	opc.depth = instance_find(oMatchManager,0).pBorderDepth-1;
	global.pSpade = instance_create_layer(100,100,"UILayer",oSpadeCounter);
	global.pSpade.pSpades=true;
	global.pSpade.depth = instance_find(oMatchManager,0).pBorderDepth-1;
	global.opSpade = instance_create_layer(1500,800,"UILayer",oSpadeCounter);
	global.opSpade.depth = instance_find(oMatchManager,0).opBorderDepth-1;
	
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("This Queen has 8 health from the 8 of Hearts,",1,undefined,275,350);
		Add_Text("and 2 power from the 2 of Clubs.",1,undefined,425,350);
		Add_Text("As for the diamonds. Well you'll understand in due time.",1,undefined,200,650);
		Add_Text("Just know you'll want to collect some of those.",1,undefined,200,650);
		Add_Text("Now, why don't you draw another card.",1,undefined,200,650,CheckIfOpTurn);
		Add_Text("I'm sorry to say, I knew this would happen.",1,undefined,340);
		Add_Text("Don't feel too bad. The player going first can't move their pieces on the first turn anyway.",1,undefined,200);
		Add_Text("Each time you draw a card, that card is replaced with a joker.",1,undefined,200);
		Add_Text("When you draw one, your turn is forfeit.",1,undefined,350);
		NextMove = SetupAnuTurn;
	}
}

function CheckIfOpTurn()
{
	if(instance_find(oMatchManager,0).pTurn==false){return true;}
	else{return false;}
}

function SetupAnuTurn()
{
	var pet = instance_create_layer(0,760,"UILayer",oEndTurn);
	pet.pTurn=true;
	pet.depth = instance_find(oMatchManager,0).pBorderDepth-1;
	var opet = instance_create_layer(1400,60,"UILayer",oEndTurn);
	opet.depth = instance_find(oMatchManager,0).pBorderDepth-1;
	
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("You can also click the End Turn button if you're the cautious type.",1,undefined,200,650);
		Add_Text("...But for now it's my turn.",1,undefined,475);
		Add_Text("Forgive me, I haven't introduced myself yet.",1,undefined,350);
		Add_Text("My name is Anu.",1,undefined,650,375);
		Add_Text("I will simply play this Queen of Diamonds for now and end my turn.",1,undefined,200);
		NextMove = AnuSelectsQueen;
	}
}

function AnuSelectsQueen()
{
	for(var i=0; i<array_length(global.opHand.cardsHeld);i++)
	{
		if(global.opHand.cardsHeld[i].pips==12&&global.opHand.cardsHeld[i].diamonds==12)
		{
			global.opHand.cardsHeld[i].selected=true;
			global.opHand.cardSelected = global.opHand.cardsHeld[i];
			instance_find(oField,0).CardSelected();
		}
	}
	instance_find(oMatchManager,0).queenSelected=true;
}

function AnuPlaysQueen()
{
	instance_find(oField,0).grid[1][4].PlayPiece(false);
	
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Actually, I'd like to demonstrate something first.",1,undefined,300);
		NextMove = AnuSelects6H;
	}
}

function AnuSelects6H()
{
	for(var i=0; i<array_length(global.opHand.cardsHeld);i++)
	{
		if(global.opHand.cardsHeld[i].pips==6&&global.opHand.cardsHeld[i].hearts==6)
		{
			global.opHand.cardsHeld[i].selected=true;
			global.opHand.cardSelected = global.opHand.cardsHeld[i];
			instance_find(oField,0).CardSelected();
		}
	}
	instance_find(oMatchManager,0).selected6H=true;
}

function AnuPlays6H()
{
	instance_find(oField,0).grid[1][4].UpgradePiece(false);
	
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("If you click a heart or club card and then select a piece,",1,undefined,250);
		Add_Text("it will gain the associated health or power respectively.",1,undefined,250);
		Add_Text("And with that, I will conclude my turn.",1,undefined,400);
		NextMove = Players2ndTurn;
	}
}

function Players2ndTurn()
{
	instance_find(oField,0).ChangeTurns();
	
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Go ahead and draw a card... And fear not!",1,undefined,200,650);
		Add_Text("The first draw on a given turn is always on the house.",1,undefined,200,600, CheckForAceOfSpades);
		Add_Text("Well done! The Ace of Spades!",1,undefined,400,650);
		Add_Text("Play that next to your king and see what happens.",1,undefined,undefined,350, CheckAcePlayed);
		Add_Text("Aces manifest themselves as a graduated pawn.",1,undefined,400,350);
		Add_Text("Click on the pawn you just played.",1,undefined,450,350);
		Add_Text("Now click on the king icon.",1,undefined,450,350, CheckFor2ndKing);
		Add_Text("In this game you can have as many kings as you wish,",1);
		Add_Text("But you must have at least one or it's game over!",1);
		Add_Text("Now, because you played an Ace of Spades it gave you 14 spade pips.",1,undefined,200,50);
		NextMove = SetupSpecialAbilities;
	}
}

function CheckForAceOfSpades()
{
	var cardInHand=false;
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		if(global.pHand.cardsHeld[i].pips==14
			&&global.pHand.cardsHeld[i].spades==14)
		{cardInHand=true;}
	}
	return cardInHand;
}

function CheckAcePlayed()
{
	if(instance_exists(instance_find(oField,0).grid[4][3].myPiece)
	&&instance_find(oField,0).grid[4][3].myPiece.object_index==oPawnW
	&&instance_find(oField,0).grid[4][3].myPiece.Attack==1
	&&instance_find(oField,0).grid[4][3].myPiece.Health==1)
	{return true;} else {return false;}
}

function CheckFor2ndKing()
{
	if(instance_exists(instance_find(oField,0).grid[4][3].myPiece)
	&&instance_find(oField,0).grid[4][3].myPiece.object_index==oKingW
	&&instance_find(oField,0).grid[4][3].myPiece.Attack==1
	&&instance_find(oField,0).grid[4][3].myPiece.Health==1)
	{return true;} else {return false;}
}

function SetupSpecialAbilities()
{
	//players
	PSA1 = instance_create_layer(100, 550, "UILayer", oSpecialAbility);
	PSA1.depth = instance_find(oMatchManager,0).pBorderDepth-2;
	PSA1.specialAbility = global.PlayerSpecialAbility1;
	PSA1.playerAb = true;
	PSA1.Setup();
	PSA2 = instance_create_layer(100, 400, "UILayer", oSpecialAbility);
	PSA2.depth = instance_find(oMatchManager,0).pBorderDepth-2;
	PSA2.specialAbility = global.PlayerSpecialAbility2;
	PSA2.playerAb = true;
	PSA2.Setup();
	PSA3 = instance_create_layer(100, 250, "UILayer", oSpecialAbility);
	PSA3.depth = instance_find(oMatchManager,0).pBorderDepth-2;
	PSA3.specialAbility = global.PlayerSpecialAbility3;
	PSA3.playerAb = true;
	PSA3.Setup();
	
	//opponent's
	OSA1 = instance_create_layer(1500, 650, "UILayer", oSpecialAbility);
	OSA1.depth = instance_find(oMatchManager,0).opBorderDepth-2;
	OSA1.specialAbility = 14;
	OSA1.Setup();
	OSA2 = instance_create_layer(1500, 500, "UILayer", oSpecialAbility);
	OSA2.depth = instance_find(oMatchManager,0).opBorderDepth-2;
	OSA2.specialAbility = 0;
	OSA2.Setup();
	OSA3 = instance_create_layer(1500, 350, "UILayer", oSpecialAbility);
	OSA3.depth = instance_find(oMatchManager,0).opBorderDepth-2;
	OSA3.specialAbility = 34;
	OSA3.Setup();
	
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Spade pips, or SP for short, allow you to use your special abilities.",1);
		Add_Text("If you hover over them, you can see a description of what each ability does.",1);
		Add_Text("Try inflicting your Pain ability on my queen.",1,undefined,undefined,undefined, CheckPainOnQueen);
		Add_Text("Great! Now use your knight to attack it.",1,undefined,undefined,undefined, CheckKnightAttacksQueen);
		Add_Text("In this game, you must lower the piece's health to 0 to capture.",1);
		Add_Text("Why not use your rook to capture my queen?",1,undefined,undefined,undefined, CheckRookAttacksQueen);
		Add_Text("Allow me one more lesson before we finish here.",1);
		Add_Text("Do me the favor of drawing 4 more cards.",1,undefined,undefined,undefined,Check10CInHand);
		Add_Text("Notice your 4 of Spades moved to the discard pile.",1);
		Add_Text("Your hand of cards is capped at 5. No exceptions.",1);
		Add_Text("It's not ideal, but we must make due with what we are given.",1);
		Add_Text("Move your 10 of Clubs to the position two right of the pawn.",1,undefined,undefined,undefined, CheckBishopCreated);
		Add_Text("Now attack my only king and end the match.",1,undefined,undefined,undefined, CheckKingDown);
		NextMove = DefineForm;
	}
}

function CheckPainOnQueen()
{
	if(instance_find(oField,0).grid[1][4].myPiece.Health == 6)
	{return true;} else {return false;}
}

function CheckKnightAttacksQueen()
{
	if(instance_find(oField,0).grid[1][4].myPiece.Health == 1)
	{return true;} else {return false;}
}

function CheckRookAttacksQueen()
{
	if(instance_find(oField,0).grid[1][4].myPiece.object_index == oRookW)
	{return true;} else {return false;}
}

function Check10CInHand()
{
	var cardInHand=false;
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		if(global.pHand.cardsHeld[i].pips==10
			&&global.pHand.cardsHeld[i].clubs==10)
		{cardInHand=true;}
	}
	return cardInHand;
}

function CheckBishopCreated()
{
	if(instance_exists(instance_find(oField,0).grid[3][7].myPiece)
	&&instance_find(oField,0).grid[3][7].myPiece.object_index==oBishopW
	&&instance_find(oField,0).grid[3][7].myPiece.Attack==10
	&&instance_find(oField,0).grid[3][7].myPiece.Health==1)
	{return true;} else {return false;}
}

function CheckKingDown()
{
	if(instance_find(oField,0).grid[0][4].myPiece.object_index == oBishopW)
	{return true;} else {return false;}
}

function DefineForm()
{
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Alright. Next order of business.",1);
		Add_Text("Before you can proceed, you must define your form.",1,undefined,350,375);
		NextMove = CharacterSelect;
	}
	//FinalWords();
}

function CharacterSelect()
{
	show_debug_message("in CharacterSelect");
	charSelected=false;
	
	charIcons[0] = instance_create_layer(x,y,"UILayer",oCharIcon);
	charIcons[0].icon = 0;
	charIcons[0].Setup();
	charIcons[1] = instance_create_layer(x,y,"UILayer",oCharIcon);
	charIcons[1].icon = 1;
	charIcons[1].Setup();
	charIcons[2] = instance_create_layer(x,y,"UILayer",oCharIcon);
	charIcons[2].icon = 2;
	charIcons[2].Setup();
	//if(global.DogPlaythroughComplete)
	//{
		charIcons[3] = instance_create_layer(x,y,"UILayer",oCharIcon);
		charIcons[3].icon = 3;
		charIcons[3].Setup();
	//}
	
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Out of the following options, how would you most like to be perceived by others?",1,undefined,350,375,CharacterSelectedCheck());
		NextMove = LastChance;
	}
}

function CharacterSelectedCheck()
{return instance_find(oTutManager,0).charSelected;}

function LastChance()
{
	with(oCharIcon){instance_destroy();}
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Are you sure you're happy with your choice? This will impact how your story unfolds.",1);
			Add_Option("Yes",FinalWords);
			Add_Option("Not sure", CharacterSelect);
	}
}

function FinalWords()
{
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Very well then.",1);
		Add_Text("There will be no checks nor mates here.",1,undefined,350,375);
		Add_Text("Nor any warnings of potential misfortunes.",1,undefined,350,375);
		Add_Text("Don't get careless.",1,undefined,575,375);
		NextMove = EndTut;
	}
}

function EndTut()
{
	trans = instance_create_layer(0,0,"Text",oFadeTransition);
	trans.nextRoom = rRainyKnightsCafe;
}