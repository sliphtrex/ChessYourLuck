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
		response1 = "Yeah, let's go";
		response2 = "Nah, not just yet";
		//set up the preview SpAbs here
		spAb2 = instance_create_layer(camera_get_view_x(view_camera[0])+room_width-150,450,"CardShop",oPreviewSpAb);
		spAb2.specialAbility = 18;
		spAb2.Setup();
		spAb3 = instance_create_layer(camera_get_view_x(view_camera[0])+room_width-150,750,"CardShop",oPreviewSpAb);
		spAb3.specialAbility = 2;
		spAb3.Setup();
		spAb1 = instance_create_layer(camera_get_view_x(view_camera[0])+room_width-150,150,"CardShop",oPreviewSpAb);
		spAb1.specialAbility = 34;
		spAb1.Setup();
		//set up card preview here
		cardPreviewer = instance_create_layer(camera_get_view_x(view_camera[0]),room_height-150,"CardShop",oCardScroller);
		cardPreviewer.previewDeck = global.SavannahsDecks[global.SavannahMatchNum];
		cardPreviewer.Setup();
	break;
	case 1:
		//set up our text here
		call = "Sorry, I gotta chill. We playing or what?";
		response1 = "Yeah, let's go";
		response2 = "Nah, not just yet";
		//set up the preview SpAbs here
		spAb2 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,450,"CardShop",oPreviewSpAb);
		spAb2.specialAbility = 18;
		spAb2.Setup();
		spAb3 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,750,"CardShop",oPreviewSpAb);
		spAb3.specialAbility = 2;
		spAb3.Setup();
		spAb1 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,150,"CardShop",oPreviewSpAb);
		spAb1.specialAbility = 34;
		spAb1.Setup();
		//set up card preview here
		cardPreviewer = instance_create_layer(camera_get_view_x(view_camera[0]),930,"CardShop",oCardScroller);
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
		spAb2 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,450,"CardShop",oPreviewSpAb);
		spAb2.specialAbility = 18;
		spAb2.Setup();
		spAb3 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,750,"CardShop",oPreviewSpAb);
		spAb3.specialAbility = 2;
		spAb3.Setup();
		spAb1 = instance_create_layer(camera_get_view_x(view_camera[0])+1770,150,"CardShop",oPreviewSpAb);
		spAb1.specialAbility = 34;
		spAb1.Setup();
		//set up card preview here
		cardPreviewer = instance_create_layer(camera_get_view_x(view_camera[0]),930,"CardShop",oCardScroller);
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