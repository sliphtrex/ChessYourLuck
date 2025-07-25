if(setup)
{
	curSetupFrame++;
	switch(myFile)
	{
		case 1:
			//585 = offset from middle of screen accounting for righthand menu
			x = lerp(start_x,585,curSetupFrame/setupFrames);
		break;
		case 2:
			//835 = middle of screen accounting for righthand menu
			y = lerp(start_y,540,curSetupFrame/setupFrames);
		break;
		case 3:
			//1085 = offset from middle
			x = lerp(start_x,1085,curSetupFrame/setupFrames);
	}
	if(curSetupFrame==setupFrames){curSetupFrame=0; setup=false; flipCard=true;}
}

if(moveOut && !flipCard)
{
	curSetupFrame++;
	switch(myFile)
	{
		case 1:
			//585 = offset from middle of screen accounting for righthand menu
			x = lerp(585,start_x,curSetupFrame/setupFrames);
		break;
		case 2:
			//835 = middle of screen accounting for righthand menu
			y = lerp(540,start_y,curSetupFrame/setupFrames);
		break;
		case 3:
			//1085 = offset from middle
			x = lerp(1085,start_x,curSetupFrame/setupFrames);
	}
	if(curSetupFrame==setupFrames){instance_destroy();}
}