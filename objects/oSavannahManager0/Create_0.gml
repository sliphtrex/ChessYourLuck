event_inherited();

//a temp selected card
ourCard=undefined;
//a temp selected piece
ourPiece=undefined;
//a temp selected spAb
ourSpAb=undefined;

//checks that step 2 is complete each turn
kingGoodThisTurn=false;
//we use this to cycle through our options of how to protect the king
kingsChoice=0;

global.opCards=global.SavannahsDecks[0];
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
	//1. Have we drawn a card this turn?
	if(global.opDeck.firstDraw)
	{
		//I. if our hand is full we need to play cards first
		if(array_length(global.opHand.cardsHeld)==5)
		{
			//i. if we have the QoC play that first
			if(CheckForQueenInHand()){return;}
			//ii. if we only have pawns we should use them
			else if(FindHighestRankCard().pips<5)
			{
				//A. check if pieces can be healed
				if(SuitInHand(1)!=undefined && SubOptimalHealth()!=undefined)
				{
					//a. heal the piece
					SelectCard(SuitInHand(1)[0]);
					Wait(UpgradePiece);
					return;
				}
				//B. combine cards if not
				else {CheckValidComboPairs(10); CombineCardPair(); return;}
			}
		}
		//II.Draw a card
		else{DrawCardFromDeck();}
	}
	//2. Is our king protected from the player?
	else if(!kingGoodThisTurn)
	{
		show_debug_message("king is in danger");
		//I. does the king have enough pieces surrounding it?
		if(!CheckKingSurrounded())
		{
			show_debug_message("surrounding the king");
			//i. start by playing the Queen of Clubs if we have it
			if(CheckForQueenInHand()){return;}
			//ii. otherwise we'll try to play a different card
			else
			{
				//A. if our hand isn't empty
				if(FindHighestRankCard()!=undefined)
				{
					//a. if we only have pawns, combine cards
					if(FindHighestRankCard().pips<5
						&& CheckValidComboPairs(10)!=undefined)
					{CombineCardPair(); return;}
					//b. otherwise, play our highest ranked piece
					else
					{
						SelectCard(FindHighestRankCard());
						Wait(OptimalSupportPlacement);
						return;
					}
				}
				//B. otherwise we'll risk drawing
				else{DrawCardFromDeck(); return;}
			}
		}
		//II. is there any piece of the player's that could attack the king?
		threatToKing = undefined;
		for(var i=0;i<array_length(field.whitePieces); i++)
		{
			moveableSpaces = field.whitePieces[i].GetMoveableSpaces();
			for(var j=0; j<array_length(moveableSpaces); j++)
			{
				if(moveableSpaces[j].myPiece!=undefined
					&&moveableSpaces[j].myPiece.object_index = oKingB)
				{
					if(threatToKing==undefined){threatToKing[0]=field.whitePieces[i];}
					else{array_push(threatToKing,field.whitePieces[i]);}
				}
			}
		}
		
		if(threatToKing!=undefined)
		{
			/******************************************************************
			* we can get to here, but no further
			******************************************************************/
			show_debug_message("threats to king");
			//i. spAbs?
			if(kingsChoice==0)
			{
				if(OSA1.CheckIfUsable())
				{
					show_debug_message("spabs");
					//attack the first piece on the list (then move onto ii)
				}
				kingsChoice++;
			}
			//ii. attack the piece with one of ours?
			else if(kingsChoice==1)
			{
				show_debug_message("attacking")
				//A. which of our pieces can attack this piece
				kingDefenders = undefined;
				for(var i=0; i<array_length(field.blackPieces); i++)
				{
					if(!field.blackPieces[i].hasMoved)
					{
						for(var j=0; j<array_length(field.blackPieces[i].GetMoveableSpaces());j++)
						{
							targetPiece = field.blackPieces[i].GetMoveableSpaces[j].myPiece;
							if(targetPiece==threatToKing[0])
							{
								if(kingDefenders==undefined){kingDefenders[0]=field.blackPieces[i]}
								else{array_push(kingDefenders,field.blackPieces[i]);}
							}
						}
					}
				}
				
				if(kingDefenders!=undefined)
				{
					show_debug_message("attacking with "+string(kingDefenders[0].object_index));
					ourPiece = kingDefenders[0];
					field.HighlightMoveableSpaces(ourPiece);
					Wait(MovePiece);
					return;
				}
				//B. repeat ^ until no more pieces
				else{kingsChoice++;show_debug_message("we're done here");}
			}
			//iii. play a piece to block them from the king?
			//Note: this (only works for bishop,rook,or queen)
				//a. which spaces can the target see?
				//b. where is the king in relation
				//c. what's the closest space to the king we can play the piece
		}
	}
	//3. Should we play more pieces on the board?
		//I. does our current piece count meet expectation? (if not iterate until yes)
			//i. if we only have pawns combine them
			//ii. play the highest ranked piece around the king
	//4. Can we attack the player's pieces?
		//I. what pieces can attack?
		//II. which pieces are they able to attack?
		//III. which of these pieces has the highest priority to attack
	//5. Miscellaneous actions
	/********************************************************
	* We should weigh VI higher, but this can be random.
	* Say a ratio of (1:1:1:3:1+n) where n is # of decisions
	* made already.
	*********************************************************/
		//I. can we advance any pawns?
			//i. do we have any pawns that haven't moved
		//II. can we use some more expensive spAbs?
		//III. can we heal any of our pieces?
			//i. do we have hearts in hand?
			//ii. do we have pieces with sub-optimal health?
		//VI. do we need to guard the king again?
			//i. does the king have enough pieces surrounding it?
				//A. play more from what's in hand (draw as needed)
			//ii. is there any piece of the player's that could attack the king?
				//A. what pieces can attack the king?
				//B. how can we stop that from happening?
					//a. play a piece to block them from the king?
						//aa. which spaces can the target see?
						//bb. where is the king in relation
						//cc. what's the closest space to the king we can play the piece
		//V. end turn
}

