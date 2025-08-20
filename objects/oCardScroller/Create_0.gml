button_x=0;
scrollAmount=5;
scrollPercent=0;
curX=camera_get_view_x(view_camera[0]);
//bottomBar width(1200) - ((border(40) + padding(5)*2(both sides of the buttons))*2(both sides) + scroll one button(200))
// -6 because our sprite is middle cenetered and 5 pixels wide
scrollDist=1000;

//which deck are we displaying
previewDeck = global.PlayerCards;
//holds the oCardShopPlayerCard objects
cardProfs=undefined;

//display our deck of cards
function Setup()
{
	curX=camera_get_view_x(view_camera[0]);
	show_debug_message(curX);
	show_debug_message("preview deck: "+string(previewDeck));
	show_debug_message("cardprofs: "+string(cardProfs));
	
	for(var i=0;i<array_length(previewDeck);i++)
	{
		cardProfs[i] = instance_create_layer((curX+150+(105*i)),930,"CardShop",oCardShopPreviewCard);
		cardProfs[i].card = previewDeck[i];
		cardProfs[i].deckPos=i;
		cardProfs[i].SetupCard();
	}
	
	show_debug_message("preview deck: "+string(previewDeck));
	show_debug_message("cardprofs: "+string(cardProfs));
}

function Close()
{
	for(var i=0; i<array_length(cardProfs); i++)
	{
		instance_destroy(cardProfs[i]);
	}
	instance_destroy();
}