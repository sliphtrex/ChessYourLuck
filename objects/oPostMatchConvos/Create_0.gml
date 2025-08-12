if(global.curTable==undefined)
{
	global.curTable=0;
	global.ConvoChar = "Anu";
	StartConvo();
}
else if(global.postMatch)
{
	show_debug_message("was the player defeated: "+string(global.playerDefeated));
	if(global.playerDefeated)
	{
		switch(global.ConvoChar)
		{
			case "Anu": break;
			case "Savannah": SavannahWin(); break;
		}
	}
	else
	{
		switch(global.ConvoChar)
		{
			case "Anu": break;
			case "Savannah": SavannahLose(); break;
		}
	}
}