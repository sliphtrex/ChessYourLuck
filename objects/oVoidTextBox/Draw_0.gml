accept_key = mouse_check_button_released(mb_left);

textbox_x = camera_get_view_x(view_camera[0]);
textbox_y = camera_get_view_y(view_camera[0]);

//had to put this here so the text won't be completed on the first frame
#region advancing pages
if(setup && accept_key)
{
	if(draw_char==text_length[page])
	{
		if(text_check[page]==undefined || text_check[page]())
		{
			if(page < page_number-1)
			{page++; draw_char=0;}
			else
			{
				if(option_number==0 || option_pos!=-1)
				{
					//Note: we must invoke both NextMove and optionLinkID[option_pos].
					//This is because the variables hold only the function name and
					//can't be stored as a call to a function. So we must do it here. 
					if(option_number==0)
					{
						if(NextMove!=undefined){NextMove();}
					}
					else{optionLinkID[option_pos]();}
					instance_destroy();
				}
			}
		}
	}
	else{draw_char=text_length[page];}
}
#endregion

#region setup
if(!setup)
{
	setup=true;
	draw_set_font(global.font_main);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	
	for(var p=0;p<page_number; p++)
	{
		text_length[p] = string_length(text[p]);
		
		for(var c=0; c < text_length[p]; c++)
		{
			var char_pos=c+1;
			
			//store individual chars to char[]
			char[c,p] = string_char_at(text[p],char_pos);
			//get our current line width
			var textUpToChar = string_copy(text[p],1,char_pos);
			var curTextW = string_width(textUpToChar) - string_width(char[c,p]);
			//find our last free space
			//NOTE: we break after the " " so we don't start the new line with a " ".
			if(char[c,p]==" "){last_free_space = char_pos+1;}
			
			//if current text width > line width, break the line at the last free space
			if(curTextW - line_break_offset[p] > line_width[p])
			{
				//set our line break position for the given line at our last free space
				line_break_pos[line_break_num[p],p] = last_free_space;
				//increase our total line breaks by 1
				line_break_num[p]++;
				//our offset becomes the pixel length since the last " "
				var textUpToLastSpace = string_copy(text[p],1,last_free_space);
				var lastFreeSpaceString = string_char_at(text[p],last_free_space);
				line_break_offset[p] = string_width(textUpToLastSpace)-string_width(lastFreeSpaceString);
			}
		}
		
		for(var c=0; c < text_length[p]; c++)
		{
			var char_pos=c+1;
			
			var text_x = textbox_x + text_x_offset[p] + border;
			var text_y = textbox_y + text_y_offset[p] + border;
			//get our current line width
			var textUpToChar = string_copy(text[p],1,char_pos);
			var curTextW = string_width(textUpToChar) - string_width(char[c,p]);
			var text_line = 0;
			
			//set y based on line breaks
			for(var lb=0; lb < line_break_num[p]; lb++)
			{
				//when we go past our line break on a given page...
				if(char_pos>=line_break_pos[lb,p])
				{
					//copy whatever's left after the line break
					var str_copy = string_copy(text[p],line_break_pos[lb,p],char_pos-line_break_pos[lb,p]);
					//this becomes our next line's starting width
					curTextW = string_width(str_copy);
					text_line = lb+1;
				}
			}
			
			char_x[c,p] = text_x + curTextW;
			char_y[c,p] = text_y + (text_line*line_spacing);
		}
	}
}
#endregion

#region advancing text
if(curTimer==0)
{
	if(draw_char < text_length[page])
	{
		draw_char += text_speed;
		draw_char = clamp(draw_char,0,text_length[page]);
		
		var curChar = string_char_at(text[page],draw_char);
	
		if(curChar=="."||curChar==","||curChar=="?"||curChar=="!"||curChar=="-")
			{curTimer = pauseTime;}
		else
			{if(!audio_is_playing(sndHumanoidDoot)){audio_play_sound(sndHumanoidDoot,1,false);}}
	}
	else{audio_stop_sound(sndHumanoidDoot);}
}
else
{
	curTimer--;
	audio_stop_sound(sndHumanoidDoot);
}

#endregion

var drawText = string_copy(text[page],1,draw_char);
var textbox_w = string_width_ext(drawText,line_spacing,line_width[page])+border*2;
var textbox_h = string_height_ext(drawText,line_spacing,line_width[page])+border*2;

#region setup options
if(draw_char=text_length[page] && page==page_number-1 && option_number>0)
{
	//clear our chosen option
	option_pos=-1;
	
	var oh=50;//option height = line_spacing+(border*2)
	
	//draw the options
	for(var o=0; o<option_number; o++)
	{
		//width = string_width + borders
		var ow = string_width(option[o])+(border*2);
		//the textbox's position + width - option's width
		var ox = textbox_x+text_x_offset[page]+textbox_w-ow;
		//the textbox's ypos + (option height * option number)
		var oy = textbox_y+text_y_offset[page]+textbox_h+(oh*o);
		//is our mouse hovering over this option
		var opSelected = (mouse_x>=ox && mouse_x<=ox+ow && mouse_y>=oy && mouse_y<= oy+oh);
		
		draw_sprite_stretched(textbox_spr[page],opSelected,ox,oy,ow,oh);
		draw_text(ox+border, oy+border, option[o]);
		
		if(opSelected){option_pos=o;}
	}
}
#endregion

#region drawing to screen
textbox_img += textbox_imgSpd;

draw_sprite_stretched(textbox_spr[page],textbox_img,
	textbox_x+text_x_offset[page],
	textbox_y+text_y_offset[page],
	textbox_w,textbox_h);

draw_text_ext(textbox_x+text_x_offset[page]+border,
	textbox_y+text_y_offset[page]+border,
	drawText, line_spacing,line_width[page]);
	
/*for(var c=0; c < draw_char; c++)
{draw_text(char_x[c,page],char_y[c,page],char[c,page]);}*/
#endregion