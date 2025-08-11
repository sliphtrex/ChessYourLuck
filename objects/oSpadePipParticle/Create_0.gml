curFrames=0;
totalFrames=room_speed;
startX = x;
startY = y;
endX = undefined;
endY = undefined;

pSpade = true;
//what number spade particle is this
num = 5;
setup=false;

function Setup(ps=true,_num=5)
{
	pSpade=ps;
	num = _num;
	setup=true;
	sprite_index = (ps) ? sprPlayerSpadeParticle : sprOpSpadeParticle;
	
	if((ps&&variable_global_exists("pSpade"))||(!ps&&variable_global_exists("opSpade")))
	{
		endX = ((ps) ? global.pSpade.x : global.opSpade.x);
		endY = ((ps) ? global.pSpade.y : global.opSpade.y);
		depth = ((ps) ? global.pSpade.depth : global.opSpade.depth) - 1;
	}
}