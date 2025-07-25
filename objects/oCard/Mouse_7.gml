if(!discarded && pCard && instance_find(oMatchManager,0).pTurn)
{
	//if it's a different card, we're combining
	if(global.pHand.c1!=undefined&&global.pHand.c1!=id)
	{
		global.pHand.c2 = id;
		global.pHand.CombineCards();
		instance_find(oField,0).UnselectTiles();
	}
	//if it's the same card we're unselecting it
	else if(global.pHand.c1==id)
	{
		if(selected)
		{
			selected=false;
			global.pHand.cardSelected=undefined;
			instance_find(oField,0).UnselectTiles();
		}
		else
		{
			selected=true;
			global.pHand.cardSelected=id;
			instance_find(oField,0).CardSelected();
		}
	}
}