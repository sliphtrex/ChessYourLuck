if(!(global.DayPart==0 && global.DayNum==0))
{
	global.DayPart--;
	if(global.DayPart==-1){global.DayPart=2; global.DayNum--;}
	ResetRoom();
}