sprite_index = sprPlayerIcon;
image_speed=0;
icon = -1;

function Setup()
{
	image_index = icon;
	
	y = room_height/2;
	
	switch(icon)
	{
		case 0:
			x = (global.DogPlaythroughComplete) ? (room_width/8) : (room_width/4);
			break;
		case 1: 
			x = (global.DogPlaythroughComplete) ? (room_width*3/8) : (room_width/2);
			break;
		case 2:
			x = (global.DogPlaythroughComplete) ? (room_width*5/8) : (room_width*3/4);
			break;
		case 3: x= (room_width*7/8); break;
		default: break;
	}
}