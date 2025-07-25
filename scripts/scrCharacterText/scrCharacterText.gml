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
	switch(global.AnuConvos)
	{
		case -1:
			global.AnuConvos=2;
			Add_Text("I'm sorry. It appears as though you don't have any spare cards with which to edit your deck. Why not try buying some first?");
			break;
		case 0:
			global.AnuConvos++;
			Add_Text("Ah! Welcome weary traveller.\nIt is I. Anu!\n\nAm I how you expected?\n(Don't worry this is simply placeholder art for now.)");
			Add_Text("Welcome to the Rainy Knight's Cafe.\nI am the one and only Rainy Knight.\n\nWhy do they call me that?\nOnly time will tell.");
			Add_Text("At any rate. This is the card shop. Since it is your first venture here I will give you some funds.");
			NextMove=StartConvo;
		break;
		case 1:
			global.AnuConvos++;
			global.pDiamonds += (30-global.pDiamonds);
			Add_Text("There you go friend! Diamonds are the currency around here.\n\nNow, if you'd like to buy something, click the item on the shelf.\nYou can also talk to me if you just want to edit your deck or abilities.");
		break;
		default:
			Add_Text("So, how can I be of service?");
				Add_Option("Edit Special Abilities", SelectedEditSpAbs);
				Add_Option("Edit Deck",SelectedEditDeck);
		break;
	}
}

function SelectedEditDeck()
{
	if(array_length(global.PlayerSpareCards)>0)
	{instance_find(oShopGenerator,0).SetupDeckEditor();}
	else
	{global.AnuConvos=-1; StartConvo();}
}

function SelectedEditSpAbs()
{instance_find(oShopGenerator,0).SetupSpAbEditor();}

#endregion

#region Savannah's Story
//This determines where we are in Savannah's story and generates the appropriate dialogue
function SavannahText()
{
	switch(global.SavannahConvos)
	{
		case 0:
			Add_Text("Heyo, I'm Savannah. Nice to meet you.\nPeace, love, and wubs and all that jazz.");
			Add_Text("Tell me, what do you think of Anu?");
				Add_Option("He's alright, I guess.",SavannahBadChoice);
				Add_Option("I'm not sure yet.",SavannahGoodChoice);
		break;
		case 1:
			Add_Text("I should've known you'd take his side.\nYou seem like two peas in a pod.\nAll buddy buddy type.");
			Add_Text("Okay, you can go now. I don't have time for the likes of you.");
			global.SavannahConvos--;
		break;
		case 2:
			Add_Text("Right!?! That's what I'm saying man! You can't trust him either can you?\n\nI knew you'd be the type to agree with me. We homies now.");
			Add_Text("I'm telling you though, it's always the quiet ones who you can't trust. You think everything is fine until they stab you in the back.\n\nNo warnings!\nCold blooded.");
			NextMove = PreviewPlayer;
		break;
	}
}

//handles good player responses for Savannah
function SavannahGoodChoice()
{
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
	instance_create_layer(0,0,"UILayer",oMatchPreviewer);
}