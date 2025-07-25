if(instance_find(oShopGenerator,0).heldCard!=undefined)
{
	var tempCard=instance_find(oShopGenerator,0).heldCard.card;
	
	//set the held card to this card
	instance_find(oShopGenerator,0).heldCard.card=card;
	instance_find(oShopGenerator,0).heldCard.Setup();
	
	//set this card to reflect the held card
	card = tempCard;
	//update our player deck to reflect what's shown
	global.PlayerCards[deckPos] = card;
	//reset our card sprite
	SetupCard();
	
	instance_find(oShopGenerator,0).heldCard=undefined;
}