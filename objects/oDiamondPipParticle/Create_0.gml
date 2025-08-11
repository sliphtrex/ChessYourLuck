curFrames=0;
totalFrames=room_speed;
startX = x;
startY = y;
endX = undefined;
endY = undefined;

pDiamond = true;
setup=false;

function Setup(pd=true)
{
	pDiamond=pd;
	setup=true;
	
	if((pd&&variable_global_exists("pDiamondCounter"))||(!pd&&variable_global_exists("opDiamondCounter")))
	{
		endX = ((pd) ? global.pDiamondCounter.x : global.opDiamondCounter.x) + (sprite_get_width(sprDiamondCounter)/2);
		endY = ((pd) ? global.pDiamondCounter.y : global.opDiamondCounter.y) + (sprite_get_height(sprDiamondCounter)/2);
		depth = ((pd) ? global.pDiamondCounter.depth : global.opDiamondCounter.depth) - 1;
	}
}