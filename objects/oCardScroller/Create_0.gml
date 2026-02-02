//This object displays a deck of cards; either the players or an opponents.

button_x=0;
scrollAmount=5;
scrollPercent=0;
curX=camera_get_view_x(view_camera[0]);
scrollDist=room_width-600;

//which deck are we displaying
previewDeck = global.PlayerCards;
//holds the oCardShopPlayerCard objects
cardProfs=undefined;
editable=false;

//display our deck of cards
function Setup(_editable=false)
{
	editable = _editable;
	curX=camera_get_view_x(view_camera[0]);
	show_debug_message("("+string(curX)+","+string(curX+room_width)+")");
	
	for(var i=0;i<array_length(previewDeck);i++)
	{
		cardProfs[i] = instance_create_layer((curX+150+(105*i)),room_height-150,
			(editable) ? "CardShop" : "Text",
			(editable) ? oCSPreviewCard : oMatchPreviewCard);
		cardProfs[i].card = previewDeck[i];
		cardProfs[i].deckPos=i;
		cardProfs[i].SetupCard(editable);
	}
}

function Close()
{
	for(var i=0; i<array_length(cardProfs); i++)
	{
		instance_destroy(cardProfs[i]);
	}
	instance_destroy();
}