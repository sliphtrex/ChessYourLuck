button_x=0;
scrollAmount=5;
scrollPercent=0;
//bottomBar width(1200) - ((border(40) + padding(5)*2(both sides of the buttons))*2(both sides) + scroll one button(200))
// -6 because our sprite is middle cenetered and 5 pixels wide
scrollDist=1000;

//holds the oCardShopPlayerCard objects
cardProfs[0]=undefined;

//display our deck of cards on create
for(var i=0;i<52;i++)
{
	cardProfs[i] = instance_create_layer((150+(105*i)),750,"CardShop",oCardShopPlayerCard);
	cardProfs[i].card = global.PlayerCards[i];
	cardProfs[i].deckPos=i;
	cardProfs[i].SetupCard();
}

function Close()
{
	for(var i=0; i<array_length(cardProfs); i++)
	{
		instance_destroy(cardProfs[i]);
	}
	instance_destroy();
}