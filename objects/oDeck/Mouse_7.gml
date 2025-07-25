if(pDeck&&instance_find(oMatchManager,0).pTurn)
{
	instance_find(oField,0).UnselectTiles();
	if(curCard<52 && cardsDrawn<cardsPerTurn[instance_find(oMatchManager,0).Turn])
	{
		CreateCard(global.PlayerCards[deckOrder[curCard]]);
		curCard++;
		cardsDrawn++;
	}
	else
	{
		TurnOver();
	}
}