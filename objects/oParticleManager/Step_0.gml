if(pDiamondPips>0)
{
	if(curPDFrames==0)
	{
		var pip = instance_create_layer(px,py,"UILayer",oDiamondPipParticle);
		pip.Setup(true);
		switch(curPDpip)
		{
			case 2: audio_play_sound(sndDP2,1,false); break;
			case 3: audio_play_sound(sndDP3,1,false); break;
			case 4: audio_play_sound(sndDP4,1,false); break;
			default: audio_play_sound(sndDP5,1,false); break;
		}
		curPDpip++;
		
		curPDFrames=diamondOffset;
		pDiamondPips--;
	}
	curPDFrames--;
	if(pDiamondPips==0){curPDpip=0;}
}

if(opDiamondPips>0)
{
	if(curOPDFrames==0)
	{
		var pip = instance_create_layer(opx,opy,"UILayer",oDiamondPipParticle);
		pip.Setup(false);
		switch(curOPDpip)
		{
			case 2: audio_play_sound(sndDP2,1,false); break;
			case 3: audio_play_sound(sndDP3,1,false); break;
			case 4: audio_play_sound(sndDP4,1,false); break;
			default: audio_play_sound(sndDP5,1,false); break;
		}
		curOPDpip++;
		curOPDFrames=diamondOffset;
		opDiamondPips--;
	}
	curOPDFrames--;
	if(opDiamondPips==0){curOPDpip=0;}
}

if(pSpadePips>0)
{
	if(curPSFrames==0)
	{
		var pip = instance_create_layer(px,py,"UILayer",oSpadePipParticle);
		pip.Setup(true, curPSpip);
		show_debug_message("curPSpip = "+string(curPSpip));
		switch(curPSpip)
		{
			case 2: audio_play_sound(sndSP2,1,false); break;
			case 3: audio_play_sound(sndSP3,1,false); break;
			case 4: audio_play_sound(sndSP4,1,false); break;
			default: audio_play_sound(sndSP5,1,false); break;
		}
		curPSpip++;
		curPSFrames=spadeOffset;
		pSpadePips--;
	}
	curPSFrames--;
	if(pSpadePips==0){curPSpip=0;}
}

if(opSpadePips>0)
{
	if(curOPDFrames==0)
	{
		var pip = instance_create_layer(opx,opy,"UILayer",oSpadePipParticle);
		pip.Setup(false, curOPSpip);
		switch(curOPSpip)
		{
			case 2: audio_play_sound(sndSP2,1,false); break;
			case 3: audio_play_sound(sndSP3,1,false); break;
			case 4: audio_play_sound(sndSP4,1,false); break;
			default: audio_play_sound(sndSP5,1,false); break;
		}
		curOPSpip++;
		curOPDFrames=spadeOffset;
		opSpadePips--;
	}
	curOPSFrames--;
	if(opSpadePips==0){curOPSpip=0;}
}