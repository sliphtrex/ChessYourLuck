specialAbility = -1;
playerAb = false;
hoverText = "";
cost = -1;
hovering = false;
image_speed=0;

function Setup()
{
	draw_set_font(global.font_main);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	switch(specialAbility)
	{
		case 0:
			sprite_index = sprAbSurvival;
			hoverText = "Creates a king with 1HP and 1ATK";
			cost = 5;
		break;
		case 2:
			sprite_index = sprAbSociety;
			hoverText = "Any of your pieces which border another gains 3 HP";
			cost = 15;
		break;
		case 14:
			sprite_index = sprAbPragma;
			hoverText = "Allows a piece that would be captured to survive with 1HP";
			cost = 5;
		break;
		case 18:
			sprite_index = sprAbPhilautia;
			hoverText = "Each piece you control gains 1HP";
			cost = 10;
		break;
		case 34:
			sprite_index = sprAbPain;
			hoverText = "Choose a piece. This piece loses 1 health.\n(Does not work on kings)";
			cost = 3;
		break;
		default:
			sprite_index = sprEmptyAb;
		break;
	}
	
	image_index = 1;
}

/***********************************************************************************
* This function is called both on setup and on execution for some abilities.
*
* This function is first called with no arguments when this ability icon is clicked
* (or called by the AI). The switch case will try to use the ability on the first
* pass through and, if obj is needed and not set, it will call the oField function
* SpecialAbilityInProgress() where the necessary gridTiles will be selected. When
* one of these tiles is clicked, it will send another call to the function, this
* time with a reference to the object we need.
***********************************************************************************/
function UseAbility(obj=undefined)
{
	var used = false;
	
	//find our ability and use it
	switch(specialAbility)
	{
		#region survival
		case 0:
			//here we need the oGridTile object
			if(obj==undefined){instance_find(oField,0).SpecialAbilityInProgress(id);}
			else
			{
				var BorW = playerAb;
				obj.myPiece = instance_create_layer(obj.x,obj.y,"ChessPieces",
					(BorW) ? oKingB : oKingW);
				obj.myPiece.depth = obj.depth-1;
				obj.myPiece.Attack = 1; obj.myPiece.Health = 1;
				obj.myPiece.row = obj.row; obj.myPiece.column = obj.column;
				obj.myPiece.myTile = obj.id;
				instance_find(oField,0).AddPiece(obj.myPiece);
				show_debug_message(string("(")+string(obj.myPiece.x)+","+string(obj.myPiece.y)+")");
				
				used = true;
			}
		break;
		#endregion
		#region society
		case 2:
			var BorW = playerAb;
			var BorWPieces = (BorW) ? instance_find(oField,0).blackPieces
				: instance_find(oField,0).whitePieces;
			for(var i=0;i<array_length(BorWPieces);i++)
			{
				var myTile = BorWPieces[i];
				var grid = instance_find(oField,0).grid;
				var adjacentPiece=false;
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
						&& object_is_ancestor(borderingPieces[j].object_index,
						(BorW)? oChessPieceB : oChessPieceW))
					{
						adjacentPiece=true;
					}
				}
				
				if(adjacentPiece) {BorWPieces[i].Health+=3; used=true;}
			}
		break;
		#endregion
		#region pragma
		case 14:
			//here we need the specific chess piece
			if(obj==undefined){instance_find(oField,0).SpecialAbilityInProgress(id);}
			else
			{
				if(obj.pragma)
				{
					show_debug_message("This piece already has pragma active.");
				}
				else
				{
					obj.pragma = true;
					show_debug_message(obj.pragma);
					used = true;
				}
			}
		break;
		#endregion
		#region philautia
		case 18:
			var BorW = playerAb;
			var BorWPieces = (BorW) ? instance_find(oField,0).blackPieces
				: instance_find(oField,0).whitePieces;
			for(var i=0;i<array_length(BorWPieces);i++)
			{BorWPieces[i].Health++;}
			used=true;
		break;
		#endregion
		#region pain
		case 34:
			//here we need the specific chess piece
			if(obj==undefined){instance_find(oField,0).SpecialAbilityInProgress(id);}
			else{obj.Health-=1; used = true;}
		break;
		#endregion
		default:
		break;
	}
	//if we used the ability we should have set it true in the switch case
	if(used)
	{
		//pay for the ability
		if(playerAb){global.pSpade.spadePips-=cost;}
		else{global.opSpade.spadePips-=cost;}
		//reset the field
		instance_find(oField,0).abilityInProgress = undefined;
		instance_find(oField,0).UnselectTiles();
	}
}

function CheckIfUsable()
{
	if((playerAb && global.pSpade.spadePips>=cost)
		||(!playerAb && global.opSpade.spadePips>=cost))
	{return true;} else {return false;}
}

/*****Special Ability Edge Case Functions*****/