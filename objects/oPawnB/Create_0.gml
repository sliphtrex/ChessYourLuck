event_inherited();

graduated = false;
selected=false;

icons = undefined;

function CreateIcons()
{
	selected = true;
	icons[0] = instance_create_layer(x-70,y,"UILayer",oGradIcon);
	icons[0].myPiece = id;
	icons[0].myRank = 0;
	icons[0].Setup();
	icons[1] = instance_create_layer(x+70,y,"UILayer",oGradIcon);
	icons[1].myPiece = id;
	icons[1].myRank = 1;
	icons[1].Setup();
	icons[2] = instance_create_layer(x-70,y+70,"UILayer",oGradIcon);
	icons[2].myPiece = id;
	icons[2].myRank = 2;
	icons[2].Setup();
	icons[3] = instance_create_layer(x,y+70,"UILayer",oGradIcon);
	icons[3].myPiece = id;
	icons[3].myRank = 3;
	icons[3].Setup();
	icons[4] = instance_create_layer(x+70,y+70,"UILayer",oGradIcon);
	icons[4].myPiece = id;
	icons[4].myRank = 4;
	icons[4].Setup();
}

function DestroyIcons()
{
	selected = false;
	if(icons!=undefined)
	{
		for(var i=0;i<array_length(icons);i++)
		{
			instance_destroy(icons[i]);
		}
		icons=undefined;
	}
}