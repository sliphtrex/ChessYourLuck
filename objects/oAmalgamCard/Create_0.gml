event_inherited();
amalgam=true;

pip = [pips];

function Setup()
{
	pips=clubs+hearts+spades+diamonds;

	for(var i=0; i<pips; i++)
	{
		if(i<clubs){pip[i]="c";}
		else if(i<clubs+hearts){pip[i]="h";}
		else if(i<clubs+hearts+spades){pip[i]="s";}
		else if(i<clubs+hearts+spades+diamonds){pip[i]="d";}
	}

	if(pips<=10){sprite_index=sprBlankCard;}
	else if(pips==11){sprite_index=sprBlankJack;}
	else if(pips==12){sprite_index=sprBlankQueen;}
	else if(pips==13){sprite_index=sprBlankKing;}
	else if(pips==14){sprite_index=sprBlankAce;}
	
	AddCardToHand();
}