//The old Turn Manager that I'm working on upgrading
//will delete when finished
function TurnManager2()
{
	var options = undefined;
	
	//if we haven't drawn a card that's our objective
	if(global.opDeck.firstDraw)
	{
		//if our hand is full we need to discard cards so we can draw
		if(array_length(global.opHand.cardsHeld)==5)
		{
			//start by playing the Queen of Clubs if we have it
			if(CheckForQueenInHand()){return;}
			//next we'll try to build up defense around the king
			else if(!CheckKingSurrounded())
			{
				//if we only have pawns we'll combine cards
				if(FindHighestRankCard().pips<5
					&& CheckValidComboPairs(10)!=undefined)
				{CombineCardPair(); return;}
				//otherwise we'll play a piece
				else
				{
					SelectCard(FindHighestRankCard());
					Wait(OptimalSupportPlacement);
					return;
				}
			}
			//if we only have pawns combine cards
			else if(FindHighestRankCard().pips<5
				&& CheckValidComboPairs(10)!=undefined)
			{CombineCardPair();}
			//otherwise just play any piece to make space
			else{SelectCard(); Wait(PlayCard);}
		}
		//otherwise we can draw cards without discarding
		else{DrawCardFromDeck();}
	}
	//next we'll try to build up defense around the king
	else if(!CheckKingSurrounded())
	{
		//start by playing the Queen of Clubs if we have it
		if(CheckForQueenInHand()){return;}
		//otherwise we'll try to play a different card
		else
		{
			if(FindHighestRankCard()!=undefined)
			{
				//if we only have pawns combine cards
				if(FindHighestRankCard().pips<5
					&& CheckValidComboPairs(10)!=undefined)
				{CombineCardPair();}
				//otherwise, play our highest ranked piece
				else
				{
					SelectCard(FindHighestRankCard());
					Wait(OptimalSupportPlacement);
				}
			}
			else{DrawCardFromDeck();}
		}
	}
	
	//next we'll tackle movement
	/*else if(FindMoveablePieces()!=undefined)
	{
		
	}*/
	
	//if we have ample pieces we'll focus on other things
	//(moving pieces, attacking, combining for better cards, drawing, end turn)
	else
	{
		//weigh drawing cards
		if(array_length(global.opHand.cardsHeld)<5)
		{
			for(var i=0; i<=5-array_length(global.opHand.cardsHeld); i++)
			{
				if(options==undefined){options=[1];}
				else{array_push(options,1);}
			}
		}
		
		//weigh playing cards
		if(array_length(field.blackPieces)<5)
		{
			for(var i=0; i<=(5-array_length(field.blackPieces)); i++)
			{
				if(options==undefined){options=[2];}
				else{array_push(options,2);}
			}
		}
		
		//weigh combining cards
		if(CheckValidComboPairs(10)!=undefined)
		{
			for(var i=0; i=array_length(comboPairs); i++)
			{
				if(options==undefined){options=[3];}
				else{array_push(options,3);}
			}
		}
		
		//weigh moving pieces
		var movablePieces=0;
		for(var i=0; i<array_length(field.blackPieces);i++)
		{if(!field.blackPieces[i].hasMoved){movablePieces++;}}
		if(movablePieces>0)
		{
			for(var i=0; i=array_length(comboPairs); i++)
			{
				if(options==undefined){options=[4];}
				else{array_push(options,4);}
			}
		}
		
		//weigh spAbs
		var spAbsReady=0;
		if(OSA1.CheckIfUsable()){spAbsReady++;}
		if(OSA2.CheckIfUsable()){spAbsReady++;}
		if(OSA3.CheckIfUsable()){spAbsReady++;}
		
		if(spAbsReady>0)
		{
			for(var i=0;i<spAbsReady;i++)
			{
				if(options==undefined){options=[5];}
				else{array_push(options,5);}
			}
		}
		
		//weigh end turn
		var endTurnChance=0;
		if(array_length(options)>10){endTurnChance=1;}
		else if(array_length(options)>5){endTurnChance=2;}
		else {endTurnChance=3;}
		
		for(var i=0; i<endTurnChance; i++)
		{
			if(options==undefined){options=[0];}
			else{array_push(options,0);}
		}
		
		PickChoice(options);
	}
}

