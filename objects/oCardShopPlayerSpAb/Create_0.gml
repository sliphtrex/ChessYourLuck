spAb = -1;
depth = -999;

//are we buying or editing
shop=true;
cost = -1;
hovering = false;
hoverText = "";

start_x = x;
start_y = y;
hidden = false;

maskSurface = undefined;

image_speed=0;

function SetupSpAb()
{
	switch(spAb)
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
			cost = 10;
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
}