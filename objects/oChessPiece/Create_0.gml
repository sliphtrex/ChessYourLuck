Health=1;
Attack=1;
row = undefined;
column = undefined;
myTile=undefined;
hasMoved = false;

pragma=false;
image_speed=0;

//returns an array of oGridTiles that we can move to
function GetMoveableSpaces()
{
	moveableSpaces = undefined;
	grid = instance_find(oField,0).grid;
	
	switch(object_index)
	{
	case oPawnB: case oPawnW:
	#region Pawn Movement
		var BorW = (object_index==oPawnB) ? true : false;
		
		if(instance_find(oMatchManager,0).pStart != BorW)
		{
			if(row>0 && grid[row-1][column].myPiece==undefined)
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[row-1][column];}
				else{array_push(moveableSpaces,grid[row-1][column]);}
			}
		
			if(row>0 && column>0 && grid[row-1][column-1].myPiece!=undefined
				&& object_is_ancestor(grid[row-1][column-1].myPiece.object_index,
					(BorW) ? oChessPieceW : oChessPieceB))
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[row-1][column-1];}
				else{array_push(moveableSpaces,grid[row-1][column-1]);}
			}
		
			if(row>0 && column<8 && grid[row-1][column+1].myPiece!=undefined
				&& object_is_ancestor(grid[row-1][column+1].myPiece.object_index,
					(BorW) ? oChessPieceW : oChessPieceB))
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[row-1][column+1];}
				else{array_push(moveableSpaces,grid[row-1][column+1]);}
			}
		}
		else
		{
			if(row<4 && grid[row+1][column].myPiece==undefined)
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[row+1][column];}
				else{array_push(moveableSpaces,grid[row+1][column]);}
			}
		
			if(row<4 && column>0 && grid[row+1][column-1].myPiece!=undefined
				&& object_is_ancestor(grid[row+1][column-1].myPiece.object_index,
					(BorW) ? oChessPieceW : oChessPieceB))
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[row+1][column-1];}
				else{array_push(moveableSpaces,grid[row+1][column-1]);}
			}
		
			if(row<4 && column<8 && grid[row+1][column+1].myPiece!=undefined
				&& object_is_ancestor(grid[row+1][column+1].myPiece.object_index,
					(BorW) ? oChessPieceW : oChessPieceB))
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[row+1][column+1];}
				else{array_push(moveableSpaces,grid[row+1][column+1]);}
			}
		}
	#endregion
	break;
	case oKnightB: case oKnightW:
	#region Knight Movement
		var BorW = (object_index==oKnightB);
		
		if(row>1 && column>0 && (grid[row-2][column-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-2][column-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-2][column-1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row-2][column-1];}
			else{array_push(moveableSpaces,grid[row-2][column-1]);}
		}
		if(row>1 && column<8 && (grid[row-2][column+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-2][column+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-2][column+1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row-2][column+1];}
			else{array_push(moveableSpaces,grid[row-2][column+1]);}
		}
		if(row>0 && column>1 && (grid[row-1][column-2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-1][column-2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-1][column-2].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row-1][column-2];}
			else{array_push(moveableSpaces,grid[row-1][column-2]);}
		}
		if(row>0 && column<7 && (grid[row-1][column+2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-1][column+2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-1][column+2].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row-1][column+2];}
			else{array_push(moveableSpaces,grid[row-1][column+2]);}
		}
		if(row<4 && column>1 && (grid[row+1][column-2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+1][column-2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+1][column-2].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row+1][column-2];}
			else{array_push(moveableSpaces,grid[row+1][column-2]);}
		}
		if(row<4 && column<7 && (grid[row+1][column+2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+1][column+2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+1][column+2].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row+1][column+2];}
			else{array_push(moveableSpaces,grid[row+1][column+2]);}
		}
		if(row<3 && column>0 && (grid[row+2][column-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+2][column-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+2][column-1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row+2][column-1];}
			else{array_push(moveableSpaces,grid[row+2][column-1]);}
		}
		if(row<3 && column<8 && (grid[row+2][column+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+2][column+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+2][column+1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row+2][column+1];}
			else{array_push(moveableSpaces,grid[row+2][column+1]);}
		}
	#endregion
	break;
	case oBishopB: case oBishopW:
	#region Bishop Movement
		var BorW = (object_index==oBishopB);
	
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
				else{search=false;}
			}
		}
		#endregion
		
		break;
	#endregion
	break;
	case oRookB: case oRookW:
	#region Rook Movement
		var BorW = (object_index==oRookB);
		
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
				else{search=false;}
			}
		}
		#endregion
		
		break;
	#endregion
	break;
	case oQueenB: case oQueenW:
	#region Queen Movement
		var BorW = (object_index==oQueenB);
		
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
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
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
				}
				else if(((BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceW))
					||((!BorW) && object_is_ancestor(grid[curRow][curCol].myPiece.object_index,oChessPieceB)))
				{
					if(moveableSpaces==undefined){moveableSpaces[0] = grid[curRow][curCol];}
					else{array_push(moveableSpaces,grid[curRow][curCol]);}
					search=false;
				}
				else{search=false;}
			}
		}
		#endregion
	#endregion
	break;
	case oKingB: case oKingW:
	#region King Movement
		var BorW = (object_index==oKingB);
		
		if(row>0 && column>0 && (grid[row-1][column-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-1][column-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-1][column-1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row-1][column-1];}
			else{array_push(moveableSpaces,grid[row-1][column-1]);}
		}
		if(row>0 && (grid[row-1][column].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-1][column].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-1][column].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row-1][column];}
			else{array_push(moveableSpaces,grid[row-1][column]);}
		}
		if(row>0 && column<8 && (grid[row-1][column+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row-1][column+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row-1][column+1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row-1][column+1];}
			else{array_push(moveableSpaces,grid[row-1][column+1]);}
		}
		if(column>0 && (grid[row][column-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row][column-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row][column-1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row][column-1];}
			else{array_push(moveableSpaces,grid[row][column-1]);}
		}
		if(column<8 && (grid[row][column+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row][column+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row][column+1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row][column+1];}
			else{array_push(moveableSpaces,grid[row][column+1]);}
		}
		if(row<4 && column>0 && (grid[row+1][column-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+1][column-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+1][column-1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row+1][column-1];}
			else{array_push(moveableSpaces,grid[row+1][column-1]);}
		}
		if(row<4 && (grid[row+1][column].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+1][column].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+1][column].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row+1][column];}
			else{array_push(moveableSpaces,grid[row+1][column]);}
		}
		if(row<4 && column<8 && (grid[row+1][column+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[row+1][column+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[row+1][column+1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[row+1][column+1];}
			else{array_push(moveableSpaces,grid[row+1][column+1]);}
		}
	#endregion
	break;
	}
	
	return moveableSpaces;
}