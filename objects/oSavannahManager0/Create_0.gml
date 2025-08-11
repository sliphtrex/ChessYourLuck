event_inherited();

//a temp selected card
ourCard=undefined;
//a temp selected piece
ourPiece=undefined;
//a temp selected spAb
ourSpAb=undefined;

matchOver=false;
defeated=false;
postMatchDialogue=0;

global.opCards=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51];
Setup();

//This will always be done after calling setup since these will always be diferent
OSA1 = instance_create_layer(1500, 650, "UILayer", oSpecialAbility);
OSA1.depth = opBorderDepth-2;
OSA1.specialAbility = 34;
OSA1.Setup();
OSA2 = instance_create_layer(1500, 500, "UILayer", oSpecialAbility);
OSA2.depth = opBorderDepth-2;
OSA2.specialAbility = 18;
OSA2.Setup();
OSA3 = instance_create_layer(1500, 350, "UILayer", oSpecialAbility);
OSA3.depth = opBorderDepth-2;
OSA3.specialAbility = 2;
OSA3.Setup();

/***********************************************************************************
* This is our AI's main state machine. This function decides how much weight gets
* put on different decisions and then makes a choice between them. From there it
* sends us to the function for that particular decision (i.e. draw card, move piece,
* etc.).
***********************************************************************************/
function TurnManager()
{	
	//set "end turn" as the first element in our array
	var options = undefined;
	//for each decision made the likelyhood of ending the turn increases
	for(var i=0; i<decisionsMade;i++)
	{
		if(options==undefined){options=[0];}
		else{array_push(options,0);}
	}
	
	//if our hand isn't full we can draw more
	if(array_length(global.opHand.cardsHeld)<5)
	{
		for(var i=0;i<draw_weight;i++)
		{
			if(options==undefined){options=[1];}
			else{array_push(options,1);}
		}
	}
	
	//if we have cards in our hand we can play cards
	if(array_length(global.opHand.cardsHeld)>0)
	{
		for(var i=0;i<play_weight;i++)
		{
			if(options==undefined){options=[2];}
			else{array_push(options,2);}
		}
	}
	
	//if we have more than 1 card in hand we may try to combine cards
	/*if(array_length(opHand.cardsHeld)>1)
	{
		for(var i=0;i<combine_weight;i++)
		{
			if(options==noone){options=[3];}
			else{array_push(options,3);}
		}
	}*/
	
	//check if we have moveable pieces
	var moveables=0;
	for(var i=0; i<array_length(field.blackPieces);i++)
	{
		if(field.blackPieces[i].hasMoved==false){moveables++;}
	}
	//if there are moveable pieces we'll add the possibility to the list
	if(moveables>0)
	{
		for(var i=0;i<move_weight;i++)
		{
			if(options==undefined){options=[4];}
			else{array_push(options,4);}
		}
	}
	
	//finally, let's check if we can use any special abilities
	var spAbsReady=0;
	if(OSA1.CheckIfUsable()){spAbsReady++;}
	if(OSA2.CheckIfUsable()){spAbsReady++;}
	if(OSA3.CheckIfUsable()){spAbsReady++;}
	//and add that option to the list
	if(spAbsReady>0)
	{
		for(var i=0;i<spAb_weight;i++)
		{
			if(options==undefined){options=[5];}
			else{array_push(options,5);}
		}
	}
	
	//pick an option from the options[]
	var choice = options[irandom_range(0,array_length(options)-1)];
	
	//this switch decides where we go from here
	//0 = end turn, 1 = draw a card, 2 = play a card, 3 = combine cards
	//4 = move a piece, 5 = use a special ability
	switch(choice)
	{
		case 1: DrawCard(); break;
		case 2: SelectCard(); break;
		case 4: ChoosePieceToMove(); break;
		case 5: ChooseSpAb(); break;
		
		default:
			show_debug_message("The AI has ended it's turn.");
			field.ChangeTurns();
		break;
	}
}

//this function determines what card to play and selects it
//could be more complex by giving the AI preferences for certain cards over others
function SelectCard()
{
	var choice = irandom_range(0,array_length(global.opHand.cardsHeld)-1);
	ourCard = global.opHand.cardsHeld[choice];
	global.opHand.cardSelected = ourCard;
	ourCard.selected=true;
	field.CardSelected();
	NextMove = PlayCard;
	alarm[0]=waitTime;
	show_debug_message("The AI chose the "+string(ourCard.pips)+" of "+string(ourCard.suit));
}

