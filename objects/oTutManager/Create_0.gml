event_inherited();

userDeck = [29,40,1,4,16,10,3,20,26,49,15,31,9,0,2,5,6,7,8,11];
global.opCards=[50,14,27,18,4,5,6,7,8,9,10,11,12,13,1,15,16,17,3,19];

pDeckSort = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];
pCardsPerTurn = [3,5,5,5,5,5,5,5,5,4];
opDeckSort = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];
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

global.tut_id = id;

#region dialog setup

function AreYouSure()
{
	
	with(add_detatched_branch(true)){ //NOTE: branches inherit the settings of the parent caller
		add_page("So you remember then?");
		add_option("Yes",global.tut_id.FinalWords);
		add_option("No",global.tut_id.AsIThought);
	}
}

function PlayTut()
{
	
	with(add_detatched_branch(true)){
		add_page("Then let us begin.");
		add_page_action(global.tut_id.SetupTut);
	}
}


{
	with(instance_create_layer(x,y,"Text",eDialogManager)){
		show_debug_message("-----------\n" + "Spawn " + string(id));
			/*
		//We are not gonna replicate these just yet
		//our line width[per line, per page]
		line_break_pos[0,page_number]=500;
		//how many line breaks are on a given page
		line_break_num[page_number]=0;
			//how many pixels of overflow from the last line
		line_break_offset[page_number]=0;
	
		textbox_spr[page_number] = sprVoidTextBox;
		textbox_width[page_number] = 1200;
		line_width[page_number] = textbox_width[page_number]-(border*2);
			text_x_offset[page_number] = 235; //these seem to get overriden
		text_y_offset[page_number] = 170;
		*/
		
		voidsettings();
		tb_settings.x = TB_POS.CENTER2;
		tb_settings.y = TB_POS.CENTER2;
	
		add_page("Welcome weary traveller");
		add_page("Be not alarmed");
		add_page("Although it may look like you're in the vastness of space.");
		add_page("I assure you, you are within the confines of the Rainy Knight's Cafe");
		add_page("Here our guests play a rather unique chess variant.");
		add_page("Would you like me to show you how?");
	
		add_option("Yes", global.tut_id.PlayTut); //FIXME: ye this doesn't work
		add_option("No", global.tut_id.AreYouSure);
	}
}







function AsIThought()
{
	with(add_detatched_branch(true)){
		add_page("As I thought.");
		add_page_action(global.tut_id.PlayTut);
	}
}



#endregion

function SetupTut()
{
	//We will need to set these as global vars so other objects can access them quickly
	
	//setup player Hand
	global.pHand = instance_create_layer(800,800,"CardObjects",oHand);
	global.pHand.pHand=true;
	//setup player Deck
	global.pDeck = instance_create_layer(292,800,"CardObjects",oDeck);
	global.pDeck.pDeck=true;
	global.pDeck.DeckSetup2();
	//setup player's discard pile
	global.pDiscard = instance_create_layer(1307,805,"CardObjects",oDiscardPile);
	global.pDiscard.pDiscardPile = true;
	//setup opponent's hand
	//Note: pHand is set false by default so we don't need to set anything for opHand
	global.opHand = instance_create_layer(800,20,"CardObjects",oHand);
	//setup opponent's deck
	global.opDeck = instance_create_layer(1307,100,"CardObjects",oDeck);
	global.opDeck.DeckSetup2();
	//setup opponent's discard pile
	global.opDiscard = instance_create_layer(292,95,"CardObjects",oDiscardPile);
	
	field = instance_create_layer(800,450,"BoardLayer",oField);
	field.SetupBoard();
	
	with(add_detatched_branch(true)){
		
		tb_settings.x = TB_POS.CENTER2;
		tb_settings.y = TB_POS.CENTER2;
		
		add_page("You start with a single king each, and a hand of 5 cards.");
		add_page("These cards are your primary method of summoning more chess pieces.");
		
		add_page("Let's try playing a card.");
		
		add_page("Left click that 4 of Hearts."); //MARK: page action
		add_page_action(global.tut_id.CheckFourOfHeartsSelected);
		
		add_page("Now click the space diagonally right of your king"); //MARK: page action
		add_page_action(global.tut_id.CheckFourOfHeartsPlayed);
		
		add_page("Excellent! As you can see, your 4 of Hearts became a pawn.");
		
		add_page("Now, let's place that 5 of Clubs diagonally to the left of the king."); //MARK: page action
		add_page_action(global.tut_id.CheckFiveOfClubsPlayed);
		
		add_page("Now you have a knight.");
		add_page("As you may have guessed the value of the card translates to the strength of the piece.");
		add_page("A card with a value of 2-4 becomes a pawn,");
		add_page("5-7 a knight,");
		add_page("and 8-10 a bishop.");
		
		add_page("Try drawing another card from the deck by clicking on it."); //MARK: page action
		add_page_action(global.tut_id.CheckJackOfClubsInHand);
		
		add_page("What luck, you've just drawn a Jack of Clubs.");
		
		add_page("Try playing that front and center."); //MARK: page action
		add_page_action(global.tut_id.CheckJackOfClubsPlayed);
		
		add_page("In this game, jacks translate as rooks.");
		
		add_page("Go ahead and draw two more cards.");
		add_page_action(global.tut_id.Check8HAnd4C);
		
		add_page("Now for the fun part.");
		
		add_page("Try dragging that 8 of Hearts onto the 2 of Clubs."); //MARK: page action
		add_page_action(global.tut_id.CheckFor10Amalgam);
		
		add_page("Now you're starting to see the ingenuity of this game.");
		add_page("When you combine two cards, they create an amalgam.");
		add_page("So long as the value of the two cards does not exceed 14,");
		add_page("You can continue combining cards as much as you wish.");
		add_page("The total value of the amalgam determines the rank of the chess piece.");
		add_page("But now let's focus on the importance of suits.");
		
		
		add_page("Combine your 2 of Diamonds with the amalgam you just created."); //MARK: page action
		add_page_action(global.tut_id.CheckForQueenAmalgam);
		
		add_page("Play the newly created Queen amalgam to the right of the king."); //MARK: page action
		add_page_action(global.tut_id.CheckForQueenPlayed);
	}
}