function CheckForQueenInHand()
{
	for(var i=0; i<array_length(global.opHand.cardsHeld); i++)
	{
		if(global.opHand.cardsHeld[i].card==11)
		{
			ourCard = global.opHand.cardsHeld[i];
			global.opHand.cardSelected = ourCard;
			ourCard.selected=true;
			field.CardSelected();
			Wait(OptimalQueenPlacement);
			return true;
		}
	}
	return false;
}

function CheckKingSurrounded()
{
	var adjacentPieces=0;
	
	for(var i=0;i<array_length(field.blackPieces);i++)
	{
		var myTile = field.blackPieces[i];
		if(myTile.object_index==oKingB)
		{
			var grid = field.grid;
			//create an array for each of the pieces located at our 8
			//bordering tiles
			borderingPieces[0] = (myTile.row>0&&myTile.column>0)
				? grid[myTile.row-1][myTile.column-1].myPiece : undefined;
			borderingPieces[1] = (myTile.row>0)
				? grid[myTile.row-1][myTile.column].myPiece : undefined;
			borderingPieces[2] = (myTile.row>0&&myTile.column<8)
				? grid[myTile.row-1][myTile.column+1].myPiece : undefined;
			borderingPieces[3] = (myTile.column>0)
				? grid[myTile.row][myTile.column-1].myPiece : undefined;
			borderingPieces[4] = (myTile.column<8)
				? grid[myTile.row][myTile.column+1].myPiece : undefined;
			borderingPieces[5] = (myTile.row<4&&myTile.column>0)
				? grid[myTile.row+1][myTile.column-1].myPiece : undefined;
			borderingPieces[6] = (myTile.row<4)
				? grid[myTile.row+1][myTile.column].myPiece : undefined;
			borderingPieces[7] = (myTile.row<4&&myTile.column<8)
				? grid[myTile.row+1][myTile.column+1].myPiece : undefined;
					
			for(var j=0;j<8;j++)
			{
				if(borderingPieces[j]!=undefined
					&& object_is_ancestor(borderingPieces[j].object_index,oChessPieceB))
				{
					adjacentPieces++;
				}
			}
			
			if(array_length(field.whitePieces)>=7 && adjacentPieces>=5){return true;}
			else if(array_length(field.whitePieces)>=5 && adjacentPieces>=4){return true;}
			else if(adjacentPieces>1) {return true;}
			return false;
		}
	}
	return false;
}

