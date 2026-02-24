function EndSpAb()
{
	if(!instance_find(oMatchManager,0).pTurn)
	{instance_find(oMatchManager,0).Wait();}
	instance_destroy();
}