myPiece = undefined;
selectable = false;
row = undefined;
column = undefined;

image_speed=0;
image_index=0;

function BecomeSelectable()
{
	selectable=true;
	image_index=1;
}

function BecomeUnselectable()
{
	selectable=false;
	image_index=0;
}

function SetupKing(BorW)
{
	myPiece = instance_create_layer(x,y,"ChessPieces",
		(BorW) ? oKingB : oKingW);
	myPiece.Attack = 1;
	myPiece.Health = 5;
	myPiece.row = row;
	myPiece.column = column;
	myPiece.myTile = id;
	instance_find(oField,0).AddPiece(myPiece);
}

///@param bool
function PlayPiece(_playerPiece)
{
	var BorW = instance_find(oMatchManager,0).pStart;
	if(_playerPiece){BorW = !BorW;}
	
	var ourHand = (_playerPiece) ? global.pHand : global.opHand;
	
	switch(ourHand.cardSelected.pips)
	{
	case 1: case 2: case 3: case 4:
		myPiece = instance_create_layer(x,y,"ChessPieces",
		(BorW) ? oPawnB : oPawnW);
		break;
	case 5: case 6: case 7:
		myPiece = instance_create_layer(x,y,"ChessPieces",
		(BorW) ? oKnightB : oKnightW);
		break;
	case 8: case 9: case 10:
		myPiece = instance_create_layer(x,y,"ChessPieces",
		(BorW) ? oBishopB : oBishopW);
		break;
	case 11:
		myPiece = instance_create_layer(x,y,"ChessPieces",
		(BorW) ? oRookB : oRookW);
		break;
	case 12:
		myPiece = instance_create_layer(x,y,"ChessPieces",
		(BorW) ? oQueenB : oQueenW);
		break;
	case 13:
		myPiece = instance_create_layer(x,y,"ChessPieces",
		(BorW) ? oKingB : oKingW);
		break;
	case 14:
		myPiece = instance_create_layer(x,y,"ChessPieces",
		(BorW) ? oPawnB : oPawnW);
		myPiece.graduated=true;
		break;
	}
		
	myPiece.Attack = clamp(ourHand.cardSelected.clubs,1,10);
	myPiece.Health = clamp(ourHand.cardSelected.hearts,1,10);
	myPiece.row = row; myPiece.column = column;
	myPiece.myTile = id;
	instance_find(oField,0).AddPiece(myPiece);
	
	if(ourHand.cardSelected.spades>0)
	{
		var ourSpade = (_playerPiece) ? global.pSpade : global.opSpade;
		ourSpade.AddSpades(ourHand.cardSelected.spades);
	}
	
	if(ourHand.cardSelected.diamonds>0)
	{
		if(_playerPiece){global.pDiamonds += ourHand.cardSelected.diamonds;}
		else{instance_find(oMatchManager,0).opDiamonds += ourHand.cardSelected.diamonds;}
	}
	//destroy the associated card
	ourHand.FindAndDestroy(ourHand.cardSelected);
	ourHand.cardSelected = undefined;
	
	instance_find(oField,0).UnselectTiles();
}

function UpgradePiece(_playerPiece)
{
	var ourHand = (_playerPiece) ? global.pHand : global.opHand;
	var ourSpade = (_playerPiece) ? global.pSpade : global.opSpade;
	var ourDiamonds = (_playerPiece) ? global.pDiamonds : instance_find(oMatchManager,0).opDiamonds;
	
	//we only want to upgrade the piece if the card contains clubs or hearts. 
	if(ourHand.cardSelected.suit==0 || ourHand.cardSelected.suit==1
	|| (ourHand.cardSelected.suit==-1 && ourHand.cardSelected.clubs>0)
	|| (ourHand.cardSelected.suit==-1 && ourHand.cardSelected.hearts>0))
	{
		//if it's a club we only care about power
		if(ourHand.cardSelected.suit == 0 && myPiece.Attack < 14)
		{
			myPiece.Attack += ourHand.cardSelected.clubs;
		}
		//if it's a heart we only care about health
		else if(ourHand.cardSelected.suit == 1 && myPiece.Health < 14)
		{
			myPiece.Health += ourHand.cardSelected.hearts;
		}
		//if it's an amalgam we have to update everything
		else if(ourHand.cardSelected.suit == -1)
		{
			myPiece.Attack += ourHand.cardSelected.clubs;
			myPiece.Health += ourHand.cardSelected.hearts;
			ourSpade.spadePips += ourHand.cardSelected.spades;
			ourDiamonds += ourHand.cardSelected.diamonds;
		}
		
		//destroy the associated card
		ourHand.FindAndDestroy(ourHand.cardSelected);
		ourHand.cardSelected = undefined;
			
		//deselect selectable tiles
		instance_find(oField,0).UnselectTiles();
	}
}

//we send the piece we're graduating and the icon's rank
function GraduatePawn(obj,rank)
{	
	//save these so we can copy them to the new piece
	var obja = obj.Attack;
	var objh = obj.Health;
	var objhm = obj.hasMoved;
	var newPiece=undefined;
	
	#region make the new piece
	var BorW = (object_is_ancestor(obj.object_index,oChessPieceB));
	switch(rank)
	{
		case 0:
			newPiece = instance_create_layer(obj.x,obj.y,"ChessPieces",
			(BorW) ? oKnightB : oKnightW);
		break;
		case 1:
			newPiece = instance_create_layer(obj.x,obj.y,"ChessPieces",
			(BorW) ? oBishopB : oBishopW);
		break;
		case 2:
			newPiece = instance_create_layer(obj.x,obj.y,"ChessPieces",
			(BorW) ? oRookB : oRookW);
		break;
		case 3:
			newPiece = instance_create_layer(obj.x,obj.y,"ChessPieces",
			(BorW) ? oQueenB : oQueenW);
		break;
		case 4:
			newPiece = instance_create_layer(obj.x,obj.y,"ChessPieces",
			(BorW) ? oKingB : oKingW);
		break;
	}
	
	newPiece.Attack = obja;
	newPiece.Health = objh;
	newPiece.hasMoved = objhm;
	newPiece.myTile = id;
	#endregion
	
	//remove the old piece
	instance_find(oField,0).RemovePiece(obj);
	instance_destroy(obj);
	
	//add the new piece to the player's or opponent's overall pieces
	instance_find(oField,0).AddPiece(newPiece);
	
	//also gotta tell our oGridTile to update it's own myPiece
	myPiece=newPiece;
	
	//tell the field we're done with this piece for now
	instance_find(oField,0).UnselectTiles();
}

function CheckForIcons()
{
	var notBlocked = true;
	
	if(instance_number(oGradIcon)>0)
	{
		for(var i=0; i<instance_number(oGradIcon); i++)
		{
			if(instance_find(oGradIcon,i).x > x-40
				&& instance_find(oGradIcon,i).x < x+40
				&& instance_find(oGradIcon,i).y > y-40
				&& instance_find(oGradIcon,i).y < y+40)
			{notBlocked=false;}
		}
	}
	return notBlocked;
}