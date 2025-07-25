spAb1 = undefined;
spAb2 = undefined;
spAb3 = undefined;

specialCard1=undefined;
specialCard2=undefined;
specialCard3=undefined;

border=45;
call = "";
response1="";
response2="";

switch(global.ConvoChar)
{
	case "Savannah":
		Savannah();
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
		//set up our text here
		call = "So, what's the deal with you? You wanna play a game?";
		response1 = "Yeah, let's go";
		response2 = "Nah, not just yet";
		//set up the preview SpAbs here
		spAb2 = instance_create_layer(1450,450,"CardShop",oPreviewSpAb);
		spAb2.specialAbility = 18;
		spAb2.Setup();
		spAb3 = instance_create_layer(1450,750,"CardShop",oPreviewSpAb);
		spAb3.specialAbility = 2;
		spAb3.Setup();
		spAb1 = instance_create_layer(1450,150,"CardShop",oPreviewSpAb);
		spAb1.specialAbility = 34;
		spAb1.Setup();
	break;
	}
}
#endregion

function StartMatch()
{
	room_goto(rVoid);
}

function ClosePreview()
{
	instance_destroy(instance_find(oMatchPreviewer,0).spAb1);
	instance_destroy(instance_find(oMatchPreviewer,0).spAb2);
	instance_destroy(instance_find(oMatchPreviewer,0).spAb3);
	instance_destroy(instance_find(oMatchPreviewer,0));
	
	//this nested switch resets the values changed in scrCharacterText
	switch(global.ConvoChar)
	{
	case "Savannah":
		switch(global.SavannahMatchNum)
		{
			case 0: global.SavannahConvos-=2; break;
		}
	break;
	}
}