//this function determines whether to play a piece or upgrade one
//following up from SelectCard()
function PlayCard()
{
	/*
	* If our card has upgrade possibilities we want to weight that higher.
	* We will check this first and only check for other options if we don't
	* upgrade. This will save us time and space.
	*/
	
	//the tiles that contain our pieces
	var upgradableTiles = undefined;
	//we only want to upgrade if the selected card has clubs or hearts
	if(ourCard.suit==0||ourCard.suit==1
		||(ourCard.suit=-1&&(ourCard.clubs>0||ourCard.hearts>0)))
	{
		//I forgot I had the field.blackPieces var at first and originally looped the
		//whole grid. This is currently superfluous, but can be used to further weigh
		//things if, for example, a character has a preference of only upgrading kings
		for(var i=0;i<array_length(field.blackPieces);i++)
		{
			//add our pieces
			if(upgradableTiles==undefined){upgradableTiles=[field.blackPieces[i].myTile];}
			else{array_push(upgradableTiles,field.blackPieces[i].myTile);}
		}
		
		//set to a 3/4 chance of upgrading for testing purposes; will change later
		var weUpgrade = irandom_range(0,3);
		//if we have pieces to upgrade and we've chosen to upgrade... upgrade
		if(upgradableTiles!=undefined && weUpgrade>0)
		{
			show_debug_message("The AI upgraded a piece");
			upgradableTiles[irandom_range(0,array_length(upgradableTiles)-1)].UpgradePiece(false);
			
			//if we upgraded we can stop the function here
			ourCard=undefined;
			NextMove=undefined;
			alarm[0]=waitTime;
			return;
		}
	}
	
	//an array of selectable tiles
	var selectedTiles = undefined;
	//loop through the tiles and add any selectable ones to our array
	for(var i=0;i<2;i++)
	{
		for(var j=0;j<9;j++)
		{
			if(field.grid[i][j].selectable)
			{
				if(selectedTiles==undefined){selectedTiles=[field.grid[i][j]];}
				else{array_push(selectedTiles,field.grid[i][j]);}
			}
		}
	}
	//if we don't have open spaces to play pieces we can stop the function here
	if(selectedTiles==undefined)
	{
		show_debug_message("The AI rethought their decision.");
		ourCard=undefined;
		NextMove=undefined;
		alarm[0]=waitTime;
		return;
	}
	//Otherwise, we play the card to the field
	else
	{
		show_debug_message("The AI played a piece");
		selectedTiles[irandom_range(0,array_length(selectedTiles)-1)].PlayPiece(false);
		ourCard=undefined;
		NextMove=undefined;
		alarm[0]=waitTime;
		return;
	}
}

//This function picks a random piece to move and highlights it's move options
function ChoosePieceToMove()
{
	//check how many moveable pieces we have
	var moveables=undefined;
	for(var i=0; i<array_length(field.blackPieces);i++)
	{
		if(field.blackPieces[i].hasMoved==false)
		{
			if(moveables==undefined){moveables[0] = field.blackPieces[i];}
			else{array_push(moveables,field.blackPieces[i]);}
		}
	}
	
	//select one
	ourPiece = moveables[irandom_range(0,array_length(moveables)-1)];
	field.HighlightMoveableSpaces(ourPiece,ourPiece.row,ourPiece.column);
	NextMove = MovePiece;
	alarm[0] = waitTime;
	show_debug_message("The AI selected the "+string(ourPiece.object_index)+" at ("
		+string(ourPiece.row)+","+string(ourPiece.column)+")");
}