function OptimalQueenPlacement()
{
	var grid = field.grid;
	
	if(!CheckKingSurrounded())
	{
		var myTile = undefined;
		
		for(var i=0;i<array_length(field.blackPieces);i++)
		{if(field.blackPieces[i].object_index==oKingB)
			{myTile = field.blackPieces[i].myTile; break;}}
	
		if(myTile.row<4 && grid[myTile.row+1][myTile.column].myPiece==undefined)
		{grid[myTile.row+1][myTile.column].PlayPiece(false);}
		else if((myTile.row<4&&myTile.column<8 && grid[myTile.row+1][myTile.column+1].myPiece==undefined))
		{grid[myTile.row+1][myTile.column+1].PlayPiece(false);}
		else if(myTile.row<4&&myTile.column>0 && grid[myTile.row+1][myTile.column-1].myPiece==undefined)
		{grid[myTile.row+1][myTile.column-1].PlayPiece(false);}
		else if(myTile.column>0 && grid[myTile.row][myTile.column-1].myPiece==undefined)
		{grid[myTile.row][myTile.column-1].PlayPiece(false);}
		else if(myTile.column<8 && grid[myTile.row][myTile.column+1].myPiece==undefined)
		{grid[myTile.row][myTile.column+1].PlayPiece(false);}
		else if(myTile.row>0 && grid[myTile.row-1][myTile.column].myPiece==undefined)
		{grid[myTile.row-1][myTile.column].PlayPiece(false);}
		else if(myTile.row>0&&myTile.column<8 && grid[myTile.row-1][myTile.column+1].myPiece==undefined)
		{grid[myTile.row-1][myTile.column+1].PlayPiece(false);}
		else if(myTile.row>0&&myTile.column>0 && grid[myTile.row-1][myTile.column-1].myPiece==undefined)
		{grid[myTile.row-1][myTile.column-1].PlayPiece(false);}
	}
	else
	{
		if(grid[1][4].myPiece==undefined){grid[1][4].PlayPiece(false);}
		else if(grid[0][4].myPiece==undefined){grid[0][4].PlayPiece(false);}
		else if(grid[1][5].myPiece==undefined){grid[1][5].PlayPiece(false);}
		else if(grid[0][5].myPiece==undefined){grid[0][5].PlayPiece(false);}
		else if(grid[1][3].myPiece==undefined){grid[1][3].PlayPiece(false);}
		else if(grid[0][3].myPiece==undefined){grid[0][3].PlayPiece(false);}
		else if(grid[1][6].myPiece==undefined){grid[1][6].PlayPiece(false);}
		else if(grid[0][6].myPiece==undefined){grid[0][6].PlayPiece(false);}
		else if(grid[1][2].myPiece==undefined){grid[1][2].PlayPiece(false);}
		else if(grid[0][2].myPiece==undefined){grid[0][2].PlayPiece(false);}
		else if(grid[1][7].myPiece==undefined){grid[1][7].PlayPiece(false);}
		else if(grid[1][1].myPiece==undefined){grid[1][1].PlayPiece(false);}
		else if(grid[1][8].myPiece==undefined){grid[1][8].PlayPiece(false);}
		else if(grid[1][0].myPiece==undefined){grid[1][0].PlayPiece(false);}
		else if(grid[0][7].myPiece==undefined){grid[0][7].PlayPiece(false);}
		else if(grid[0][1].myPiece==undefined){grid[0][1].PlayPiece(false);}
		else if(grid[0][8].myPiece==undefined){grid[0][8].PlayPiece(false);}
		else if(grid[0][0].myPiece==undefined){grid[0][0].PlayPiece(false);}
	}
	
	Wait();
}

