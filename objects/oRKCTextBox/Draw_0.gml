accept_key = mouse_check_button_released(mb_left);

textbox_x = camera_get_view_x(view_camera[0]);
textbox_y = camera_get_view_y(view_camera[0])+600;

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
				show_debug_message(option_number);
				if(option_number==0 || option_pos!=-1)
				{
					//Note: we must invoke both NextMove and optionLinkID[option_pos].
					//This is because the variables hold only the function name and
					//can't be stored as a call to a function. So we must do it here.
					if(option_number==0){if(NextMove!=undefined){NextMove();}}
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
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	for(var p=0; p<page_number;p++)
	{
		text_length[p] = string_length(text[p]);
	}
}
#endregion

#region advancing text
if(draw_char < text_length[page])
{
	draw_char+=text_speed;
	draw_char = clamp(draw_char,0,text_length[page]);
}
#endregion

#region setup options
if(draw_char==text_length[page] && page == page_number-1 && option_number>0)
{
	//clear our current option
	option_pos=-1;
	
	var oh = 140;//option height = line_spacing+(border*2) + 5(gap between options)
	
	//draw the options
	for(var o=0;o<option_number;o++)
	{
		//width = string_width + borders
		var ow = string_width(option[o]) + (border*2);
		//the textbox's pos + width - the option's width
		var ox = textbox_x + textbox_width[page] - ow;
		//the textbox's y pos - (option height * option number)
		var oy = textbox_y-oh-(oh*o);
		//is our mouse hovering over the option
		var opSelected = (mouse_x>=ox&&mouse_x<=ox+ow&&mouse_y>=oy&&mouse_y<=oy+oh);
		
		draw_sprite_stretched(textbox_spr[page],opSelected,ox,oy,ow,oh);
		draw_text(ox+border,oy+border,option[o]);
		
		if(opSelected){option_pos=o;}
	}
}
#endregion

#region drawing to screen
if(textbox_speaker_sprite[page]!=undefined)
{
	sprite_index = textbox_speaker_sprite[page];
	if(draw_char==text_length[page]){image_index=0;}
	draw_sprite(sprite_index,image_index,textbox_x,textbox_y);
}

textbox_img += textbox_imgSpd;

if(textbox_speaker_name[page]!=undefined)
{
	//135 = line_spacing+(border*2)
	draw_sprite_stretched(textbox_spr[page],textbox_img,textbox_x,textbox_y-135,
		string_width(textbox_speaker_name[page])+(border*2),135);
	draw_text(textbox_x+border,textbox_y-border-line_spacing,textbox_speaker_name[page]);
}

draw_sprite_stretched(textbox_spr[page],textbox_img,textbox_x,textbox_y,textbox_width[page],textbox_height);

var drawText = string_copy(text[page],0,draw_char);
draw_text_ext(textbox_x+border,textbox_y+border,drawText,line_spacing,line_width[page]);

#endregion