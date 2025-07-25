if(!pCard && discarded && !prevDiscarded)
{
	if(suit==0){pips = clubs;}
	else if(suit==1){pips = hearts;}
	else if(suit==2){pips = spades;}
	else if(suit==3){pips = diamonds;}

	if(suit==0)
	{
		switch(pips)
		{
		case 2: sprite_index=spr_2oC; break;
		case 3: sprite_index=spr_3oC; break;
		case 4: sprite_index=spr_4oC; break;
		case 5: sprite_index=spr_5oC; break;
		case 6: sprite_index=spr_6oC; break;
		case 7: sprite_index=spr_7oC; break;
		case 8: sprite_index=spr_8oC; break;
		case 9: sprite_index=spr_9oC; break;
		case 10: sprite_index=spr_10oC; break;
		case 11: sprite_index=spr_JoC; break;
		case 12: sprite_index=spr_QoC; break;
		case 13: sprite_index=spr_KoC; break;
		case 14: sprite_index=spr_AoC; break;
		}
	}
	else if(suit==1)
	{
		switch(pips)
		{
		case 2: sprite_index=spr_2oH; break;
		case 3: sprite_index=spr_3oH; break;
		case 4: sprite_index=spr_4oH; break;
		case 5: sprite_index=spr_5oH; break;
		case 6: sprite_index=spr_6oH; break;
		case 7: sprite_index=spr_7oH; break;
		case 8: sprite_index=spr_8oH; break;
		case 9: sprite_index=spr_9oH; break;
		case 10: sprite_index=spr_10oH; break;
		case 11: sprite_index=spr_JoH; break;
		case 12: sprite_index=spr_QoH; break;
		case 13: sprite_index=spr_KoH; break;
		case 14: sprite_index=spr_AoH; break;
		}
	}
	else if(suit==2)
	{
		switch(pips)
		{
		case 2: sprite_index=spr_2oS; break;
		case 3: sprite_index=spr_3oS; break;
		case 4: sprite_index=spr_4oS; break;
		case 5: sprite_index=spr_5oS; break;
		case 6: sprite_index=spr_6oS; break;
		case 7: sprite_index=spr_7oS; break;
		case 8: sprite_index=spr_8oS; break;
		case 9: sprite_index=spr_9oS; break;
		case 10: sprite_index=spr_10oS; break;
		case 11: sprite_index=spr_JoS; break;
		case 12: sprite_index=spr_QoS; break;
		case 13: sprite_index=spr_KoS; break;
		case 14: sprite_index=spr_AoS; break;
		}
	}
	else if(suit==3)
	{
		switch(pips)
		{
		case 2: sprite_index=spr_2oD; break;
		case 3: sprite_index=spr_3oD; break;
		case 4: sprite_index=spr_4oD; break;
		case 5: sprite_index=spr_5oD; break;
		case 6: sprite_index=spr_6oD; break;
		case 7: sprite_index=spr_7oD; break;
		case 8: sprite_index=spr_8oD; break;
		case 9: sprite_index=spr_9oD; break;
		case 10: sprite_index=spr_10oD; break;
		case 11: sprite_index=spr_JoD; break;
		case 12: sprite_index=spr_QoD; break;
		case 13: sprite_index=spr_KoD; break;
		case 14: sprite_index=spr_AoD; break;
		}
	}
	
	prevDiscarded=true;
}

draw_self();
if(!discarded && selected){draw_sprite(sprCardHighlight,0,x,y);}
else if(discarded && selected){selected = false;}