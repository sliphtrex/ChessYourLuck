sprite_index = sprPlayerIcon;
image_speed=0;
icon = -1;

function Setup()
{
	image_index = icon;
	switch(icon)
	{
		case 0: x=300; break;
		case 1: x=600; break;
		case 2: x=900; break;
		case 3: x=1200; break;
		default: break;
	}
}