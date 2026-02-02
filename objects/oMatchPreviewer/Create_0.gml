spAb1 = undefined;
spAb2 = undefined;
spAb3 = undefined;

specialCard1=undefined;
specialCard2=undefined;
specialCard3=undefined;
cardPreviewer=undefined;

border=45;
call = "";
response1="";
response2="";

switch(global.ConvoChar)
{
	case "Savannah":
		Savannah();
		break;
	case "Adam":
		Adam();
		break;
	default:
	break;
}

#region Savannah's match previews
function Savannah()
{
	switch(global.SavannahMatchNum)
	{
	case 0:
		call = "So, what's the deal with you? You wanna play a game?";
		if(global.PlayerIcon==0)
		{
			response1 = "Yeah, let's play";
			response2 = "Nah, not just yet";
		}
		else if(global.PlayerIcon==1)
		{
			response1 = "Yeah, let's do it";
			response2 = "No thanks. I'm not ready.";
		}
		else if(global.PlayerIcon==2)
		{
			response1 = "bark playfully";
			response2 = "shake head";
		}
		else if(global.PlayerIcon==3)
		{
			response1 = "long meow";
			response2 = "walk away";
		}
		//set up the preview SpAbs here
		spAb2 = instance_create_layer(camera_get_view_x(view_camera[0])+room_width-150,450,"Text",oPreviewSpAb);
		spAb2.specialAbility = 18;
		spAb2.Setup();
		spAb3 = instance_create_layer(camera_get_view_x(view_camera[0])+room_width-150,750,"Text",oPreviewSpAb);
		spAb3.specialAbility = 2;
		spAb3.Setup();
		spAb1 = instance_create_layer(camera_get_view_x(view_camera[0])+room_width-150,150,"Text",oPreviewSpAb);
		spAb1.specialAbility = 34;
		spAb1.Setup();
		//set up card preview here
		cardPreviewer = instance_create_layer(camera_get_view_x(view_camera[0]),room_height-150,"Text",oCardScroller);
		cardPreviewer.previewDeck = global.SavannahsDecks[global.SavannahMatchNum];
		cardPreviewer.Setup();
	break;
	case 1:
		//set up our text here
		call = "So anyway... want a rematch, friend?";
		if(global.PlayerIcon==0)
		{
			response1 = "Sure thing, mate";
			response2 = "Maybe later, pal";
		}
		else if(global.PlayerIcon==1)
		{
			response1 = "Sure thing, bestie";
			response2 = "Maybe later, bestie";
		}
		else if(global.PlayerIcon==2)
		{
			response1 = "bark playfully";
			response2 = "shake head";
		}
		else if(global.PlayerIcon==3)
		{
			response1 = "long meow";
			response2 = "walk away";
		}
		//set up the preview SpAbs here
		spAb2 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,450,"Text",oPreviewSpAb);
		spAb2.specialAbility = 18;
		spAb2.Setup();
		spAb3 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,750,"Text",oPreviewSpAb);
		spAb3.specialAbility = 2;
		spAb3.Setup();
		spAb1 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,150,"Text",oPreviewSpAb);
		spAb1.specialAbility = 34;
		spAb1.Setup();
		//set up card preview here
		cardPreviewer = instance_create_layer(camera_get_view_x(view_camera[0]),930,"Text",oCardScroller);
		cardPreviewer.previewDeck = global.SavannahsDecks[global.SavannahMatchNum];
		cardPreviewer.Setup();
	break;
	case 2:
		//set up our text here
		call = "Sorry, I gotta chill. We playing or what?";
		if(global.PlayerIcon==0)
		{
			response1 = "Yeah, let's play";
			response2 = "Nah, not just yet";
		}
		else if(global.PlayerIcon==1)
		{
			response1 = "Yeah, let's do it";
			response2 = "No thanks. I'm not ready.";
		}
		else if(global.PlayerIcon==2)
		{
			response1 = "bark playfully";
			response2 = "shake head";
		}
		else if(global.PlayerIcon==3)
		{
			response1 = "long meow";
			response2 = "walk away";
		}
		//set up the preview SpAbs here
		spAb2 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,450,"Text",oPreviewSpAb);
		spAb2.specialAbility = 18;
		spAb2.Setup();
		spAb3 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,750,"Text",oPreviewSpAb);
		spAb3.specialAbility = 2;
		spAb3.Setup();
		spAb1 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,150,"Text",oPreviewSpAb);
		spAb1.specialAbility = 34;
		spAb1.Setup();
		//set up card preview here
		cardPreviewer = instance_create_layer(camera_get_view_x(view_camera[0]),930,"Text",oCardScroller);
		cardPreviewer.previewDeck = global.SavannahsDecks[global.SavannahMatchNum];
		cardPreviewer.Setup();
	break;
	case 3:
		//set up our text here
		call = "I need a break. Can we play a game or what?";
		if(global.PlayerIcon==0)
		{
			response1 = "sure, whatever you need";
			response2 = "I'll be back";
		}
		else if(global.PlayerIcon==1)
		{
			response1 = "Sounds good";
			response2 = "give me a minute";
		}
		else if(global.PlayerIcon==2)
		{
			response1 = "nudge piece with nose";
			response2 = "shake head";
		}
		else if(global.PlayerIcon==3)
		{
			response1 = "paw at chess board";
			response2 = "walk away";
		}
		//set up the preview SpAbs here
		spAb2 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,450,"Text",oPreviewSpAb);
		spAb2.specialAbility = 18;
		spAb2.Setup();
		spAb3 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,750,"Text",oPreviewSpAb);
		spAb3.specialAbility = 2;
		spAb3.Setup();
		spAb1 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,150,"Text",oPreviewSpAb);
		spAb1.specialAbility = 34;
		spAb1.Setup();
		//set up card preview here
		cardPreviewer = instance_create_layer(camera_get_view_x(view_camera[0]),930,"Text",oCardScroller);
		cardPreviewer.previewDeck = global.SavannahsDecks[global.SavannahMatchNum];
		cardPreviewer.Setup();
	break;
	case 4:
		//set up our text here
		call = "Woah, okay. I need a match to distract me from this high.";
		if(global.PlayerIcon==0)
		{
			response1 = "One match, coming up";
			response2 = "Sorry, I can't";
		}
		else if(global.PlayerIcon==1)
		{
			response1 = "Sure thing, bestie";
			response2 = "Maybe later, bestie";
		}
		else if(global.PlayerIcon==2)
		{
			response1 = "nudge piece with nose";
			response2 = "shake head";
		}
		else if(global.PlayerIcon==3)
		{
			response1 = "paw at chess board";
			response2 = "walk away";
		}
		//set up the preview SpAbs here
		spAb2 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,450,"Text",oPreviewSpAb);
		spAb2.specialAbility = 18;
		spAb2.Setup();
		spAb3 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,750,"Text",oPreviewSpAb);
		spAb3.specialAbility = 2;
		spAb3.Setup();
		spAb1 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,150,"Text",oPreviewSpAb);
		spAb1.specialAbility = 34;
		spAb1.Setup();
		//set up card preview here
		cardPreviewer = instance_create_layer(camera_get_view_x(view_camera[0]),930,"Text",oCardScroller);
		cardPreviewer.previewDeck = global.SavannahsDecks[global.SavannahMatchNum];
		cardPreviewer.Setup();
	break;
	}
}
#endregion

