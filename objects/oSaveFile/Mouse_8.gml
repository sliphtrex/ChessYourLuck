if(file_exists("CYL"+string(myFile)+".sav"))
{
	file_delete("CYL"+string(myFile)+".sav");
	saved=false;
	deleting=true;
	flipCard=true;
}