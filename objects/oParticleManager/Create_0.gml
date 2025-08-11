pDiamondPips=0;
opDiamondPips=0;

//what sound to play
curPDpip=1;
curOPDpip=1;

pSpadePips=0;
opSpadePips=0;

curPSpip=1;
curOPSpip=1;

px=undefined; py=undefined;
opx=undefined; opy=undefined;

//the frame delay between creating new particles
diamondOffset=3;
curPDFrames=diamondOffset; curOPDFrames = diamondOffset;

//the frame delay between creating new particles
spadeOffset=6;
curPSFrames=spadeOffset; curOPSFrames = spadeOffset;

function DiamondParticles(num,sx,sy,pd=true)
{
	if(pd){pDiamondPips=num-1; px = sx; py = sy;}
	else{opDiamondPips=num-1; opx = sx; opy = sy;}
	
	var pip = instance_create_layer(sx,sy,"UILayer",oDiamondPipParticle);
	pip.Setup(pd);
	audio_play_sound(sndDP1,1,false);
	if(pd){curPDpip++;}
	else{curOPDpip++;}
}

function SpadeParticles(num,sx,sy,ps=true)
{
	if(ps){pSpadePips=num-1; px = sx; py = sy;}
	else{opSpadePips=num-1; opx = sx; opy = sy;}
	
	var pip = instance_create_layer(sx,sy,"UILayer",oSpadePipParticle);
	pip.Setup(ps);
	audio_play_sound(sndSP1,1,false);
	if(ps){curPSpip++;}
	else{curOPSpip++;}
}