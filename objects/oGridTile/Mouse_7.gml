if(instance_find(oMatchManager,0).pTurn && CheckForIcons())
{
	//if this tile is highlighted we're either placing a piece or moving one
	if(selectable)
	{
		var ability = instance_find(oField,0).abilityInProgress;
		
		//if we're holding a card we want to create a piece
		if(global.pHand.cardSelected!=undefined)
		{
			//create the piece
			PlayPiece(true);
		}
		//otherwise we may be using a special ability
		else if(ability!=undefined)
		{
			switch(ability.specialAbility)
			{
				case 0:
					show_debug_message(string("(")+string(x)+","+string(y)+")");
					ability.UseAbility(id);
				break;
				case 14: case 34:
					ability.UseAbility(myPiece);
				break;
			}
		}
		//if there's no card selected and no ability, then we're moving a piece
		else
		{
			//if it's not the first move of the game
			if(instance_find(oMatchManager,0).Turn!=0||!instance_find(oMatchManager,0).pStart)
			{instance_find(oField,0).MovePieceToPlace(row,column);}
		}
	}
	//if not we may be moving, upgrading, or graduating a piece
	else
	{
		var BorW = !instance_find(oMatchManager,0).pStart;
		//if a card is selected and we click one of our pieces, we're upgrading
		if(global.pHand.cardSelected!=undefined && myPiece!=undefined
			&& ((BorW && object_is_ancestor(myPiece.object_index,oChessPieceB))
			||(!BorW && object_is_ancestor(myPiece.object_index,oChessPieceW))))
		{
			UpgradePiece(true);
		}
		//if there's no card selected and we click one of our pieces,
		else if(global.pHand.cardSelected==undefined && myPiece!=undefined
			&& ((BorW && object_is_ancestor(myPiece.object_index,oChessPieceB))
			||(!BorW && object_is_ancestor(myPiece.object_index,oChessPieceW))))
		{
			//if it's not the first turn and/or we're not making the first move
			if(instance_find(oMatchManager,0).Turn!=0||!instance_find(oMatchManager,0).pStart)
			{
				//either show the move options if there's no piece selected
				if(instance_find(oField,0).pieceSelected==undefined && !myPiece.hasMoved)
				{
					instance_find(oField,0).HighlightMoveableSpaces(myPiece);
				}
				//unselect move options if we're clicking the same piece again.
				else if(instance_find(oField,0).pieceSelected!=undefined
					&& instance_find(oField,0).pieceSelected == myPiece)
				{
					instance_find(oField,0).UnselectTiles();
				}
				//or unhighlight and recalculate move options if we select a new piece
				else if(instance_find(oField,0).pieceSelected!=undefined
					&& instance_find(oField,0).pieceSelected != myPiece
					&& !myPiece.hasMoved)
				{
					//if the old piece was a graduated pawn we shoud get rid of it's
					//upgrade options
					if(instance_find(oField,0).pieceSelected.object_index==oPawnB
						&&instance_find(oField,0).pieceSelected.graduated)
					{instance_find(oField,0).pieceSelected.DestroyIcons();}
				
					instance_find(oField,0).UnselectTiles();
					instance_find(oField,0).HighlightMoveableSpaces(myPiece);
				}
			}
			
			//if we click a pawn and it's able to graduate,
			//we need to display it's upgrade icons
			if(((BorW && myPiece.object_index==oPawnB) || (!BorW && myPiece.object_index==oPawnW))
				&& myPiece.graduated)
			{
				//toggle upgrade options
				if(!myPiece.selected) {myPiece.CreateIcons();}
				else {myPiece.DestroyIcons();}
			}
		}
	}
}