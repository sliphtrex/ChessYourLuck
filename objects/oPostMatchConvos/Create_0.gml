if(global.curTable==undefined)
{
	global.curTable=0;
	global.ConvoChar = "Anu";
	StartConvo();
}
else if(global.postMatch){ResetCheckpoints(); StartConvo();}