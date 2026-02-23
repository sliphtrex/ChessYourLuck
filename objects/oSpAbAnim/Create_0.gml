function EndSpAb()
{
	instance_find(oMatchManager,0).Wait();
	instance_destroy();
}