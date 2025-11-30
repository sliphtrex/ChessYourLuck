if(type==0)
{
	x-=boxSpeed;
	offScreen = 0-(string_width(text)+border*2);
	if(x<offScreen){instance_destroy();}
}
else if(type==1)
{
	if(curTimer==1){totalTime=textDuration*room_speed;}
	if(curTimer==totalTime){instance_destroy();}
	curTimer++;
}