function OptimalSupportPlacement()
{
	var grid = field.grid;
	
	if(!CheckKingSurrounded())
	{
		var myTile = undefined;
		
		for(var i=0;i<array_length(field.blackPieces);i++)
		{if(field.blackPieces[i].object_index==oKingB)
			{myTile = field.blackPieces[i]; break;}}
		
		//hierarchy for pawn placement
		if(ourCard.pips<5)
		{
			//start with sides
			if(myTile.column>0 && grid[myTile.row][myTile.column-1].myPiece==undefined)
			{grid[myTile.row][myTile.column-1].PlayPiece(false);}
			else if(myTile.column<8 && grid[myTile.row][myTile.column+1].myPiece==undefined)
			{grid[myTile.row][myTile.column+1].PlayPiece(false);}
			//then check forward diagonals
			else if((myTile.row<4&&myTile.column<8 && grid[myTile.row+1][myTile.column+1].myPiece==undefined))
			{grid[myTile.row+1][myTile.column+1].PlayPiece(false);}
			else if(myTile.row<4&&myTile.column>0 && grid[myTile.row+1][myTile.column-1].myPiece==undefined)
			{grid[myTile.row+1][myTile.column-1].PlayPiece(false);}
			//then check front and center
			else if(myTile.row<4 && grid[myTile.row+1][myTile.column].myPiece==undefined)
			{grid[myTile.row+1][myTile.column].PlayPiece(false);}
			//then check our 6:00
			else if(myTile.row>0 && grid[myTile.row-1][myTile.column].myPiece==undefined)
			{grid[myTile.row-1][myTile.column].PlayPiece(false);}
			//lastly check back facing diagonals
			else if(myTile.row>0&&myTile.column<8 && grid[myTile.row-1][myTile.column+1].myPiece==undefined)
			{grid[myTile.row-1][myTile.column+1].PlayPiece(false);}
			else if(myTile.row>0&&myTile.column>0 && grid[myTile.row-1][myTile.column-1].myPiece==undefined)
			{grid[myTile.row-1][myTile.column-1].PlayPiece(false);}
		}
		//hierarchy for knights
		else if(ourCard.pips<8)
		{
			//check forward diagonals
			if((myTile.row<4&&myTile.column<8 && grid[myTile.row+1][myTile.column+1].myPiece==undefined))
			{grid[myTile.row+1][myTile.column+1].PlayPiece(false);}
			else if(myTile.row<4&&myTile.column>0 && grid[myTile.row+1][myTile.column-1].myPiece==undefined)
			{grid[myTile.row+1][myTile.column-1].PlayPiece(false);}
			//then check our 6:00
			else if(myTile.row>0 && grid[myTile.row-1][myTile.column].myPiece==undefined)
			{grid[myTile.row-1][myTile.column].PlayPiece(false);}
			//then check back facing diagonals
			else if(myTile.row>0&&myTile.column<8 && grid[myTile.row-1][myTile.column+1].myPiece==undefined)
			{grid[myTile.row-1][myTile.column+1].PlayPiece(false);}
			else if(myTile.row>0&&myTile.column>0 && grid[myTile.row-1][myTile.column-1].myPiece==undefined)
			{grid[myTile.row-1][myTile.column-1].PlayPiece(false);}
			//then check sides
			else if(myTile.column>0 && grid[myTile.row][myTile.column-1].myPiece==undefined)
			{grid[myTile.row][myTile.column-1].PlayPiece(false);}
			else if(myTile.column<8 && grid[myTile.row][myTile.column+1].myPiece==undefined)
			{grid[myTile.row][myTile.column+1].PlayPiece(false);}
			//then check front and center
			else if(myTile.row<4 && grid[myTile.row+1][myTile.column].myPiece==undefined)
			{grid[myTile.row+1][myTile.column].PlayPiece(false);}
		}
		//we only have bishops left since we'll only combine up to rank 10
		else
		{
			//check forward diagonals
			if((myTile.row<4&&myTile.column<8 && grid[myTile.row+1][myTile.column+1].myPiece==undefined))
			{grid[myTile.row+1][myTile.column+1].PlayPiece(false);}
			else if(myTile.row<4&&myTile.column>0 && grid[myTile.row+1][myTile.column-1].myPiece==undefined)
			{grid[myTile.row+1][myTile.column-1].PlayPiece(false);}
			//then check front and center
			else if(myTile.row<4 && grid[myTile.row+1][myTile.column].myPiece==undefined)
			{grid[myTile.row+1][myTile.column].PlayPiece(false);}
			//then check our 6:00
			else if(myTile.row>0 && grid[myTile.row-1][myTile.column].myPiece==undefined)
			{grid[myTile.row-1][myTile.column].PlayPiece(false);}
			//then check back facing diagonals
			else if(myTile.row>0&&myTile.column<8 && grid[myTile.row-1][myTile.column+1].myPiece==undefined)
			{grid[myTile.row-1][myTile.column+1].PlayPiece(false);}
			else if(myTile.row>0&&myTile.column>0 && grid[myTile.row-1][myTile.column-1].myPiece==undefined)
			{grid[myTile.row-1][myTile.column-1].PlayPiece(false);}
			//then check sides
			else if(myTile.column>0 && grid[myTile.row][myTile.column-1].myPiece==undefined)
			{grid[myTile.row][myTile.column-1].PlayPiece(false);}
			else if(myTile.column<8 && grid[myTile.row][myTile.column+1].myPiece==undefined)
			{grid[myTile.row][myTile.column+1].PlayPiece(false);}
		}
	}
	else
	{
		//hierarchy for pawn placement
		if(ourCard.pips<5)
		{
			//start with edges and work our way in; front row takes priority
			if(grid[1][0].myPiece==undefined){grid[1][0].PlayPiece(false);}
			else if(grid[1][8].myPiece==undefined){grid[1][8].PlayPiece(false);}
			else if(grid[1][1].myPiece==undefined){grid[1][1].PlayPiece(false);}
			else if(grid[1][7].myPiece==undefined){grid[1][7].PlayPiece(false);}
			else if(grid[1][2].myPiece==undefined){grid[1][2].PlayPiece(false);}
			else if(grid[1][6].myPiece==undefined){grid[1][6].PlayPiece(false);}
			else if(grid[1][3].myPiece==undefined){grid[1][3].PlayPiece(false);}
			else if(grid[1][5].myPiece==undefined){grid[1][5].PlayPiece(false);}
			else if(grid[1][4].myPiece==undefined){grid[1][4].PlayPiece(false);}
			else if(grid[0][0].myPiece==undefined){grid[0][0].PlayPiece(false);}
			else if(grid[0][8].myPiece==undefined){grid[0][8].PlayPiece(false);}
			else if(grid[0][1].myPiece==undefined){grid[0][1].PlayPiece(false);}
			else if(grid[0][7].myPiece==undefined){grid[0][7].PlayPiece(false);}
			else if(grid[0][2].myPiece==undefined){grid[0][2].PlayPiece(false);}
			else if(grid[0][6].myPiece==undefined){grid[0][6].PlayPiece(false);}
			else if(grid[0][3].myPiece==undefined){grid[0][3].PlayPiece(false);}
			else if(grid[0][5].myPiece==undefined){grid[0][5].PlayPiece(false);}
			else if(grid[0][4].myPiece==undefined){grid[0][4].PlayPiece(false);}
		}
		//hierarchy for knights
		else if(ourCard.pips<8)
		{
			//middle front row takes priority since we want to maximize mobility
			if(grid[1][4].myPiece==undefined){grid[1][4].PlayPiece(false);}
			else if(grid[1][5].myPiece==undefined){grid[1][5].PlayPiece(false);}
			else if(grid[1][3].myPiece==undefined){grid[1][3].PlayPiece(false);}
			else if(grid[1][6].myPiece==undefined){grid[1][6].PlayPiece(false);}
			else if(grid[1][2].myPiece==undefined){grid[1][2].PlayPiece(false);}
			else if(grid[1][7].myPiece==undefined){grid[1][7].PlayPiece(false);}
			else if(grid[1][1].myPiece==undefined){grid[1][1].PlayPiece(false);}
			else if(grid[1][8].myPiece==undefined){grid[1][8].PlayPiece(false);}
			else if(grid[1][0].myPiece==undefined){grid[1][0].PlayPiece(false);}
			else if(grid[0][4].myPiece==undefined){grid[0][4].PlayPiece(false);}
			else if(grid[0][5].myPiece==undefined){grid[0][5].PlayPiece(false);}
			else if(grid[0][3].myPiece==undefined){grid[0][3].PlayPiece(false);}
			else if(grid[0][6].myPiece==undefined){grid[0][6].PlayPiece(false);}
			else if(grid[0][2].myPiece==undefined){grid[0][2].PlayPiece(false);}
			else if(grid[0][7].myPiece==undefined){grid[0][7].PlayPiece(false);}
			else if(grid[0][1].myPiece==undefined){grid[0][1].PlayPiece(false);}
			else if(grid[0][8].myPiece==undefined){grid[0][8].PlayPiece(false);}
			else if(grid[0][0].myPiece==undefined){grid[0][0].PlayPiece(false);}
		}
		//we only have bishops left since we'll only combine up to rank 10
		else
		{
			//we'll prioritize corners first because we can reach the king from there
			if(grid[0][0].myPiece==undefined){grid[0][0].PlayPiece(false);}
			else if(grid[0][8].myPiece==undefined){grid[0][8].PlayPiece(false);}
			//then inside corners for the same reason
			else if(grid[1][1].myPiece==undefined){grid[1][1].PlayPiece(false);}
			else if(grid[1][7].myPiece==undefined){grid[1][7].PlayPiece(false);}
			//after that is mobility: 8
			else if(grid[0][4].myPiece==undefined){grid[0][4].PlayPiece(false);}
			else if(grid[1][3].myPiece==undefined){grid[1][3].PlayPiece(false);}
			else if(grid[1][5].myPiece==undefined){grid[1][5].PlayPiece(false);}
			else if(grid[1][4].myPiece==undefined){grid[1][4].PlayPiece(false);}
			//7
			else if(grid[0][3].myPiece==undefined){grid[0][3].PlayPiece(false);}
			else if(grid[0][5].myPiece==undefined){grid[0][5].PlayPiece(false);}
			else if(grid[1][2].myPiece==undefined){grid[1][2].PlayPiece(false);}
			else if(grid[1][6].myPiece==undefined){grid[1][6].PlayPiece(false);}
			//6
			else if(grid[0][2].myPiece==undefined){grid[0][2].PlayPiece(false);}
			else if(grid[0][6].myPiece==undefined){grid[0][6].PlayPiece(false);}
			//5
			else if(grid[0][1].myPiece==undefined){grid[0][1].PlayPiece(false);}
			else if(grid[0][7].myPiece==undefined){grid[0][7].PlayPiece(false);}
			//4
			else if(grid[1][0].myPiece==undefined){grid[1][0].PlayPiece(false);}
			else if(grid[1][8].myPiece==undefined){grid[1][8].PlayPiece(false);}
		}
	}
	
	Wait();
}

