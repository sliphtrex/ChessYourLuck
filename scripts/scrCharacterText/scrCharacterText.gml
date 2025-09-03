//This is called whenever we start a dialogue after we've set global.ConvoChar.
//It determines which character we're talking to and sends us to that char's dialogue options
function CharacterText()
{
	switch(global.ConvoChar)
	{
		case "Savannah":
			SavannahText();
		break;
		case "Anu":
			AnuText();
		break;
	}
}

#region Anu Convos / Card Shop
//This determines if Anu has available dialogue and generates it if it exists
function AnuText()
{
	rkcsettings("Anu");
	switch(global.AnuConvos)
	{
		case -1:
			global.AnuConvos=2;
			add_page("I'm sorry. It appears as though you don't have any spare cards with which to edit your deck. Why not try buying some first?");
			break;
		case 0:
			global.AnuConvos++;
			add_page("Ah! Welcome weary traveller.\nIt is I. Anu!\n\nAm I how you expected?\n(Don't worry this is simply placeholder art for now.)");
			add_page("Welcome to the Rainy Knight's Cafe.\nI am the one and only Rainy Knight.\n\nWhy do they call me that?\nOnly time will tell.");
			add_page("At any rate. This is the card shop. Since it is your first venture here I will give you some funds.");
			global.AnuConvos++;
			global.pDiamonds += (30-global.pDiamonds);
			add_page("There you go friend! Diamonds are the currency around here.\n\nNow, if you'd like to buy something, click the item on the shelf.\nYou can also talk to me if you just want to edit your deck or abilities.");
			break;


		default:
				add_page("So, how can I be of service?");
				add_option("Edit Special Abilities", SelectedEditSpAbs);
				add_option("Edit Deck",SelectedEditDeck);
				add_option("Back", function(){
					with(add_detatched_branch(true)){
						add_page("Thank you for your patronage. Until nex time...");
					}
				});
		break;
	}
}

function SelectedEditDeck()
{
	next_page();
	if(array_length(global.PlayerSpareCards)>0)
	{instance_find(oShopGenerator,0).SetupDeckEditor();}
	else
	{global.AnuConvos=-1; StartConvo();}
}

function SelectedEditSpAbs()
{next_page();instance_find(oShopGenerator,0).SetupSpAbEditor();}

#endregion

#region Savannah's Story

function SavannahWin()
{
	with(instance_create_layer(global.curTable*1920,780,"Text",eCharacterDialog))
	{
			add_page("Heyo! That's just how the cookie crumbles sometimes.\nDon't worry. Be Happy.\n There's always tomorrow.");
			add_page_action(ChangeDayPart);
	}
}

function SavannahLose()
{
	with(instance_create_layer(global.curTable*1920,780,"Text",eCharacterDialog))
	{
			add_page("Yo, what the heck! That's crazy!\nYou must have cheated.\nNo way you're that good.\nAlright, game recognizes game.");
			add_page_action(ChangeDayPart);
	}
}

//This determines where we are in Savannah's story and generates the appropriate dialogue
function SavannahText()
{
	rkcsettings("Savannah");
	switch(global.SavannahConvos)
	{
		case 0:
			add_page("Heyo, I'm Savannah. Nice to meet you.\nPeace, love, and wubs and all that jazz.");
			add_page("Tell me, what do you think of Anu?");
				add_option("He's alright, I guess.",SavannahBadChoice);
				add_option("I'm not sure yet.",SavannahGoodChoice);
		break;
		case 1:
			add_page("I should've known you'd take his side.\nYou seem like two peas in a pod.\nAll buddy buddy type.");
			add_page("Okay, you can go now. I don't have time for the likes of you.");
			global.SavannahConvos--;
		break;
		case 2:
			add_page("Right!?! That's what I'm saying man! You can't trust him either can you?\n\nI knew you'd be the type to agree with me. We homies now.");
			add_page("I'm telling you though, it's always the quiet ones who you can't trust. You think everything is fine until they stab you in the back.\n\nNo warnings!\nCold blooded.");
			add_page_action(PreviewPlayer);
		break;
	}
}

//handles good player responses for Savannah
function SavannahGoodChoice()
{
	next_page();
	show_debug_message("Good Choice");
	switch(global.SavannahConvos)
	{
		case 0:
			global.SavannahConvos+=2;
		break;
	}
	StartConvo();
}

//handles bad player responses for Savannah
function SavannahBadChoice()
{
	next_page();
	show_debug_message("Bad Choice");
	switch(global.SavannahConvos)
	{
		case 0:
			global.SavannahConvos++;
		break;
	}
	StartConvo();
}
#endregion

//the oMatchPreviewer object will set up the appropriate preview for a given match using
//the MatchPreview variable to determine which character we're currently talking to and
//that player's Match number to determine what their deck and abilities will look like.
function PreviewPlayer()
{
	next_page();
	instance_create_layer(0,0,"UILayer",oMatchPreviewer);
}

function ChangeDayPart()
{
	next_page();
	if(!(global.DayPart==2 && global.DayNum==13))
	{
		global.postMatch = false;
		global.DayPart++;
		if(global.DayPart==3){global.DayPart=0; global.DayNum++;}
	}
	
	curX = camera_get_view_x(view_camera[0]);
	instance_create_layer(curX,0,"Text",oFadeTransition);
}
