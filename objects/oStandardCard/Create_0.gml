event_inherited();

function Setup()
{
	if(card<52) //standard playing cards
	{
		//0=Clubs,1=Hearts,2=Spades,3=Diamonds
		suit = floor(card/13);
	
		//set cards starting suit values;
		//attack(clubs) and health(hearts) must be at least 1 for chess pieces
	
		//clubs
		if(suit==0)
		{
			switch(card%13)
			{
				case 0: pips = 14; clubs = pips; break;
			
				case 1: case 2: case 3: case 4: case 5: case 6:
				case 7: case 8: case 9: case 10: case 11: case 12:

					pips = (card%13)+1 ; clubs = pips; break;
			}
			hearts = 1;
		}
		//hearts
		else if(suit==1)
		{
			switch(card%13)
			{
				case 0: pips = 14; hearts = pips; break;
			
				case 1: case 2: case 3: case 4: case 5: case 6:
				case 7: case 8: case 9: case 10: case 11: case 12:
			
					pips = (card%13)+1; hearts = pips; break;
			}
			clubs = 1;
		}
		//spades
		else if(suit==2)
		{
			switch(card%13)
			{
				case 0: pips = 14; spades = pips; break;
			
				case 1: case 2: case 3: case 4: case 5: case 6:
				case 7: case 8: case 9: case 10: case 11: case 12:
			
					pips = (card%13)+1; spades = pips; break;
			}
			clubs = 1;
			hearts = 1;
		}
		//diamonds
		else if(suit==3)
		{
			switch(card%13)
			{
				case 0: pips = 14; diamonds = pips; break;
			
				case 1: case 2: case 3: case 4: case 5: case 6:
				case 7: case 8: case 9: case 10: case 11: case 12:
			
					pips = (card%13)+1; diamonds = pips; break;
			}
			clubs = 1;
			hearts = 1;
		}
	}
	else //special cards
	{
		switch(card)
		{
		case 52: //1oS
			pips=1;
			clubs=1;
			hearts=1;
			spades=1;
		break;
		case 53: //1oD
			pips=1;
			clubs=1;
			hearts=1;
			diamonds=1;
		break;
		case 54: //13oS
			var luck = irandom_range(0,12);
			pips = (luck==0) ? 12 : 1;
			clubs= (luck==1) ? 10 : 1;
			hearts=(luck==2) ? 10 : 1;
			spades=13;
		break;
		case 55: //13oD
			pips=1;
			clubs=1;
			hearts=1;
			diamonds=13;
		break;
		case 56: //15oS
			pips=1;
			clubs=1;
			hearts=1;
			spades=15;
		break;
		case 57: //15oD
			pips=1;
			clubs=1;
			hearts=1;
			diamonds=15;
		break;
		}
	}
	
	//set the sprite
	if(pCard)
	{
		switch(card)
		{
			case 0: sprite_index=spr_AoC; break;
			case 1: sprite_index=spr_2oC; break;
			case 2: sprite_index=spr_3oC; break;
			case 3: sprite_index=spr_4oC; break;
			case 4: sprite_index=spr_5oC; break;
			case 5: sprite_index=spr_6oC; break;
			case 6: sprite_index=spr_7oC; break;
			case 7: sprite_index=spr_8oC; break;
			case 8: sprite_index=spr_9oC; break;
			case 9: sprite_index=spr_10oC; break;
			case 10: sprite_index=spr_JoC; break;
			case 11: sprite_index=spr_QoC; break;
			case 12: sprite_index=spr_KoC; break;
			case 13: sprite_index=spr_AoH; break;
			case 14: sprite_index=spr_2oH; break;
			case 15: sprite_index=spr_3oH; break;
			case 16: sprite_index=spr_4oH; break;
			case 17: sprite_index=spr_5oH; break;
			case 18: sprite_index=spr_6oH; break;
			case 19: sprite_index=spr_7oH; break;
			case 20: sprite_index=spr_8oH; break;
			case 21: sprite_index=spr_9oH; break;
			case 22: sprite_index=spr_10oH; break;
			case 23: sprite_index=spr_JoH; break;
			case 24: sprite_index=spr_QoH; break;
			case 25: sprite_index=spr_KoH; break;
			case 26: sprite_index=spr_AoS; break;
			case 27: sprite_index=spr_2oS; break;
			case 28: sprite_index=spr_3oS; break;
			case 29: sprite_index=spr_4oS; break;
			case 30: sprite_index=spr_5oS; break;
			case 31: sprite_index=spr_6oS; break;
			case 32: sprite_index=spr_7oS; break;
			case 33: sprite_index=spr_8oS; break;
			case 34: sprite_index=spr_9oS; break;
			case 35: sprite_index=spr_10oS; break;
			case 36: sprite_index=spr_JoS; break;
			case 37: sprite_index=spr_QoS; break;
			case 38: sprite_index=spr_KoS; break;
			case 39: sprite_index=spr_AoD; break;
			case 40: sprite_index=spr_2oD; break;
			case 41: sprite_index=spr_3oD; break;
			case 42: sprite_index=spr_4oD; break;
			case 43: sprite_index=spr_5oD; break;
			case 44: sprite_index=spr_6oD; break;
			case 45: sprite_index=spr_7oD; break;
			case 46: sprite_index=spr_8oD; break;
			case 47: sprite_index=spr_9oD; break;
			case 48: sprite_index=spr_10oD; break;
			case 49: sprite_index=spr_JoD; break;
			case 50: sprite_index=spr_QoD; break;
			case 51: sprite_index=spr_KoD; break;
			case 52: sprite_index=spr_1oS; break;
			case 53: sprite_index=spr_1oD; break;
			case 54: sprite_index=spr_13oS; break;
			case 55: sprite_index=spr_13oD; break;
			case 56: sprite_index=spr_15oS; break;
			case 57: sprite_index=spr_15oD; break;
			default:
				instance_destroy();
			break;
		}
	}
	else{sprite_index = sprRedCardBack;}
	
	AddCardToHand();
}