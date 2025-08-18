if((pTurn && instance_find(oMatchManager,0).pTurn && global.pDeck.firstDraw==false)
||(!pTurn&&!instance_find(oMatchManager,0).pTurn && global.opDeck.firstDraw==false))
{image_index=0;}else{image_index=1;}