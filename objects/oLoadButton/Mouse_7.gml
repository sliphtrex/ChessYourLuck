if(!loading)
{
	if(!instance_exists(oSaveFile))
	{
		save1 = instance_create_layer(-500,540,"Instances",oSaveFile);
		save1.myFile=1;
		save1.saving=false;
		save1.Setup();
		//835 = middle of screen accounting for righthand menu
		save2 = instance_create_layer(835,-500,"Instances",oSaveFile);
		save2.myFile=2;
		save2.saving=false;
		save2.Setup();
		save3 = instance_create_layer(2420,540,"Instances",oSaveFile);
		save3.myFile=3;
		save3.saving=false;
		save3.Setup();
	
		loading = true;
	}
}
else
{
	with(oSaveFile){MoveOut();}
	loading = false;
}