card = -1;
deckPos=-1;

start_x = x;
curX=camera_get_view_x(view_camera[0]);
hidden=false;

maskSurface=undefined;

function SetupCard()
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
		default: instance_destroy(); break;
	}
}