//returns the highest ranking piece with sub optimal health
function SubOptimalHealth()
{
	highestRankedPiece=undefined;
	for(var i=0; i<array_length(field.blackPieces); i++)
	{
		if(field.blackPieces[i].object_index==oKingB
			&&field.blackPieces[i].Health<10)
		{highestRankedPiece = field.blackPieces[i];}
		else if(highestRankedPiece.object_index!=oKingB
			&&field.blackPieces[i].object_index==oQueenB
			&&field.blackPieces[i].Health<3)
		{highestRankedPiece = field.blackPieces[i];}
		else if(highestRankedPiece.object_index!=(oKingB||oQueenB)
			&&field.blackPieces[i].object_index==oBishopB
			&&field.blackPieces[i].Health<3)
		{highestRankedPiece = field.blackPieces[i];}
		else if(highestRankedPiece.object_index!=(oKingB||oQueenB||oBishopB)
			&&field.blackPieces[i].object_index==oKnightB
			&&field.blackPieces[i].Health<3)
		{highestRankedPiece = field.blackPieces[i];}
	}
	return highestRankedPiece;
}

function PickChoice(op)
{
	decisionsMade++;
	//pick an option from the options[]
	var choice = op[irandom_range(0,array_length(op)-1)];
	
	//this switch decides where we go from here
	//0 = end turn, 1 = draw a card, 2 = play a card, 3 = combine cards
	//4 = move a piece, 5 = use a special ability
	switch(choice)
	{
		case 1: DrawCardFromDeck(); break;
		case 2: SelectCard(); Wait(PlayCard()) break;
		case 3: CombineCardPair(); break;
		case 4: ChoosePieceToMove(); break;
		case 5: ChooseSpAb(); break;
		
		default:
			show_debug_message("The AI has ended it's turn.");
			field.ChangeTurns();
		break;
	}
}