function CheckFourOfHeartsSelected()
{
	if(instance_exists(global.pHand.cardSelected)
	&&global.pHand.cardSelected.suit==1
	&&global.pHand.cardSelected.pips==4){
		next_page();
	}
}

function CheckFourOfHeartsPlayed()
{
	if(instance_exists(instance_find(oField,0).grid[3][5].myPiece)
	&&instance_find(oField,0).grid[3][5].myPiece.object_index==oPawnW
	&&instance_find(oField,0).grid[3][5].myPiece.Health==4)
	{next_page();}
}

function CheckFiveOfClubsPlayed()
{
	if(instance_exists(instance_find(oField,0).grid[3][3].myPiece)
	&&instance_find(oField,0).grid[3][3].myPiece.object_index==oKnightW
	&&instance_find(oField,0).grid[3][3].myPiece.Attack==5)
	{next_page();}
}

function CheckJackOfClubsInHand()
{
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		if(global.pHand.cardsHeld[i].pips==11
			&&global.pHand.cardsHeld[i].clubs==11)
		{next_page();return;}
	}
}

function CheckJackOfClubsPlayed()
{
	if(instance_exists(instance_find(oField,0).grid[3][4].myPiece)
	&&instance_find(oField,0).grid[3][4].myPiece.object_index==oRookW
	&&instance_find(oField,0).grid[3][4].myPiece.Attack==10)
	{next_page();}
}

function Check8HAnd4C()
{
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		if(global.pHand.cardsHeld[i].pips==8
			&&global.pHand.cardsHeld[i].hearts==8)
		{next_page();return;}
	}
}

function CheckFor10Amalgam()
{
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		show_debug_message("Card "+string(i)+" clubs: " + string(global.pHand.cardsHeld[i].clubs));
		if(global.pHand.cardsHeld[i].pips==10
			&&global.pHand.cardsHeld[i].clubs==2
			&&global.pHand.cardsHeld[i].hearts==8)
		{next_page();return;}
	}
}

function CheckForQueenAmalgam()
{
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		if(global.pHand.cardsHeld[i].pips==12
			&&global.pHand.cardsHeld[i].clubs==2
			&&global.pHand.cardsHeld[i].hearts==8
			&&global.pHand.cardsHeld[i].diamonds==2)
		{next_page();return;}
	}
}

