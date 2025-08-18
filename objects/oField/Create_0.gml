tilesSelectable = false;
pieceSelected = undefined;
abilityInProgress=undefined;

rowSelected = undefined;
colSelected = undefined;

blackPieces = [];
whitePieces = [];
grid = [];

function SetupBoard()
{
	// true = black, false = white
	var BorW = !instance_find(oMatchManager,0).pStart;
	for(var i=0;i<5;i++)
	{
		for(var j=0;j<9;j++)
		{
			grid[i][j] = instance_create_layer(
			480+(j*80),
			290+(i*80),
			"BoardLayer", oGridTile);
			grid[i][j].row = i;
			grid[i][j].column = j;
			if(i=0&&j=4){grid[i][j].SetupKing(!BorW);}
			if(i=4&&j=4){grid[i][j].SetupKing(BorW);}
		}
	}
}

//highlights gridspaces where the player could play a piece
function CardSelected()
{
	if(instance_find(oMatchManager,0).pTurn)
	{
		for(var i=3;i<5;i++)
		{
			for(var j=0;j<9;j++)
			{
				if(grid[i][j].myPiece==undefined)
				{
					grid[i][j].BecomeSelectable();
				}
			}
		}
	}
	else
	{
		for(var i=0;i<2;i++)
		{
			for(var j=0;j<9;j++)
			{
				if(grid[i][j].myPiece==undefined)
				{
					grid[i][j].BecomeSelectable();
				}
			}
		}
	}
	tilesSelectable=true;
}

