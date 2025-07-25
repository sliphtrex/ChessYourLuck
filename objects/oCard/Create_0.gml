//what card are we
card=-1;

clubs=0;
hearts=0;
spades=0;
diamonds=0;

pips = 0;

amalgam = false;
suit=-1;
pCard=false;
selected=false;
discarded = false;
prevDiscarded=false;

function AddCardToHand()
{
	if(pCard){global.pHand.AddToHand(id);}
	else{global.opHand.AddToHand(id);}
}