function CreateSideBars()
{
	instance_find(oMatchManager,0).pBorderDepth = instance_create_layer(0,0,"UILayer",oVoidBorder).depth;
	instance_find(oMatchManager,0).opBorderDepth = instance_create_layer(1400,0,"UILayer",oVoidBorder).depth
	global.pDiamondCounter = instance_create_layer(0,635,"UILayer",oDiamondCounter);
	global.pDiamondCounter.depth = instance_find(oMatchManager,0).opBorderDepth-1;
	global.opDiamondCounter = instance_create_layer(1400,185,"UILayer",oDiamondCounter);
	global.opDiamondCounter.pCounter=false;
	global.opDiamondCounter.depth = instance_find(oMatchManager,0).pBorderDepth-1;
	global.pSpade = instance_create_layer(100,100,"UILayer",oSpadeCounter);
	global.pSpade.pSpades=true;
	global.pSpade.depth = instance_find(oMatchManager,0).pBorderDepth-1;
	global.opSpade = instance_create_layer(1500,800,"UILayer",oSpadeCounter);
	global.opSpade.depth = instance_find(oMatchManager,0).opBorderDepth-1;
	
	with(add_detatched_branch(true)){
		add_page("This Queen has 8 health from the 8 of Hearts,");
		add_page("and 2 power from the 2 of Clubs.");
		add_page("As for the diamonds. Well you'll understand in due time.");
		add_page("Just know you'll want to collect some of those.");
		
		add_page("Now, why don't you draw another card.");
		add_page_action(global.tut_id.CheckIfOpTurn);
		
		add_page("I'm sorry to say, I knew this would happen.");
		add_page("Don't feel too bad. The player going first can't move their pieces on the first turn anyway.");
		add_page("Each time you draw a card, that card is replaced with a joker.");
		
		add_page("When you draw one, your turn is forfeit.");
		add_page_action(global.tut_id.SetupAnuTurn);
		
	}

}

function CheckForQueenPlayed()
{
	var tut_id = global.tut_id;
	var create_sidebars = method(id,global.tut_id.CreateSideBars);
	if(instance_exists(instance_find(oField,0).grid[4][5].myPiece)
	&&instance_find(oField,0).grid[4][5].myPiece.object_index==oQueenB
	&&instance_find(oField,0).grid[4][5].myPiece.Attack==2
	&&instance_find(oField,0).grid[4][5].myPiece.Health==8)
	{next_page();create_sidebars();}
}

function CheckIfOpTurn()
{
	if(instance_find(oMatchManager,0).pTurn==false){next_page();}
}

