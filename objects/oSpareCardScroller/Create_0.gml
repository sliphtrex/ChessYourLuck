button_y=0;
scrollAmount=5;
scrollPercent=0;
scrollDist=700;

//holds the oSpareCard objects
spareCards[0]=undefined;

//display our deck of cards on create
for(var i=0;i<array_length(global.PlayerSpareCards);i++)
{
	spareCards[i] = instance_create_layer(1400,(170+(150*i)),"CardShop",oSpareCard);
	spareCards[i].card = global.PlayerSpareCards[i];
	spareCards[i].Setup();
}

function Close()
{
	for(var i=0; i<array_length(spareCards); i++)
	{
		instance_destroy(spareCards[i]);
	}
	instance_destroy();
}