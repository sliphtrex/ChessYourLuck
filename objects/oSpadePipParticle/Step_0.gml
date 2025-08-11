if(setup && ((pSpade&&variable_global_exists("pSpade"))||(!pSpade&&variable_global_exists("opSpade"))))
{
	if(endX==undefined || endY==undefined)
	{
		endX = ((pSpade) ? global.pSpade.x : global.opSpade.x) + (sprite_get_width(sprDiamondCounter)/2);
		endY = ((pSpade) ? global.pSpade.y : global.opSpade.y) + (sprite_get_height(sprDiamondCounter)/2);
		depth = ((pSpade) ? global.pSpade.depth : global.opSpade.depth) - 1;
	}
	
	if(curFrames<=totalFrames)
	{
		x = lerp(startX,endX,curFrames/totalFrames);
		y = lerp(startY,endY,curFrames/totalFrames);
		curFrames++;
	}
	else
	{
		if(pSpade){global.pSpade.spadePips++;}
		else{global.opSpade.spadePips++;}
		switch(num)
		{
			case 1: audio_play_sound(sndSPCashIn1,1,false); break;
			case 2: audio_play_sound(sndSPCashIn2,1,false); break;
			case 3: audio_play_sound(sndSPCashIn3,1,false); break;
			case 4: audio_play_sound(sndSPCashIn4,1,false); break;
			default: audio_play_sound(sndSPCashIn5,1,false); break;
		}
		instance_destroy();
	}
}
