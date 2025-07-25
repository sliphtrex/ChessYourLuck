if(flipCard)
{	
	if(saved || deleting)
	{
		curSetupFrame++;
		if(midturn)
		{
			if(curSetupFrame<setupFrames)
			{
				draw_sprite_ext(sprite_index,0,x,y,
					lerp(0,1,curSetupFrame/setupFrames),1,0,c_white,1);
			}
			else
			{
				midturn=false;
				curSetupFrame = 0;
				flipCard=false;
				setupFinished=true;
				if(deleting){deleting = false;}
			}
		}
		else
		{
			if(curSetupFrame<setupFrames)
			{
				draw_sprite_ext(sprite_index,0,x,y,
					lerp(1,0,curSetupFrame/setupFrames),1,0,c_white,1);
			}
			else
			{
				sprite_index = (moveOut || deleting)? sprLargeBlueCardBack : sprSaveFile; midturn=true; curSetupFrame=0;
			}
		}
	}
	else
	{
		curSetupFrame = 0;
		flipCard=false;
		setupFinished=true;
	}
}
else
{
	draw_sprite(sprite_index,0,x,y);
	
	if(setupFinished && saved && !moveOut)
	{
		var _buffer = buffer_load("CYL"+string(myFile)+".sav");
		var _string = buffer_read(_buffer,buffer_string);
		buffer_delete(_buffer);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_top);
		var _loadData = json_parse(_string);
		draw_set_color(c_black);
		draw_text(x,y-75,"Day:\n"+string(_loadData[SDDayNumber]+1));
		draw_set_color(c_green);
		draw_text(x,y+150,_loadData[SDSaveDate]);
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		draw_sprite_ext(sprDaypartIcon,_loadData[SDDayPart],
			x-(sprite_get_width(sprDaypartIcon)*2),
			y,4,4,0,c_white,1);
	}
}