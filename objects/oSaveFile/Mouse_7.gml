if(saving)
{
	SaveGame("CYL"+string(myFile)+".sav");
	if(sprite_index==sprLargeBlueCardBack)
	{saved=true; flipCard=true;}
}
else
{
	if(saved)
	{
		LoadGame("CYL"+string(myFile)+".sav");
		if(instance_exists(oPlayButton)){instance_find(oPlayButton,0).image_index=1;}
		with(oSaveFile){MoveOut();}
		if(instance_exists(oLoadButton)){instance_find(oLoadButton,0).loading=false;}
	}
}