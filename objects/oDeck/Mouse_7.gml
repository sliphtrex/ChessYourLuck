if(pDeck&&instance_find(oMatchManager,0).pTurn)
{
	instance_find(oField,0).UnselectTiles();
	if(curCard<52 && cardsDrawn<cardsPerTurn[instance_find(oMatchManager,0).Turn])
	{
		CreateCard(global.PlayerCards[deckOrder[curCard]]);
		audio_play_sound(sndDrawCard,1,false);
		curCard++;
		cardsDrawn++;
	}
	else
	{
		TurnOver();
	}
}