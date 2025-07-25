//This finds the appropriate oMatchManager based on the last character we talked to
//if we haven't talked to anyone, it's assumed this is the tutorial.

if(global.ConvoChar==undefined)
{
	instance_create_layer(0,0,"Text",oTutManager);
	instance_destroy();
}
else if(global.ConvoChar=="Savannah")
{
	switch(global.SavannahMatchNum)
	{
		case 0: instance_create_layer(0,0,"Text",oSavannahManager0); break;
	}
	instance_destroy();
}