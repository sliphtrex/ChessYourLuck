if(fadeout)
{
	curFrames++;
	if(curFrames==totalFrames)
	{
		room = nextRoom;
		fadeout=false;
	}
	else
	{
		image_alpha = (curFrames/totalFrames);
		draw_self();
	}
}
else
{
	curFrames--;
	if(curFrames==0){instance_destroy();}
	else
	{
		image_alpha = (curFrames/totalFrames);
		draw_self();
	}
}