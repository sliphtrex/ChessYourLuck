button_y=0;
scrollAmount=5;
scrollPercent=0;
scrollDist=700;

//holds the oCardShopUnlockedSpecials objects
SpecialProfs[0]=undefined;

//display our deck of cards on create
for(var i=0;i<36;i++)
{
	SpecialProfs[i] = instance_create_layer(1400,(150+(150*i)),"CardShop",oCardShopPlayerSpAb);
	SpecialProfs[i].spAb = i;
	SpecialProfs[i].shop = true;
	SpecialProfs[i].SetupSpAb();
}

function Close()
{
	for(var i=0; i<array_length(SpecialProfs); i++)
	{
		instance_destroy(SpecialProfs[i]);
	}
	instance_destroy();
}