#region Drawing the scrollbar and arrows
curX=camera_get_view_x(view_camera[0]);

//draws the arrows as either black or yellow depending on whether the mouse is hovering over
draw_sprite(sprCardShopLeftArrow,
	(mouse_x>curX+45 && mouse_x<curX+85
	&& mouse_y>room_height-170 && mouse_y<room_height-130),
	curX+65,room_height-150);
draw_sprite_ext(sprCardShopLeftArrow,
	(mouse_x>curX+room_width-485 && mouse_x<curX+room_width-445
	&& mouse_y>room_height-170 && mouse_y<room_height-130),
	curX+room_width-465,room_height-150, -1,1,0,c_white,1);

if(mouse_check_button(mb_left))
{
	if(mouse_x>curX+room_width-485 && mouse_x<curX+room_width-445
	&& mouse_y>room_height-170 && mouse_y<room_height-130)
	{button_x+=scrollAmount;}
	else if(mouse_x>curX+45 && mouse_x<curX+85
	&& mouse_y>room_height-170 && mouse_y<room_height-130)
	{button_x-=scrollAmount;}
}

button_x = clamp(button_x,0,scrollDist);

scrollPercent = button_x/scrollDist;

draw_sprite(sprScrollLine,0,curX+100+button_x,(editable) ? (room_height-280):(room_height-310));

#endregion

#region Show Card Counts

//card counter 45-32
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);

draw_text(curX+sprite_get_width(sprBackButton)+25+string_width("000/00"),
	room_height-300,
	string(array_length(previewDeck))+"/20");

draw_set_halign(fa_left);
draw_set_valign(fa_top);

#endregion