#region Adam's match previews
function Adam()
{
	switch(global.AdamMatchNum)
	{
	case 0:
		//set up our text here
		call = "It's me Adam?";
		response1 = "Yes, you're Adam";
		response2 = "No, you're full of shit!";
		//set up the preview SpAbs here
		spAb2 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,450,"Text",oPreviewSpAb);
		spAb2.specialAbility = 18;
		spAb2.Setup();
		spAb3 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,750,"Text",oPreviewSpAb);
		spAb3.specialAbility = 2;
		spAb3.Setup();
		spAb1 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,150,"Text",oPreviewSpAb);
		spAb1.specialAbility = 34;
		spAb1.Setup();
		//set up card preview here
		cardPreviewer = instance_create_layer(camera_get_view_x(view_camera[0]),930,"Text",oCardScroller);
		cardPreviewer.previewDeck = global.SavannahsDecks[global.SavannahMatchNum];
		cardPreviewer.Setup();
	break;
	}
}
#endregion

function StartMatch()
{
	/*switch(global.ConvoChar)
	{
		case "Titus": global.TitusConvos++; break;
		case "Amanda": global.AmandaConvos++; break;
		case "Marjorie": global.MarjorieConvos++ break;
		case "Jarod": global.JarodConvos++; break;
		case "Dante": global.DanteConvos++; break;
		case "Rebecca": global.RebeccaConvos++; break;
		case "Adam": global.AdamConvos++; break;
		case "Cedric": global.CedricConvos++; break;
		case "Savannah": global.SavannahConvos++; break;
		case "Susan": global.SusanConvos++; break;
		case "Connie": global.ConnieConvos++; break;
		case "Drew": global.DrewConvos++; break;
		case "Lindsay": global.LindsayConvos++; break;
		case "Martha": global.MarthaConvos++; break;
		case "Anu": break;
	}*/
	
	room_goto(rVoid);
}

function ClosePreview()
{
	if(instance_exists(oMatchPreviewer))
	{
		instance_destroy(instance_find(oMatchPreviewer,0).spAb1);
		instance_destroy(instance_find(oMatchPreviewer,0).spAb2);
		instance_destroy(instance_find(oMatchPreviewer,0).spAb3);
		instance_destroy(instance_find(oMatchPreviewer,0));
		cardPreviewer.Close();
	}
}