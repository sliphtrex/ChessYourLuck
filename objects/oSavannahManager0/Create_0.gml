event_inherited();

//have we checked our threats this turn
threatAssessmentDone=false;
//pieces that can attack the king
threatToKing=undefined;
//checks that step 3 is complete each turn
kingGoodThisTurn=false;
//we use this to cycle through our options of how to protect the king
kingsChoice=0;
//holds a reference to the Queen of clubs once played
queen=undefined;
//has the queen been played yet.
queenPlayed=false;
//checks that step 2 is complete each turn
queenGoodThisTurn=false;

global.opCards=global.SavannahsDecks[0];
Setup();

//This will always be done after calling setup since these will always be diferent
OSA1 = instance_create_layer(room_width-100, 650, "UILayer", oSpecialAbility);
OSA1.depth = opBorderDepth-2;
OSA1.specialAbility = 34;
OSA1.Setup();
OSA2 = instance_create_layer(room_width-100, 500, "UILayer", oSpecialAbility);
OSA2.depth = opBorderDepth-2;
OSA2.specialAbility = 18;
OSA2.Setup();
OSA3 = instance_create_layer(room_width-100, 350, "UILayer", oSpecialAbility);
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
	//1. Do we have pawns to graduate?
	for(var i=0;i<array_length(field.blackPieces);i++)
	{
		if(field.blackPieces[i].object_index==oPawnB
			&&field.blackPieces[i].graduated==true)
		{
			show_debug_message("[1]");
			//I. If we have a queen or the QC hasn't been played yet: bishop
			if(queen!=undefined||queenPlayed==false)
			{
				field.blackPieces[i].myTile.GraduatePawn(field.blackPieces[i],1);
				
				tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
				tb.text = "Join the party, bestie!";
				tb.bg = sprSavannahVoidTextBox;
				tb.color = #8c52ff;
			}
			//II. Otherwise, make this pawn the new queen.
			else
			{
				field.blackPieces[i].myTile.GraduatePawn(field.blackPieces[i],3);
				queen = field.blackPieces[array_length(field.blackPieces)-1];
				
				var tb = instance_create_layer(x,y,"Text",oMatchTextBox);
				tb.text = "The Queen is back baby!";
				tb.type = 1;
				tb.textDuration=3;
				tb.x=(room_width/2)-((string_width("The Queen is back baby!")+tb.border)/2);
				tb.y=200;
				tb.bg = sprSavannahVoidTextBox;
				tb.color = #8c52ff;
			}
		}
	}
	//2. Have we drawn a card this turn?
	if(global.opDeck.firstDraw)
	{
		show_debug_message("[2]");
		
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
					//response
					var text="";
					var dialogue=irandom(3);
					if(dialogue==0){text="Peace.";}
					else if(dialogue==1){text="Love.";}
					else if(dialogue==2){text="Unity.";}
					else{text="Respect.";}
					
					var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
					tb.text = text;
					tb.bg = sprSavannahVoidTextBox;
					tb.color = #8c52ff;
					
					Wait(UpgradePiece);
					return;
				}
				//B. combine cards if not
				else {CombineCardPair(); return;}
			}
			//iii. otherwise, we'll play our highest ranked piece
			else
			{
				SelectCard(FindHighestRankCard());
				Wait(OptimalSupportPlacement);
				return;
			}
		}
		//II.Draw a card
		else{DrawCardFromDeck([11]);}
	}
	//3. Is the Queen healthy?
	else if(queen!=undefined && !queenGoodThisTurn)
	{
		show_debug_message("[3]");
		
		//I. Try to use Philautia if we can
		if(queen.Health<10 && OSA3.CheckIfUsable())
		{
			OSA3.UseAbility();
				
			var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
			tb.text = "Work hard, then... Treat yourself, girl!";
			tb.bg = sprSavannahVoidTextBox;
			tb.color = #8c52ff;
			queenGoodThisTurn=true;
			//we only return here because the oSpAbAnim should take care of Waiting
			return;
		}
		//II. Otherwise, use hearts.
		else if(queen.Health<10 && (cardsDrawn<1||SuitInHand(1)!=undefined))
		{
			//i. If we have hearts
			if(SuitInHand(1)!=undefined)
			{
				//A. Heal the queen
				SelectCard(SuitInHand(1)[0]);
				//we only want to heal the queen once per turn.
				queenGoodThisTurn=true;
				
				//response
				var text="";
				var dialogue=irandom(3);
				if(dialogue==0){text="Peace.";}
				else if(dialogue==1){text="Love.";}
				else if(dialogue==2){text="Unity.";}
				else{text="Respect.";}
					
				var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
				tb.text = text;
				tb.bg = sprSavannahVoidTextBox;
				tb.color = #8c52ff;
				
				Wait(UpgradePiece);
			}
			//ii. Otherwise, draw a card.
			else{DrawCardFromDeck();}
		}
		//III. Otherwise, let's move on.
		else
		{queenGoodThisTurn=true; Wait();}
	}
	//4. Is our king protected from the player?
	else if(!kingGoodThisTurn)
	{
		show_debug_message("[4]");
		//I. Try to use Society if we can
		if(OSA2.CheckIfUsable())
		{
			OSA2.UseAbility();
				
			var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
			tb.text = "Ride or die bitches!";
			tb.bg = sprSavannahVoidTextBox;
			tb.color = #8c52ff;
			queenGoodThisTurn=true;
			//we only return here because the oSpAbAnim should take care of Waiting
			return;
		}
		
		//II. does the king have enough pieces surrounding it?
		if(!CheckKingSurrounded())
		{
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
		
		//III. is there any piece of the player's that could attack the king?
		if(!threatAssessmentDone)
		{
			threatToKing=undefined
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
			threatAssessmentDone=true;
		}
		
		if(threatToKing!=undefined && array_length(threatToKing)>0)
		{
			//i. spAbs?
			if(kingsChoice==0)
			{
				//attack the first piece on the list (then move onto ii)
				if(OSA1.CheckIfUsable() && OSA1use==0)
				{
					var popAfter=false;
					if(threatToKing[0].Health==1&&threatToKing[0].pragma==false){popAfter=true;}
					OSA1.UseAbility(threatToKing[0]);
					OSA1use++;
					
					var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
					tb.text = "How do YOU like it?";
					tb.bg = sprSavannahVoidTextBox;
					tb.color = #8c52ff;
					
					if(popAfter){array_delete(threatToKing,0,1);}
					kingsChoice++;
					
					//we only return here because the oSpAbAnim should take care of Waiting
					return;
				}
				kingsChoice++;
				Wait();
				return;
			}
			//ii. attack the piece with one of ours?
			else if(kingsChoice==1)
			{
				//A. which of our pieces can attack this piece
				kingDefenders = undefined;
				for(var i=0; i<array_length(field.blackPieces); i++)
				{
					if(!field.blackPieces[i].hasMoved)
					{
						for(var j=0; j<array_length(field.blackPieces[i].GetMoveableSpaces());j++)
						{
							targetPiece = field.blackPieces[i].GetMoveableSpaces()[j].myPiece;
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
					ourPiece = kingDefenders[0];
					field.HighlightMoveableSpaces(ourPiece);
					Wait(AttackPiece);
					return;
				}
				//B. repeat ^ until no more pieces
				else
				{
					kingsChoice++;
					Wait();
					return;
				}
			}
			//iii. play a piece to block them from the king?
			else if(kingsChoice==2)
			{
				if(FindHighestRankCard()!=undefined)
				{
					//a. where is the king in relation to our threat
					kingRow=undefined;
					kingColumn=undefined;
					seenSpace = threatToKing[0].GetMoveableSpaces();
					for(var i=0;i<array_length(seenSpace);i++)
					{
						if(seenSpace[i].myPiece!=undefined
							&& seenSpace[i].myPiece.object_index == oKingB)
						{
							kingRow = seenSpace[i].row;
							kingColumn = seenSpace[i].column;
							break;
						}
					}
					
					//b. (if we can) where do we place the piece in relation?
					//block top left
					if(kingColumn-threatToKing[0].column>1
						&& kingRow-threatToKing[0].row==kingColumn-threatToKing[0].column
						&& threatToKing[0].row==0)
					{
						SelectCard(FindHighestRankCard());
						field.grid[kingRow-1][kingColumn-1].PlayPiece(false);
						//field.grid[kingRow-1][kingColumn-1].myPiece.hasMoved = true;
						array_delete(threatToKing,0,1);
						Wait();
						return;
					}
					//block above
					else if(threatToKing[0].row==0 
						&& kingRow-threatToKing[0].row>1
						&& kingRow==threatToKing[0].row)
					{
						SelectCard(FindHighestRankCard());
						field.grid[kingRow-1][kingColumn].PlayPiece(false);
						//field.grid[kingRow-1][kingColumn].myPiece.hasMoved = true;
						array_delete(threatToKing,0,1);
						Wait();
						return;
					}
					//block top right
					else if(threatToKing[0].column-kingColumn>1
						&& kingRow-threatToKing[0].row==threatToKing[0].column-kingColumn
						&& threatToKing[0].row == 0)
					{
						SelectCard(FindHighestRankCard());
						field.grid[kingRow-1][kingColumn+1].PlayPiece(false);
						//field.grid[kingRow-1][kingColumn+1].myPiece.hasMoved = true;
						array_delete(threatToKing,0,1);
						Wait();
						return;
					}
					//block right
					else if(threatToKing[0].column-kingColumn>1
						&& kingRow==threatToKing[0].row &&kingRow<2)
					{
						SelectCard(FindHighestRankCard());
						field.grid[kingRow][kingColumn+1].PlayPiece(false);
						//field.grid[kingRow][kingColumn+1].myPiece.hasMoved = true;
						array_delete(threatToKing,0,1);
						Wait();
						return;
					}
					//block bottom right
					else if(threatToKing[0].column-kingColumn>1
						&& threatToKing[0].row-kingRow==threatToKing[0].column-kingColumn
						&& kingRow == 0)
					{
						SelectCard(FindHighestRankCard());
						field.grid[kingRow+1][kingColumn+1].PlayPiece(false);
						//field.grid[kingRow+1][kingColumn+1].myPiece.hasMoved = true;
						array_delete(threatToKing,0,1);
						Wait();
						return;
					}
					//block below
					else if(threatToKing[0].row-kingRow>1
						&& threatToKing[0].column==kingColumn
						&& kingRow==0)
					{
						SelectCard(FindHighestRankCard());
						field.grid[kingRow+1][kingColumn].PlayPiece(false);
						//field.grid[kingRow+1][kingColumn].myPiece.hasMoved = true;
						array_delete(threatToKing,0,1);
						Wait();
						return;
					}
					//block bottom left
					else if(kingColumn-threatToKing[0].column>1
						&& threatToKing[0].row-kingRow==kingColumn-threatToKing[0].column
						&& kingRow == 0)
					{
						SelectCard(FindHighestRankCard());
						field.grid[kingRow+1][kingColumn-1].PlayPiece(false);
						//field.grid[kingRow+1][kingColumn-1].myPiece.hasMoved = true;
						array_delete(threatToKing,0,1);
						Wait();
						return;
					}
					//block left
					else if(kingColumn-threatToKing[0].column>1
						&& kingRow==threatToKing[0].row && kingRow<2)
					{
						SelectCard(FindHighestRankCard());
						field.grid[kingRow][kingColumn-1].PlayPiece(false);
						//field.grid[kingRow][kingColumn-1].myPiece.hasMoved = true;
						array_delete(threatToKing,0,1);
						Wait();
						return;
					}
					//if there's no place to block then we're done
					else{kingsChoice++; Wait();}
				}
				//if our hand is empty we can draw
				else{DrawCardFromDeck();}
			}
			//iv. We can't fight anymore, so heal using Society if we can.
			else if(kingsChoice==3 && OSA3.CheckIfUsable())
			{
				OSA3.UseAbility();
				
				var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
				tb.text = "Friends stick together!";
				tb.bg = sprSavannahVoidTextBox;
				tb.color = #8c52ff;
				
				kingGoodThisTurn=true;
				kingsChoice=0;
				Wait();
			}
			//v. Otherwise, we're done here!
			else{kingGoodThisTurn=true; kingsChoice=0; Wait();}
		}
		else{kingGoodThisTurn=true; kingsChoice=0; Wait();}
	}
	//5. Move the pieces we can, prioritizing attacking.
	moveablePieces = FindMoveablePieces();
	if(kingGoodThisTurn && moveablePieces!=undefined)
	{
		show_debug_message("[5]");
		
		//I. Can we attack the player's pieces?
		for(var i=0;i<array_length(moveablePieces);i++)
		{
			moveableSpaces = moveablePieces[i].GetMoveableSpaces();
			for(var j=0; j<array_length(moveableSpaces);j++)
			{
				if(moveableSpaces[j].myPiece!=undefined)
				{
					ourPiece = moveablePieces[i];
					array_delete(moveablePieces,i,1);
					break;
				}
			}
		}
		if(ourPiece!=undefined)
		{
			field.HighlightMoveableSpaces(ourPiece);
			//i. which pieces are they able to attack?
			//ii. which of these pieces has the highest priority to attack
			NextMove = AttackPiece;
			alarm[0] = waitTime;
		}
		//II. Move whatever pieces we can.
		else if(array_length(moveablePieces)>0)
		{
			ourPiece = moveablePieces[0];
			array_delete(moveablePieces,0,1);
			field.HighlightMoveableSpaces(ourPiece);
			//i. optimal piece placement
			NextMove = MovePiece;
			alarm[0] = waitTime;
		}
		else
		{
			moveablePieces=undefined;
			NextMove = undefined;
			alarm[0] = waitTime;
		}
	}
	
	//6. Should we play more pieces on the board?
		//aim to have at least 5 pieces on the board.
	var pieceGoal = 5;
		//if the player has more than 5 try to match that.
	if(array_length(field.whitePieces)>pieceGoal)
	{pieceGoal=array_length(field.whitePieces);}
	
	if(kingGoodThisTurn && moveablePieces==undefined
		&& array_length(field.blackPieces)<pieceGoal)
	{
		show_debug_message("[6]");
		
		//I. if we have cards
		if(array_length(global.opHand.cardsHeld)>0)
		{
			//i. If we have a selection of only pawns combine them
			if(FindHighestRankCard().pips<5 && array_length(global.opHand.cardsHeld)>1
				&& CheckValidComboPairs(10)!=undefined)
			{CombineCardPair();}
			//ii. Otherwise play the highest ranked card (even if it's a pawn)
			else
			{
				SelectCard(FindHighestRankCard());
				Wait(OptimalSupportPlacement);
				return;
			}
		}
		//II. Otherwise draw cards
		else{DrawCardFromDeck([11]);}
	}
	//7. End Turn
	if(kingGoodThisTurn && moveablePieces==undefined
		&& array_length(field.blackPieces)>=pieceGoal)
	{field.ChangeTurns();}
	//6. Miscellaneous actions
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
		var moveablePieces=0;
		for(var i=0; i<array_length(field.blackPieces);i++)
		{if(!field.blackPieces[i].hasMoved){moveablePieces++;}}
		if(moveablePieces>0)
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
	if(FindCard(11)) {Wait(OptimalQueenPlacement); return true;}
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
	var played = false;
	
	if(!CheckKingSurrounded())
	{
		var myTile = undefined;
		
		for(var i=0;i<array_length(field.blackPieces);i++)
		{if(field.blackPieces[i].object_index==oKingB)
			{myTile = field.blackPieces[i].myTile; break;}}
	
		if(myTile.row<4 && grid[myTile.row+1][myTile.column].myPiece==undefined)
		{grid[myTile.row+1][myTile.column].PlayPiece(false); played=true;}
		else if((myTile.row<4&&myTile.column<8 && grid[myTile.row+1][myTile.column+1].myPiece==undefined))
		{grid[myTile.row+1][myTile.column+1].PlayPiece(false); played=true;}
		else if(myTile.row<4&&myTile.column>0 && grid[myTile.row+1][myTile.column-1].myPiece==undefined)
		{grid[myTile.row+1][myTile.column-1].PlayPiece(false); played=true;}
		else if(myTile.column>0 && grid[myTile.row][myTile.column-1].myPiece==undefined)
		{grid[myTile.row][myTile.column-1].PlayPiece(false); played=true;}
		else if(myTile.column<8 && grid[myTile.row][myTile.column+1].myPiece==undefined)
		{grid[myTile.row][myTile.column+1].PlayPiece(false); played=true;}
		else if(myTile.row>0 && grid[myTile.row-1][myTile.column].myPiece==undefined)
		{grid[myTile.row-1][myTile.column].PlayPiece(false); played=true;}
		else if(myTile.row>0&&myTile.column<8 && grid[myTile.row-1][myTile.column+1].myPiece==undefined)
		{grid[myTile.row-1][myTile.column+1].PlayPiece(false); played=true;}
		else if(myTile.row>0&&myTile.column>0 && grid[myTile.row-1][myTile.column-1].myPiece==undefined)
		{grid[myTile.row-1][myTile.column-1].PlayPiece(false); played=true;}
	}
	else
	{
		if(grid[1][4].myPiece==undefined){grid[1][4].PlayPiece(false); played=true;}
		else if(grid[0][4].myPiece==undefined){grid[0][4].PlayPiece(false); played=true;}
		else if(grid[1][5].myPiece==undefined){grid[1][5].PlayPiece(false); played=true;}
		else if(grid[0][5].myPiece==undefined){grid[0][5].PlayPiece(false); played=true;}
		else if(grid[1][3].myPiece==undefined){grid[1][3].PlayPiece(false); played=true;}
		else if(grid[0][3].myPiece==undefined){grid[0][3].PlayPiece(false); played=true;}
		else if(grid[1][6].myPiece==undefined){grid[1][6].PlayPiece(false); played=true;}
		else if(grid[0][6].myPiece==undefined){grid[0][6].PlayPiece(false); played=true;}
		else if(grid[1][2].myPiece==undefined){grid[1][2].PlayPiece(false); played=true;}
		else if(grid[0][2].myPiece==undefined){grid[0][2].PlayPiece(false); played=true;}
		else if(grid[1][7].myPiece==undefined){grid[1][7].PlayPiece(false); played=true;}
		else if(grid[1][1].myPiece==undefined){grid[1][1].PlayPiece(false); played=true;}
		else if(grid[1][8].myPiece==undefined){grid[1][8].PlayPiece(false); played=true;}
		else if(grid[1][0].myPiece==undefined){grid[1][0].PlayPiece(false); played=true;}
		else if(grid[0][7].myPiece==undefined){grid[0][7].PlayPiece(false); played=true;}
		else if(grid[0][1].myPiece==undefined){grid[0][1].PlayPiece(false); played=true;}
		else if(grid[0][8].myPiece==undefined){grid[0][8].PlayPiece(false); played=true;}
		else if(grid[0][0].myPiece==undefined){grid[0][0].PlayPiece(false); played=true;}
	}
	if(played)
	{
		queen = field.blackPieces[array_length(field.blackPieces)-1];
		queenPlayed = true;
		
		var tb = instance_create_layer(x,y,"Text",oMatchTextBox);
		tb.text = "The Queen has arrived!";
		tb.type = 1;
		tb.textDuration=3;
		tb.x=(room_width/2)-((string_width("The Queen has arrived!")+tb.border)/2);
		tb.y=200;
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
	}
	Wait();
}

function OptimalSupportPlacement()
{
	#region Textboxes
	var tb=undefined;
	
	if(ourCard.hearts>1)
	{
		var text="";
		var dialogue=irandom(3);
		if(dialogue==0){text="Peace.";}
		else if(dialogue==1){text="Love.";}
		else if(dialogue==2){text="Unity.";}
		else{text="Respect.";}
		
		tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
		tb.text = text;
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
	}
	if(ourCard.spades>0)
	{
		var moveMe = irandom(1);
		if(tb!=undefined && !moveMe){tb.x += irandom(100);}
		
		var text="";
		var dialogue=irandom(1);
		if(dialogue==0){text="Oo-oh yeeeaaahhh.";}
		else if(dialogue==1){text="Feeling good.";}
		
		tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
		tb.text = text;
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
		
		if(tb!=undefined && moveMe){tb.x += irandom(100);}
	}
	if(ourCard.diamonds>0)
	{
		var moveMe = irandom(1);
		if(tb!=undefined && !moveMe){tb.x += irandom(100);}
		
		var text="";
		var dialogue=irandom(1);
		if(dialogue==0){text="Dolla dolla bills!";}
		else if(dialogue==1){text="Cash money money!";}
		
		tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
		tb.text = text;
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
		
		if(tb!=undefined && moveMe){tb.x += irandom(100);}
	}
	#endregion
	
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
		
		field.blackPieces[array_length(field.blackPieces)-1].hasMoved=true;
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
		if(field.blackPieces[i].object_index==oQueenB
			&&field.blackPieces[i].Health<10)
		{highestRankedPiece = field.blackPieces[i];}
		else if((highestRankedPiece!=undefined
			&&highestRankedPiece.object_index!=oQueenB)
			&&field.blackPieces[i].object_index==oKingB
			&&field.blackPieces[i].Health<5)
		{highestRankedPiece = field.blackPieces[i];}
		else if(highestRankedPiece!=undefined
			&&highestRankedPiece.object_index!=(oKingB||oQueenB)
			&&field.blackPieces[i].object_index==oBishopB
			&&field.blackPieces[i].Health<3)
		{highestRankedPiece = field.blackPieces[i];}
		else if(highestRankedPiece!=undefined
			&&highestRankedPiece.object_index!=(oKingB||oQueenB||oBishopB)
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
			field.ChangeTurns();
		break;
	}
}

function CombineCardPair()
{
	CheckValidComboPairs(10);
	var choice = irandom_range(0,array_length(comboPairs)-1);
	global.opHand.c1 = global.opHand.cardsHeld[comboPairs[choice][0]];
	global.opHand.c2 = global.opHand.cardsHeld[comboPairs[choice][1]];
	global.opHand.CombineCards();
	NextMove=undefined;
	alarm[0]=waitTime;
}

//for this match our king won't move
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
		ourCard=undefined;
		NextMove=undefined;
		alarm[0]=waitTime;
		return;
	}
	//Otherwise, we play the card to the field
	else
	{
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

function AttackPiece()
{
	moveables = ourPiece.GetMoveableSpaces();
	if(moveables!=undefined)
	{
		var pieces=undefined;
		for(var i=0;i<array_length(moveables);i++)
		{
			if(moveables[i].myPiece!=undefined)
			{
				if(pieces==undefined){pieces[0]=moveables[i].myPiece;}
				else{array_push(pieces,moveables[i].myPiece);}
			}
		}
		if(pieces!=undefined)
		{
			var pieceToAttack = pieces[0];
			if(array_length(pieces)>1)
			{
				for(var i=1;i<array_length(pieces);i++)
				{
					//choose the highest ranked piece
					if(CompareRank(pieces[i],pieces[i-1])!=undefined)
					{pieceToAttack=CompareRank(pieces[i],pieces[i-1]);}
					//or choose the least healthy of the two equal ranked pieces
					else
					{
						if(pieces[i].Health < pieceToAttack.Health)
						{pieceToAttack=pieces[i];}
					}
				}
			}
			//...and attack
			field.MovePieceToPlace(pieceToAttack.row,pieceToAttack.column);
			
			ourPiece=undefined;
			NextMove = undefined;
			alarm[0] = waitTime;
		}
	}
}

function MovePiece()
{
	switch(ourPiece.object_index)
	{
	case oPawnB:
		if(ourPiece.row<4 && field.grid[ourPiece.row+1][ourPiece.column].myPiece==undefined)
		{field.MovePieceToPlace(ourPiece.row+1,ourPiece.column);}
		else{ourPiece.hasMoved = true; field.UnselectTiles();}
		break;
	case oKnightB: case oBishopB: case oQueenB:
		//what spaces can we move to
		var spaces = ourPiece.GetMoveableSpaces();
		if(spaces!=undefined)
		{
			//highest point total decides which space we move to
			pointTotals = array_create(array_length(spaces),0);
			//determine point totals
			for(var i=0;i<array_length(spaces);i++)
			{
				//what can we see from this potential spot
				var potentialities = ourPiece.GetMoveableSpaces(spaces[i].row,spaces[i].column);
				for(var j=0;j<array_length(potentialities);j++)
				{
					if(potentialities[j].myPiece!=undefined)
					{
						switch(potentialities[j].myPiece.object_index)
						{
						case oPawnW:	pointTotals[i]+=1; break;
						case oKnightW:	pointTotals[i]+=2; break;
						case oBishopW:	pointTotals[i]+=3; break;
						case oRookW:	pointTotals[i]+=5; break;
						case oQueenW:	pointTotals[i]+=9; break;
						case oKingW:	pointTotals[i]+=15; break;
						}
					}
				}
			}
			var highestPointTotal=0;
			//select the highest
			for(var i=1;i<array_length(pointTotals);i++)
			{
				if(pointTotals[i]>pointTotals[highestPointTotal])
				{highestPointTotal=i;}
			}
			//move there
			field.MovePieceToPlace(spaces[highestPointTotal].row,spaces[highestPointTotal].column);
		}
		else
		{ourPiece.hasMoved = true; field.UnselectTiles();}
		break;
	}
	ourPiece=undefined;
	NextMove=undefined;
	alarm[0]=waitTime;
}

//This function moves the piece prioritizing attacking over random movement
function MovePiece2()
{
	moveables = ourPiece.GetMoveableSpaces();
	
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
		}
		else if(pieces!=undefined)
		{
			//pick a gridTile...
			var moveSpace = pieces[irandom_range(0,array_length(pieces)-1)];
			//...and try to move there
			field.MovePieceToPlace(moveSpace.row,moveSpace.column);
		}
		else
		{
			//pick a gridTile...
			var moveSpace = moveables[irandom_range(0,array_length(moveables)-1)];
			//...and try to move there
			field.MovePieceToPlace(moveSpace.row,moveSpace.column);
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
	}
	
	ourSpAb=undefined;
	NextMove=undefined;
	alarm[0] = waitTime;
}

//each Manager needs to have this for narrative consistency
//Creates a text response when a piece is captured
//obj = the pieces object_index
function PieceDeathResponse(obj)
{
	switch(obj)
	{
	case oPawnB:
		var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
		tb.text = "How could you?";
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
	break;
	case oKnightB:
		var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
		tb.text = "You'll pay for this.";
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
	break;
	case oBishopB:
		var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
		tb.text = "Jerk! That was my bestie!";
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
	break;
	case oQueenB:
		var tb = instance_create_layer(x,y,"Text",oMatchTextBox);
		tb.text = "Okay, we're enemies now.";
		tb.type = 1;
		tb.textDuration=3;
		tb.x=(room_width/2)-((string_width("Okay, we're enemies now.")+tb.border)/2);
		tb.y=200;
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
		
		queen = undefined;
	break;
	case oPawnW:
		var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
		tb.text = "Bruh, are you trying?";
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
	break;
	case oKnightW:
		var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
		tb.text = "Do better.";
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
	break;
	case oBishopW:
		var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
		tb.text = "That's what you get.";
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
	break;
	case oRookW:
		var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
		tb.text = "Hurts, doesn't it?";
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
	break;
	case oQueenW:
		var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
		tb.text = "I'm the queen around here!";
		tb.bg = sprSavannahVoidTextBox;
		tb.color = #8c52ff;
	break;
	case oKingW:
		//here we only do this if the player has multiple kings
		kingCount = 0;
		for(var i=0;i<array_length(field.whitePieces);i++)
		{if(field.whitePieces[i].object_index==oKingW){kingCount++;}}
		if(kingCount>1)
		{
			var tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
			tb.text = "Too easy...";
			tb.bg = sprSavannahVoidTextBox;
			tb.color = #8c52ff;
			
			tb = instance_create_layer(x,y,"ParallaxLayer",oMatchTextBox);
			tb.x += string_width("Too easy...")+(tb.border*3);
			tb.text = "Wait, there's more?!";
			tb.bg = sprSavannahVoidTextBox;
			tb.color = #8c52ff;
		}
	break;
	}
}

function MatchWin()
{		
	global.playerDefeated=false;
	
	var tb = instance_create_layer(x,y,"Text",oMatchTextBox);
	tb.text = "Oh man... I lost.";
	tb.type = 1;
	tb.textDuration=3;
	tb.x=(room_width/2)-((string_width("Oh man... I lost.")+tb.border)/2);
	tb.y=200;
	tb.bg = sprSavannahVoidTextBox;
	tb.color = #8c52ff;
	tb.NextMove = EndMatch;
}

function MatchDefeat()
{
	global.playerDefeated=true;
	
	var tb = instance_create_layer(x,y,"Text",oMatchTextBox);
	tb.text = "Oh man... I won... cool.";
	tb.type = 1;
	tb.textDuration=3;
	tb.x=(room_width/2)-((string_width("Oh man... I won... cool.")+tb.border)/2);
	tb.y=200;
	tb.bg = sprSavannahVoidTextBox;
	tb.color = #8c52ff;
	tb.NextMove = EndMatch;
}

function EndMatch()
{
	global.postMatch=true;
	var trans = instance_create_layer(0,0,"Text",oFadeTransition);
	trans.nextRoom = rRainyKnightsCafe;
}