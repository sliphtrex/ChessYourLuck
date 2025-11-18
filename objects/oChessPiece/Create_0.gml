Health=1;
Attack=1;
row = undefined;
column = undefined;
myTile=undefined;
hasMoved = false;

pragma=false;
image_speed=0;

//returns an array of oGridTiles that we can move to from a given space[r][c]
function GetMoveableSpaces(r=row,c=column)
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
			if(r>0 && grid[r-1][c].myPiece==undefined)
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[r-1][c];}
				else{array_push(moveableSpaces,grid[r-1][c]);}
			}
		
			if(r>0 && c>0 && grid[r-1][c-1].myPiece!=undefined
				&& object_is_ancestor(grid[r-1][c-1].myPiece.object_index,
					(BorW) ? oChessPieceW : oChessPieceB))
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[r-1][c-1];}
				else{array_push(moveableSpaces,grid[r-1][c-1]);}
			}
		
			if(r>0 && c<8 && grid[r-1][c+1].myPiece!=undefined
				&& object_is_ancestor(grid[r-1][c+1].myPiece.object_index,
					(BorW) ? oChessPieceW : oChessPieceB))
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[r-1][c+1];}
				else{array_push(moveableSpaces,grid[r-1][c+1]);}
			}
		}
		else
		{
			if(r<4 && grid[r+1][c].myPiece==undefined)
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[r+1][c];}
				else{array_push(moveableSpaces,grid[r+1][c]);}
			}
		
			if(r<4 && c>0 && grid[r+1][c-1].myPiece!=undefined
				&& object_is_ancestor(grid[r+1][c-1].myPiece.object_index,
					(BorW) ? oChessPieceW : oChessPieceB))
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[r+1][c-1];}
				else{array_push(moveableSpaces,grid[r+1][c-1]);}
			}
		
			if(r<4 && c<8 && grid[r+1][c+1].myPiece!=undefined
				&& object_is_ancestor(grid[r+1][c+1].myPiece.object_index,
					(BorW) ? oChessPieceW : oChessPieceB))
			{
				if(moveableSpaces==undefined){moveableSpaces[0] = grid[r+1][c+1];}
				else{array_push(moveableSpaces,grid[r+1][c+1]);}
			}
		}
	#endregion
	break;
	case oKnightB: case oKnightW:
	#region Knight Movement
		var BorW = (object_index==oKnightB);
		
		if(r>1 && c>0 && (grid[r-2][c-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r-2][c-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r-2][c-1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r-2][c-1];}
			else{array_push(moveableSpaces,grid[r-2][c-1]);}
		}
		if(r>1 && c<8 && (grid[r-2][c+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r-2][c+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r-2][c+1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r-2][c+1];}
			else{array_push(moveableSpaces,grid[r-2][c+1]);}
		}
		if(r>0 && c>1 && (grid[r-1][c-2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r-1][c-2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r-1][c-2].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r-1][c-2];}
			else{array_push(moveableSpaces,grid[r-1][c-2]);}
		}
		if(r>0 && c<7 && (grid[r-1][c+2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r-1][c+2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r-1][c+2].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r-1][c+2];}
			else{array_push(moveableSpaces,grid[r-1][c+2]);}
		}
		if(r<4 && c>1 && (grid[r+1][c-2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r+1][c-2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r+1][c-2].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r+1][c-2];}
			else{array_push(moveableSpaces,grid[r+1][c-2]);}
		}
		if(r<4 && c<7 && (grid[r+1][c+2].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r+1][c+2].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r+1][c+2].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r+1][c+2];}
			else{array_push(moveableSpaces,grid[r+1][c+2]);}
		}
		if(r<3 && c>0 && (grid[r+2][c-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r+2][c-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r+2][c-1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r+2][c-1];}
			else{array_push(moveableSpaces,grid[r+2][c-1]);}
		}
		if(r<3 && c<8 && (grid[r+2][c+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r+2][c+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r+2][c+1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r+2][c+1];}
			else{array_push(moveableSpaces,grid[r+2][c+1]);}
		}
	#endregion
	break;
	case oBishopB: case oBishopW:
	#region Bishop Movement
		var BorW = (object_index==oBishopB);
	
		#region UpLeft Diagonal Movement
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		curRow=r;
		curCol=c;
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
		
		if(r>0 && c>0 && (grid[r-1][c-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r-1][c-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r-1][c-1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r-1][c-1];}
			else{array_push(moveableSpaces,grid[r-1][c-1]);}
		}
		if(r>0 && (grid[r-1][c].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r-1][c].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r-1][c].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r-1][c];}
			else{array_push(moveableSpaces,grid[r-1][c]);}
		}
		if(r>0 && c<8 && (grid[r-1][c+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r-1][c+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r-1][c+1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r-1][c+1];}
			else{array_push(moveableSpaces,grid[r-1][c+1]);}
		}
		if(c>0 && (grid[r][c-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r][c-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r][c-1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r][c-1];}
			else{array_push(moveableSpaces,grid[r][c-1]);}
		}
		if(c<8 && (grid[r][c+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r][c+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r][c+1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r][c+1];}
			else{array_push(moveableSpaces,grid[r][c+1]);}
		}
		if(r<4 && c>0 && (grid[r+1][c-1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r+1][c-1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r+1][c-1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r+1][c-1];}
			else{array_push(moveableSpaces,grid[r+1][c-1]);}
		}
		if(r<4 && (grid[r+1][c].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r+1][c].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r+1][c].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r+1][c];}
			else{array_push(moveableSpaces,grid[r+1][c]);}
		}
		if(r<4 && c<8 && (grid[r+1][c+1].myPiece==undefined
			||((BorW) && object_is_ancestor(grid[r+1][c+1].myPiece.object_index,oChessPieceW))
			||((!BorW) && object_is_ancestor(grid[r+1][c+1].myPiece.object_index,oChessPieceB))))
		{
			if(moveableSpaces==undefined){moveableSpaces[0] = grid[r+1][c+1];}
			else{array_push(moveableSpaces,grid[r+1][c+1]);}
		}
	#endregion
	break;
	}
	
	return moveableSpaces;
}
