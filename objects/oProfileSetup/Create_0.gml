with(instance_create_layer(x,y,"Text",oVoidTextBox))
{
	Add_Text("Alright. Next order of business.",1);
	Add_Text("Before you can proceed, we must define your form.",1,undefined,350,375);
	NextMove = CharacterSelect;
}

function CharacterSelect()
{
	show_debug_message("in CharacterSelect");
	charSelected=false;
	
	charIcons[0] = instance_create_layer(x,y,"UILayer",oCharIcon);
	charIcons[0].icon = 0;
	charIcons[0].Setup();
	charIcons[1] = instance_create_layer(x,y,"UILayer",oCharIcon);
	charIcons[1].icon = 1;
	charIcons[1].Setup();
	charIcons[2] = instance_create_layer(x,y,"UILayer",oCharIcon);
	charIcons[2].icon = 2;
	charIcons[2].Setup();
	if(global.DogPlaythroughComplete)
	{
		charIcons[3] = instance_create_layer(x,y,"UILayer",oCharIcon);
		charIcons[3].icon = 3;
		charIcons[3].Setup();
	}
	
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Out of the following options, how would you most like to be perceived by others?",1,undefined,350,375,CharacterSelectedCheck);
		NextMove = LastChance;
	}
}

function CharacterSelectedCheck()
{
	show_debug_message(global.PlayerIcon);
	if(global.PlayerIcon==0||global.PlayerIcon==1||global.PlayerIcon==2||global.PlayerIcon==3){return true;}
	else{return false;}
}

function LastChance()
{
	with(oCharIcon){instance_destroy();}
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		var iconString = undefined;
		switch(global.PlayerIcon)
		{
			case 0: iconString = "man"; break;
			case 1: iconString = "woman"; break;
			case 2: iconString = "dog"; break;
			case 3: iconString = "cat"; break;
		}
		Add_Text("You've chosen "+iconString+".",1);
		Add_Text("Are you sure you're happy with your choice? This will impact how your story unfolds.",1);
			Add_Option("Yes",FinalWords2);
			Add_Option("Not sure", CharacterSelect);
	}
}

function FinalWords2()
{
	with(instance_create_layer(x,y,"Text",oVoidTextBox))
	{
		Add_Text("Very good.",1);
		Add_Text("Your tangible form will appear as such.",1,undefined,350,375);
		Add_Text("Over the next fortnight, you will meet many new faces.",1,undefined,350,375);
		Add_Text("Weary traveller, I implore you to get to know them well.",1,undefined,575,375);
		NextMove = EndTut;
	}
}

function EndTut()
{
	var trans = instance_create_layer(0,0,"Text",oFadeTransition);
	trans.nextRoom = rRainyKnightsCafe;
}