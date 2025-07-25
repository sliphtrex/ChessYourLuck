// 1=Special Ability, 0=Card
itemType = -1;
item = -1;
image_speed=0;

function Setup()
{
	if(itemType==0)
	{
		switch(item)
		{
			case 52: sprite_index = spr_1oS; break;
			case 53: sprite_index = spr_1oD; break;
			case 54: sprite_index = spr_13oS; break;
			case 55: sprite_index = spr_13oD; break;
			case 56: sprite_index = spr_15oS; break;
			case 57: sprite_index = spr_15oD; break;
		}
	}
	else if(itemType==1)
	{
		switch(item)
		{
			case 0: sprite_index = sprAbSurvival; break;
			case 2: sprite_index = sprAbSociety; break;
			case 14: sprite_index = sprAbPragma; break;
			case 18: sprite_index = sprAbPhilautia; break;
		}
		image_index=0;
	}
}