function CombineCardPair()
{
	var choice = irandom_range(0,array_length(comboPairs)-1);
	global.opHand.c1 = global.opHand.cardsHeld[comboPairs[choice][0]];
	global.opHand.c2 = global.opHand.cardsHeld[comboPairs[choice][1]];
	show_debug_message("c1: "+string(global.opHand.c1));
	show_debug_message("c2: "+string(global.opHand.c2));
	global.opHand.CombineCards();
	NextMove=undefined;
	alarm[0]=waitTime;
}

function FindMoveablePieces()
{
	moveablePieces = undefined;
	for(var i=0; i<array_length(field.blackPieces); i++)
	{
		if(!field.blackPieces[i].hasMoved
			&& field.blackPieces[i].object_index!= oKingB)
		{
			if(moveablePieces==undefined){moveablePieces[0]=field.blackPieces[i];}
			else{array_push(moveablePieces,field.blackPieces[i]);}
		}
	}
	return moveablePieces;
}

function PlayCard()
{
	
	
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
	
	//select one if we have one
	if(moveables!=undefined)
	{
		ourPiece = moveables[irandom_range(0,array_length(moveables)-1)];
		field.HighlightMoveableSpaces(ourPiece);
		NextMove = MovePiece;
		alarm[0] = waitTime;
		show_debug_message("The AI selected the "+string(ourPiece.object_index)+" at ("
			+string(ourPiece.row)+","+string(ourPiece.column)+")");
	}
	else
	{
		//we have no moveable pieces so make a new choice
		decisionsMade--;
		NextMove=undefined;
		alarm[0]=waitTime;
		return;
	}
	
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
	show_debug_message("made it to MatchWin.");
	global.playerDefeated=false;
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Oh man... I lost.",1);
		NextMove = EndMatch;
	}
}

function MatchDefeat()
{
	show_debug_message("made it to MatchDefeat.");
	global.playerDefeated=true;
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Oh man... I won... cool.",1);
		NextMove = EndMatch;
	}
}

function EndMatch()
{
	global.postMatch=true;
	var trans = instance_create_layer(0,0,"Text",oFadeTransition);
	trans.nextRoom = rRainyKnightsCafe;
}