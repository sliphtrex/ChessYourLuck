if(!(global.DayPart==2 && global.DayNum==13))
{
	global.DayPart++;
	if(global.DayPart==3){global.DayPart=0; global.DayNum++;}
	ResetRoom();
}