function HighlightMoveableSpaces(piece,row,column)
{
	switch(piece.object_index)
	{
	case oPawnB:
		#region Black Pawn Movement
		if(!instance_find(oMatchManager,0).pStart) //if we have the black pawns
		{
			if(row>0 && grid[row-1][column].myPiece==undefined)
			{grid[row-1][column].BecomeSelectable();}
		
			if(row>0 && column>0 && grid[row-1][column-1].myPiece!=undefined
				&& object_is_ancestor(grid[row-1][column-1].myPiece.object_index,oChessPieceW))
			{grid[row-1][column-1].BecomeSelectable();}
		
			if(row>0 && column<8 && grid[row-1][column+1].myPiece!=undefined
				&& object_is_ancestor(grid[row-1][column+1].myPiece.object_index,oChessPieceW))
			{grid[row-1][column+1].BecomeSelectable();}
		}
		else //if the opponenet has the black pawns
		{
			if(row<4 && grid[row+1][column].myPiece==undefined)
			{grid[row+1][column].BecomeSelectable();}
		
			if(row<4 && column>0 && grid[row+1][column-1].myPiece!=undefined
				&& object_is_ancestor(grid[row+1][column-1].myPiece.object_index,oChessPieceW))
			{grid[row+1][column-1].BecomeSelectable();}
		
			if(row<4 && column<8 && grid[row+1][column+1].myPiece!=undefined
				&& object_is_ancestor(grid[row+1][column+1].myPiece.object_index,oChessPieceW))
			{grid[row+1][column+1].BecomeSelectable();}
		}
		#endregion
		break;
	case oPawnW:
		#region White Pawn Movement
		if(instance_find(oMatchManager,0).pStart) //if we have the white pawns
		{
			if(row>0 && grid[row-1][column].myPiece==undefined)
			{grid[row-1][column].BecomeSelectable();}
		
			if(row>0 && column>0 && grid[row-1][column-1].myPiece!=undefined
				&& object_is_ancestor(grid[row-1][column-1].myPiece.object_index,oChessPieceB))
			{grid[row-1][column-1].BecomeSelectable();}
		
			if(row>0 && column<8 && grid[row-1][column+1].myPiece!=undefined
				&& object_is_ancestor(grid[row-1][column+1].myPiece.object_index,oChessPieceB))
			{grid[row-1][column+1].BecomeSelectable();}
		}
		else //if the opponenet has the white pawns
		{
			if(row<4 && grid[row+1][column].myPiece==undefined)
			{grid[row+1][column].BecomeSelectable();}
		
			if(row<4 && column>0 && grid[row+1][column-1].myPiece!=undefined
				&& object_is_ancestor(grid[row+1][column-1].myPiece.object_index,oChessPieceB))
			{grid[row+1][column-1].BecomeSelectable();}
		
			if(row<4 && column<8 && grid[row+1][column+1].myPiece!=undefined
				&& object_is_ancestor(grid[row+1][column+1].myPiece.object_index,oChessPieceB))
			{grid[row+1][column+1].BecomeSelectable();}
		}
		#endregion
		break;
	case oKnightB: case oKnightW:
		#region Knight Movement
		var BorW = (piece.object_index==oKnightB);
		
		if(row>1 && column>0 && (grid[row-2][column-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-2][column-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-2][column-1].myPiece.object_index,oChessPieceB))))
		{grid[row-2][column-1].BecomeSelectable();}
		
		if(row>1 && column<8 && (grid[row-2][column+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-2][column+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-2][column+1].myPiece.object_index,oChessPieceB))))
		{grid[row-2][column+1].BecomeSelectable();}
		
		if(row>0 && column>1 && (grid[row-1][column-2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-1][column-2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-1][column-2].myPiece.object_index,oChessPieceB))))
		{grid[row-1][column-2].BecomeSelectable();}
		
		if(row>0 && column<7 && (grid[row-1][column+2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-1][column+2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-1][column+2].myPiece.object_index,oChessPieceB))))
		{grid[row-1][column+2].BecomeSelectable();}
		
		if(row<4 && column>1 && (grid[row+1][column-2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+1][column-2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+1][column-2].myPiece.object_index,oChessPieceB))))
		{grid[row+1][column-2].BecomeSelectable();}
		
		if(row<4 && column<7 && (grid[row+1][column+2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+1][column+2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+1][column+2].myPiece.object_index,oChessPieceB))))
		{grid[row+1][column+2].BecomeSelectable();}
		
		if(row<3 && column>0 && (grid[row+2][column-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+2][column-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+2][column-1].myPiece.object_index,oChessPieceB))))
		{grid[row+2][column-1].BecomeSelectable();}
		
		if(row<3 && column<8 && (grid[row+2][column+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+2][column+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+2][column+1].myPiece.object_index,oChessPieceB))))
		{grid[row+2][column+1].BecomeSelectable();}
		#endregion
		break;
	case oRookB: case oRookW:
		var BorW = (piece.object_index==oRookB);
		
		#region Above Movement
		curRow=row;
		curCol=column;
		search = true;
		while(search)
		{
			if(--curRow<0){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region Below Movement
		curRow=row;
		curCol=column;
		search = true;
		//determine how many spaces below can be selected
		while(search)
		{
			if(++curRow>4){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region Left Movement
		curRow=row;
		curCol=column;
		search = true;
		//determine how many spaces left can be selected
		while(search)
		{
			if(--curCol<0){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region Right Movement
		curRow=row;
		curCol=column;
		search = true;
		//determine how many spaces right can be selected
		while(search)
		{
			if(++curCol>8){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		
		break;
	case oBishopB: case oBishopW:
		var BorW = (piece.object_index==oBishopB);
	
		#region UpLeft Diagonal Movement
		curRow=row;
		curCol=column;
		search = true;
		while(search)
		{
			if(--curRow<0 || --curCol<0){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region UpRight Diagonal Movement
		curRow=row;
		curCol=column;
		search = true;
		while(search)
		{
			if(--curRow<0 || ++curCol>8){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region DownLeft Diagonal Movement
		curRow=row;
		curCol=column;
		search = true;
		while(search)
		{
			if(++curRow>4 || --curCol<0){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region DownRight Diagonal Movement
		curRow=row;
		curCol=column;
		search = true;
		while(search)
		{
			if(++curRow>4 || ++curCol>8){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		
		break;
	case oQueenB: case oQueenW:
		var BorW = (piece.object_index==oQueenB);
		
		#region Upward Movement
		curRow=row;
		curCol=column;
		search = true;
		while(search)
		{
			if(--curRow<0){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region UpRight Diagonal Movement
		curRow=row;
		curCol=column;
		search = true;
		while(search)
		{
			if(--curRow<0 || ++curCol>8){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region Right Movement
		curRow=row;
		curCol=column;
		search = true;
		//determine how many spaces right can be selected
		while(search)
		{
			if(++curCol>8){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region DownRight Diagonal Movement
		curRow=row;
		curCol=column;
		search = true;
		while(search)
		{
			if(++curRow>4 || ++curCol>8){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region Downward Movement
		curRow=row;
		curCol=column;
		search = true;
		//determine how many spaces below can be selected
		while(search)
		{
			if(++curRow>4){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region DownLeft Diagonal Movement
		curRow=row;
		curCol=column;
		search = true;
		while(search)
		{
			if(++curRow>4 || --curCol<0){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region Left Movement
		curRow=row;
		curCol=column;
		search = true;
		//determine how many spaces left can be selected
		while(search)
		{
			if(--curCol<0){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion
		#region UpLeft Diagonal Movement
		curRow=row;
		curCol=column;
		search = true;
		while(search)
		{
			if(--curRow<0 || --curCol<0){search=false;}
			else
			{
				if(grid[curRow][curCol].myPiece==undefined)
				{grid[curRow][curCol].BecomeSelectable();}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{grid[curRow][curCol].BecomeSelectable(); search=false;}
				else{search=false;}
			}
		}
		#endregion

		break;
	case oKingB: case oKingW:
		#region King Movement
		
		var BorW = (piece.object_index==oKingB);
		
		if(row>0 && column>0 && (grid[row-1][column-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-1][column-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-1][column-1].myPiece.object_index,oChessPieceB))))
		{grid[row-1][column-1].BecomeSelectable();}
		
		if(row>0 && (grid[row-1][column].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-1][column].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-1][column].myPiece.object_index,oChessPieceB))))
		{grid[row-1][column].BecomeSelectable();}
		
		if(row>0 && column<8 && (grid[row-1][column+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-1][column+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-1][column+1].myPiece.object_index,oChessPieceB))))
		{grid[row-1][column+1].BecomeSelectable();}
		
		if(column>0 && (grid[row][column-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row][column-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row][column-1].myPiece.object_index,oChessPieceB))))
		{grid[row][column-1].BecomeSelectable();}
		
		if(column<8 && (grid[row][column+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row][column+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row][column+1].myPiece.object_index,oChessPieceB))))
		{grid[row][column+1].BecomeSelectable();}
		
		if(row<4 && column>0 && (grid[row+1][column-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+1][column-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+1][column-1].myPiece.object_index,oChessPieceB))))
		{grid[row+1][column-1].BecomeSelectable();}
		
		if(row<4 && (grid[row+1][column].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+1][column].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+1][column].myPiece.object_index,oChessPieceB))))
		{grid[row+1][column].BecomeSelectable();}
		
		if(row<4 && column<8 && (grid[row+1][column+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+1][column+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+1][column+1].myPiece.object_index,oChessPieceB))))
		{grid[row+1][column+1].BecomeSelectable();}
		#endregion
		break;
	default:
		break;
	}
	tilesSelectable=true;
	rowSelected = row;
	colSelected = column;
	pieceSelected = piece;
}

function UnselectTiles()
{
	for(var i=0;i<5;i++)
	{
		for(var j=0;j<9;j++)
		{
			if(grid[i][j].selectable)
			{
				grid[i][j].BecomeUnselectable();
			}
		}
	}
	tilesSelectable=false;
	pieceSelected = undefined;
	
	rowSelected = undefined;
	colSelected = undefined;
}

function SearchForPiece(row,column)
{
	if(grid[row][column].myPiece!=undefined){return grid[row][column].myPiece}
	else{return undefined;}
}

//row and column are where we want to go
//rs and cs are where we are currently
function MovePieceToPlace(row,column,rs=rowSelected,cs=colSelected)
{
	//move to the space if there's nothing there
	if(grid[row][column].myPiece==undefined)
	{
		//store the piece at the new oGridTile and remove it from the old tile
		grid[row][column].myPiece = grid[rs][cs].myPiece;
		grid[rs][cs].myPiece = undefined;
		
		//set the piece's new row, column, and tile
		grid[row][column].myPiece.row = grid[row][column].row;
		grid[row][column].myPiece.column = grid[row][column].column;
		grid[row][column].myPiece.myTile = grid[row][column].id;
	
		//update location
		grid[row][column].myPiece.x = grid[row][column].x;
		grid[row][column].myPiece.y = grid[row][column].y;
		
		//if a pawn makes it to the other side, graduate it
		if((grid[row][column].myPiece.object_index==oPawnB && row==0)
			||(grid[row][column].myPiece.object_index==oPawnW && row==4))
		{grid[row][column].myPiece.graduated=true;}
		
		//we can no longer move this piece on this turn
		grid[row][column].myPiece.hasMoved = true;
		
		audio_play_sound(sndMovePiece,1,false);
	}
	//otherwise we gotta fight
	else
	{
		//their new health = their health - my attack
		var newHealth = grid[row][column].myPiece.Health
			- grid[rs][cs].myPiece.Attack;
		
		var pragma = (grid[row][column].myPiece.pragma) ? "active." : "not active.";
		show_debug_message(string(grid[row][column].myPiece.object_index)+" has "
			+string(newHealth)+" health. Pragma is: "
			+ pragma);
		
		audio_play_sound(sndAttackPiece,1,false);
		
		//if they don't have health left destroy them and take their place
		if(!grid[row][column].myPiece.pragma && newHealth<=0)
		{
			//we set the other piece's health to newHealth;
			//it will handle deletion on it's own
			grid[row][column].myPiece.Health = newHealth;
			
			//store the piece at the new oGridTile and remove it from the old tile
			grid[row][column].myPiece=grid[rs][cs].myPiece;
			grid[rs][cs].myPiece = undefined;
		
			//set the piece's new row and column
			grid[row][column].myPiece.row = grid[row][column].row;
			grid[row][column].myPiece.column = grid[row][column].column;
			grid[row][column].myPiece.myTile = grid[row][column].id;
	
			//update location
			grid[row][column].myPiece.x = grid[row][column].x;
			grid[row][column].myPiece.y = grid[row][column].y;
			
			audio_play_sound(sndMovePiece,1,false);
			
			//we can no longer move this piece on this turn
			grid[row][column].myPiece.hasMoved = true;
			show_debug_message("We attacked");
		}
		else
		{
			grid[row][column].myPiece.Health = newHealth;
			grid[rs][cs].myPiece.hasMoved = true;
		}
	}
	UnselectTiles();
}

function AddPiece(obj)
{
	if(object_is_ancestor(obj.object_index,oChessPieceB)){array_push(blackPieces,obj);}
	else if(object_is_ancestor(obj.object_index,oChessPieceW)){array_push(whitePieces,obj);}
}

function RemovePiece(obj)
{
	if(object_is_ancestor(obj.object_index,oChessPieceB))
	{
		for(var i=0; i<array_length(blackPieces);i++)
		{
			if(blackPieces[i]==obj)
			{
				array_delete(blackPieces,i,1);
				break;
			}
		}
	}
	else if(object_is_ancestor(obj.object_index,oChessPieceW))
	{
		for(var i=0; i<array_length(whitePieces);i++)
		{
			if(whitePieces[i]==obj)
			{
				array_delete(whitePieces,i,1);
				break;
			}
		}
	}
}

function ChangeTurns()
{
	instance_find(oMatchManager,0).pTurn = !instance_find(oMatchManager,0).pTurn;
	if(instance_find(oMatchManager,0).pTurn==instance_find(oMatchManager,0).pStart){instance_find(oMatchManager,0).Turn++;}
	
	if(instance_find(oMatchManager,0).pTurn)
	{
		if(global.pDeck.cardsLeft==0){instance_find(oMatchManager,0).MatchDefeat();}
		
		global.pDeck.firstDraw=true;
		
		//reset the AI's decision streak;
		instance_find(oMatchManager,0).decisionsMade = 0;
		
		if(instance_find(oMatchManager,0).pStart)
		{
			for(var i=0;i<array_length(whitePieces);i++)
			{
				whitePieces[i].hasMoved=false;
			}
		}
		else
		{
			for(var i=0;i<array_length(blackPieces);i++)
			{
				blackPieces[i].hasMoved=false;
			}
		}
	}
	else
	{
		global.opDeck.firstDraw=true;
		
		if(!instance_find(oMatchManager,0).pStart)
		{
			for(var i=0;i<array_length(whitePieces);i++)
			{
				whitePieces[i].hasMoved=false;
			}
		}
		else
		{
			for(var i=0;i<array_length(blackPieces);i++)
			{
				blackPieces[i].hasMoved=false;
			}
		}
		
		if(global.opDeck.cardsLeft==0){instance_find(oMatchManager,0).MatchWin();}
		//this function call sets up our whole opponents turn and won't give control
		//back to the player until the AI is done
		else if(instance_find(oMatchManager,0).object_index!=oTutManager)
		{instance_find(oMatchManager,0).TurnManager();}
	}
}

function SpecialAbilityInProgress(obj)
{
	abilityInProgress = obj;
	UnselectTiles();
	
	//depending on the ability we need to highlight
	//either our pieces or the opponenet's pieces
	//sometimes excluding kings
	switch(obj.specialAbility)
	{
		case 0:
			CardSelected();
		break;
		case 14:
			if(obj.playerAb){HighlightPlayerPieces();}
			else{HighlightOpponentPieces();}
		break;
		case 34:
			if(obj.playerAb) {HighlightOpponentPiecesMinusKings();}
			else {HighlightPlayerPiecesMinusKings();}
		break;
		default:
		break;
	}
}

function HighlightPlayerPieces()
{
	var BorW = !instance_find(oMatchManager,0).pStart;
	var BorWPieces = (BorW) ? blackPieces : whitePieces;
	
	for(var i=0; i<array_length(BorWPieces);i++)
	{BorWPieces[i].myTile.BecomeSelectable();}
}

function HighlightPlayerPiecesMinusKings()
{
	var BorW = !instance_find(oMatchManager,0).pStart;
	var BorWPieces = (BorW) ? blackPieces : whitePieces;
	
	for(var i=0; i<array_length(BorWPieces);i++)
	{
		if(BorWPieces[i].object_index!=oKingB)
		{BorWPieces[i].myTile.BecomeSelectable();}
	}
}

function HighlightOpponentPieces()
{
	var BorW = instance_find(oMatchManager,0).pStart;
	var BorWPieces = (BorW) ? blackPieces : whitePieces;
	
	for(var i=0; i<array_length(BorWPieces);i++)
	{BorWPieces[i].myTile.BecomeSelectable();}
}

function HighlightOpponentPiecesMinusKings()
{
	var BorW = instance_find(oMatchManager,0).pStart;
	var BorWPieces = (BorW) ? blackPieces : whitePieces;
	
	for(var i=0; i<array_length(BorWPieces);i++)
	{
		if(BorWPieces[i].object_index!=oKingB)
		{BorWPieces[i].myTile.BecomeSelectable();}
	}
}

function CheckForKings()
{
	if(instance_find(oMatchManager,0).object_index!=oTutManager)
	{
		var kingCountW=0;
		for(var i=0; i<array_length(whitePieces);i++)
		{
			if(whitePieces[i].object_index==oKingW){kingCountW++;}
		}
		var kingCountB=0;
		for(var i=0; i<array_length(blackPieces);i++)
		{
			if(blackPieces[i].object_index==oKingB){kingCountB++;}
		}
		show_debug_message("Checking for kings\nWhite King Count: "+string(kingCountW)
			+"\nBlack King Count: "+string(kingCountB));
		if((!instance_find(oMatchManager,0).pStart && kingCountW==0&&kingCountB>0)
			||(instance_find(oMatchManager,0).pStart && kingCountB==0&&kingCountW>0))
		{instance_find(oMatchManager,0).MatchWin();show_debug_message("We won.");}
		else if((instance_find(oMatchManager,0).pStart && kingCountW==0&&kingCountB>0)
			||(!instance_find(oMatchManager,0).pStart && kingCountB==0&&kingCountW>0))
		{instance_find(oMatchManager,0).MatchDefeat();show_debug_message("we lost.");}
	}
}