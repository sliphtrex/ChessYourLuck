//which board piece do we belong to?
myPiece=undefined;
//which rank is the icon assigned to
//0 = knight, 1 = bishop, 2 = rook, 3 = queen, 4 = king
myRank=0;
//is the mouse over us?
hovering=false;

image_speed=0;

function Setup()
{
	switch(myRank)
	{
		case 0: sprite_index = sprKnightIcon; break;
		case 1: sprite_index = sprBishopIcon; break;
		case 2: sprite_index = sprRookIcon; break;
		case 3: sprite_index = sprQueenIcon; break;
		case 4: sprite_index = sprKingIcon; break;
		default: break;
	}
}