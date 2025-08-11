if(setup && ((pDiamond&&variable_global_exists("pDiamondCounter"))||(!pDiamond&&variable_global_exists("opDiamondCounter"))))
{
	if(endX==undefined || endY==undefined)
	{
		endX = ((pDiamond) ? global.pDiamondCounter.x : global.opDiamondCounter.x) + (sprite_get_width(sprDiamondCounter)/2);
		endY = ((pDiamond) ? global.pDiamondCounter.y : global.opDiamondCounter.y) + (sprite_get_height(sprDiamondCounter)/2);
		depth = ((pDiamond) ? global.pDiamondCounter.depth : global.opDiamondCounter.depth) - 1;
	}
	
	if(curFrames<=totalFrames)
	{
		x = lerp(startX,endX,curFrames/totalFrames);
		y = lerp(startY,endY,curFrames/totalFrames);
		curFrames++;
	}
	else
	{
		if(pDiamond){global.pDiamonds++;}
		else{instance_find(oMatchManager,0).opDiamonds++;}
		audio_play_sound(sndDiamondCashIn,1,false);
		instance_destroy();
	}
}