//This function moves the piece prioritizing attacking over random movement
function MovePiece()
{
	//check how many tiles we can move to
	var moveables = undefined;
	for(var i=0;i<5;i++)
	{
		for(var j=0;j<9;j++)
		{
			if(field.grid[i][j].selectable)
			{
				if(moveables==undefined){moveables[0]=field.grid[i][j];}
				else{array_push(moveables,field.grid[i][j]);}
			}
		}
	}
	//if we have spaces to move to...
	if(moveables!=undefined)
	{
		//we prioritize kings for the demo battle to ensure there's the possibility
		//for the AI to win
		var kings=undefined;
		for(var i=0;i<array_length(moveables);i++)
		{
			if(moveables[i].myPiece!=undefined && moveables[i].myPiece.object_index==oKingB)
			{
				if(kings==undefined){kings[0]=moveables[i];}
				else{array_push(kings,moveables[i]);}
			}
		}
		//we prioritize attacking after kings
		var pieces=undefined;
		for(var i=0;i<array_length(moveables);i++)
		{
			if(moveables[i].myPiece!=undefined && moveables[i].myPiece.object_index!=oKingB)
			{
				if(pieces==undefined){pieces[0]=moveables[i];}
				else{array_push(pieces,moveables[i]);}
			}
		}
		
		if(kings!=undefined)
		{
			//pick a gridTile...
			var moveSpace = kings[irandom_range(0,array_length(kings)-1)];
			//...and try to move there
			field.MovePieceToPlace(moveSpace.row,moveSpace.column);
			show_debug_message(string(ourPiece.object_index)+" moved to ("+string(moveSpace.row)+","+string(moveSpace.column)+")");
		}
		else if(pieces!=undefined)
		{
			//pick a gridTile...
			var moveSpace = pieces[irandom_range(0,array_length(pieces)-1)];
			//...and try to move there
			field.MovePieceToPlace(moveSpace.row,moveSpace.column);
			show_debug_message(string(ourPiece.object_index)+" moved to ("+string(moveSpace.row)+","+string(moveSpace.column)+")");
		}
		else
		{
			//pick a gridTile...
			var moveSpace = moveables[irandom_range(0,array_length(moveables)-1)];
			//...and try to move there
			field.MovePieceToPlace(moveSpace.row,moveSpace.column);
			show_debug_message(string(ourPiece.object_index)+" moved to ("+string(moveSpace.row)+","+string(moveSpace.column)+")");
		}
	}
	//Otherwise, let's do something else
	else
	{
		show_debug_message("The AI rethought their decision.");
	}
	
	ourPiece=undefined;
	NextMove=undefined;
	alarm[0]=waitTime;
}

function ChooseSpAb()
{
	var options = undefined;
	if(OSA1.CheckIfUsable())
	{
		if(options==undefined){options[0]=OSA1;}
		else{array_push(options,OSA1);}
	}
	if(OSA2.CheckIfUsable())
	{
		if(options==undefined){options[0]=OSA2;}
		else{array_push(options,OSA2);}
	}
	if(OSA3.CheckIfUsable())
	{
		if(options==undefined){options[0]=OSA3;}
		else{array_push(options,OSA3);}
	}
	
	if(OSA3.CheckIfUsable()){ourSpAb=OSA3;}
	else{ourSpAb = options[irandom_range(0,array_length(options)-1)];}
	if(ourSpAb==OSA2){show_debug_message("The AI used Philautia.");}
	if(ourSpAb==OSA3){show_debug_message("The AI used Society.");}
	
	ourSpAb.UseAbility();
	
	switch(ourSpAb.specialAbility)
	{
		case 0: case 14: case 34:
			NextMove = ChooseSpAbSpace;
		break;
		default:
			ourSpAb=undefined;
		break;
	}
	alarm[0] = waitTime;
}

function ChooseSpAbSpace()
{
	var selectables=undefined;
	
	for(var i=0;i<5;i++)
	{
		for(var j=0;j<9;j++)
		{
			if(field.grid[i][j].selectable)
			{
				if(selectables==undefined){selectables[0]=field.grid[i][j];}
				else{array_push(selectables,field.grid[i][j]);}
			}
		}
	}
	
	if(selectables==undefined)
	{
		show_debug_message("The AI rethought it's decision.");
	}
	else
	{
		var choice = selectables[irandom_range(0,array_length(selectables)-1)];
		switch(ourSpAb.specialAbility)
		{
			case 0:
				ourSpAb.UseAbility(choice);
			break;
			default:
				ourSpAb.UseAbility(choice.myPiece);
			break;
		}
		show_debug_message("The AI used Pain on ("+string(choice.row)+","+string(choice.column)+")");
	}
	
	ourSpAb=undefined;
	NextMove=undefined;
	alarm[0] = waitTime;
}

function MatchWin()
{
	global.playerDefeated=false;
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Oh man... I lost.",1);
		NextMove = EndMatch;
	}
}

function MatchDefeat()
{
	global.playerDefeated=true;
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Oh man... I won... cool.",1);
		NextMove = EndMatch;
	}
}

function EndMatch()
{
	var trans = instance_create_layer(0,0,"Text",oFadeTransition);
	trans.nextRoom = rRainyKnightsCafe;
}