function SetupAnuTurn()
{
	var pet = instance_create_layer(0,760,"UILayer",oEndTurn);
	pet.pTurn=true;
	pet.depth = instance_find(oMatchManager,0).pBorderDepth-1;
	var opet = instance_create_layer(1400,60,"UILayer",oEndTurn);
	opet.depth = instance_find(oMatchManager,0).pBorderDepth-1;
	
	with(add_detatched_branch(true)){
		
		add_page("You can also click the End Turn button if you're the cautious type.");
		add_page("...But for now it's my turn.");
		add_page("Forgive me, I haven't introduced myself yet.");
		add_page("My name is Anu.");
		add_page("I will simply play this Queen of Diamonds for now and end my turn.");
		add_page_action(global.tut_id.AnuSelectsQueen);
		
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
	next_page();
}

function AnuPlaysQueen()
{
	instance_find(oField,0).grid[1][4].PlayPiece(false);
	
	with(instance_create_layer(x,y,"Text",eDialogManager))
	{
		voidsettings();
		tb_settings.x = TB_POS.CENTER2;
		tb_settings.x = TB_POS.CENTER2;
		
		add_page("Actually, I'd like to demonstrate something first.");
		add_page_action(global.tut_id.AnuSelects6H);
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
	next_page();
}

function AnuPlays6H()
{
	instance_find(oField,0).grid[1][4].UpgradePiece(false);
	
	with(instance_create_layer(x,y,"Text",eDialogManager)){
		voidsettings();
		tb_settings.x = TB_POS.CENTER2;
		tb_settings.x = TB_POS.CENTER2;
		
		add_page("If you click a heart or club card and then select a piece,");
		add_page("it will gain the associated health or power respectively.");
		add_page("And with that, I will conclude my turn.");
		add_page_action(global.tut_id.Players2ndTurn);
	}
}

function Players2ndTurn()
{
	instance_find(oField,0).ChangeTurns();
	
	with(add_detatched_branch(true)){
		
		add_page("Go ahead and draw a card... And fear not!");
		
		add_page("The first draw on a given turn is always on the house.");
		add_page_action(global.tut_id.CheckForAceOfSpades);
		
		add_page("Well done! The Ace of Spades!");
		
		add_page("Play that next to your king and see what happens.");
		add_page_action(global.tut_id.CheckAcePlayed);
		
		add_page("Aces manifest themselves as a graduated pawn.");
		add_page("Click on the pawn you just played.");
		
		add_page("Now click on the king icon.");
		add_page_action(global.tut_id.CheckFor2ndKing);
		
		add_page("In this game you can have as many kings as you wish,");
		add_page("But you must have at least one or it's game over!");
		
		add_page("Now, because you played an Ace of Spades it gave you 14 spade pips.");
		add_page_action(global.tut_id.SetupSpecialAbilities);
	}
}

function CheckForAceOfSpades()
{
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		if(global.pHand.cardsHeld[i].pips==14
			&&global.pHand.cardsHeld[i].spades==14)
		{next_page();}
	}
}

function CheckAcePlayed()
{
	if(instance_exists(instance_find(oField,0).grid[4][3].myPiece)
	&&instance_find(oField,0).grid[4][3].myPiece.object_index==oPawnW
	&&instance_find(oField,0).grid[4][3].myPiece.Attack==1
	&&instance_find(oField,0).grid[4][3].myPiece.Health==1)
	{next_page();}
}

function CheckFor2ndKing()
{
	if(instance_exists(instance_find(oField,0).grid[4][3].myPiece)
	&&instance_find(oField,0).grid[4][3].myPiece.object_index==oKingW
	&&instance_find(oField,0).grid[4][3].myPiece.Attack==1
	&&instance_find(oField,0).grid[4][3].myPiece.Health==1)
	{next_page();}
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
	
	with(add_detatched_branch(true)){
		add_page("Spade pips, or SP for short, allow you to use your special abilities.");
		add_page("If you hover over them, you can see a description of what each ability does.");
		
		add_page("Try inflicting your Pain ability on my queen.");
		add_page_action(global.tut_id.CheckPainOnQueen);
		
		add_page("Great! Now use your knight to attack it.");
		add_page_action(global.tut_id.CheckKnightAttacksQueen);
		
		add_page("In this game, you must lower the piece's health to 0 to capture.");
		
		add_page("Why not use your rook to capture my queen?");
		add_page_action(global.tut_id.CheckRookAttacksQueen);
		
		add_page("Allow me one more lesson before we finish here.");
		
		add_page("Do me the favor of drawing 4 more cards.");
		add_page_action(global.tut_id.Check10CInHand);
		
		add_page("Notice your 4 of Spades moved to the discard pile.");
		add_page("Your hand of cards is capped at 5. No exceptions.");
		add_page("It's not ideal, but we must make due with what we are given.");
		
		add_page("Move your 10 of Clubs to the position two right of the pawn.");
		add_page_action(global.tut_id.CheckBishopCreated);
		
		add_page("Now attack my only king and end the match.");
		add_page_action(global.tut_id.CheckKingDown);
	}
}

function CheckPainOnQueen()
{
	if(instance_find(oField,0).grid[1][4].myPiece.Health == 6)
	{next_page(); return ;}
}

function CheckKnightAttacksQueen()
{
	if(instance_find(oField,0).grid[1][4].myPiece.Health == 1)
	{next_page(); return ;}
}

function CheckRookAttacksQueen()
{
	if(instance_find(oField,0).grid[1][4].myPiece.object_index == oRookB)
	{next_page(); return;}
}

function Check10CInHand()
{
	for(var i=0;i<array_length(global.pHand.cardsHeld);i++)
	{
		if(global.pHand.cardsHeld[i].pips==10
			&&global.pHand.cardsHeld[i].clubs==10)
		{next_page();return;}
	}
}

function CheckBishopCreated()
{
	if(instance_exists(instance_find(oField,0).grid[3][7].myPiece)
	&&instance_find(oField,0).grid[3][7].myPiece.object_index==oBishopW
	&&instance_find(oField,0).grid[3][7].myPiece.Attack==10
	&&instance_find(oField,0).grid[3][7].myPiece.Health==1)
	{next_page();}
}

function CheckKingDown()
{
	var finalwords = method(id,global.tut_id.FinalWords);
	if(instance_find(oField,0).grid[0][4].myPiece.object_index == oBishopB)
	{finalwords();}
}

function FinalWords()
{
	with(add_detatched_branch(true)){
		add_page("There will be no checks nor mates here.");
		add_page("Nor any warnings of potential misfortunes.");
		add_page("Don't get careless.");
		add_page_action(global.tut_id.DefineForm);
	}
}

function DefineForm()
{
	next_page();
	var trans = instance_create_layer(0,0,"Text",oFadeTransition);
	trans.nextRoom = rPlayerProfileSetup;
}
