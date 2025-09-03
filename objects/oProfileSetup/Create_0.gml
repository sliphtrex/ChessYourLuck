with(instance_create_layer(x,y,"Text",eDialogManager))
{
	voidsettings();
	add_page("Alright. Next order of business.");
	add_page("Before you can proceed, we must define your form.",350,375);
	add_page_action(CharacterSelect);
}

function CharacterSelect()
{
	next_page();
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
	
	with(instance_create_layer(x,y,"Text",eDialogManager))
	{
		voidsettings();
		add_page("Out of the following options, how would you most like to be perceived by others?",350,375);
		add_page_action(CharacterSelect);
	}
}

function CharacterSelectedCheck()
{
	show_debug_message(global.PlayerIcon);
	if(global.PlayerIcon==0||global.PlayerIcon==1||global.PlayerIcon==2||global.PlayerIcon==3){next_page();LastChance();}
}

function LastChance()
{
	with(oCharIcon){instance_destroy();}
	with(instance_create_layer(x,y,"Text",eDialogManager))
	{
		var iconString = undefined;
		switch(global.PlayerIcon)
		{
			case 0: iconString = "man"; break;
			case 1: iconString = "woman"; break;
			case 2: iconString = "dog"; break;
			case 3: iconString = "cat"; break;
		}
		
		voidsettings();
		add_page("You've chosen "+iconString+".");
		Add_Text("Are you sure you're happy with your choice? This will impact how your story unfolds.");
			add_option("Yes",FinalWords2);
			add_option("Not sure", CharacterSelect);
	}
}

function FinalWords2()
{
	with(add_detatched_branch(true))
	{
		add_page("Very good.");
		add_page("Your tangible form will appear as such.",350,375);
		add_page("Over the next fortnight, you will meet many new faces.",350,375);
		add_page("Weary traveller, I implore you to get to know them well.",575,375);
		add_page_action(EndTut);
	}
}

function EndTut()
{
	var trans = instance_create_layer(0,0,"Text",oFadeTransition);
	trans.nextRoom = rRainyKnightsCafe;
}