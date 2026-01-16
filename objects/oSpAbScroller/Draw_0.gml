#region Drawing the scrollbar and arrows

//draws the arrows as either black or yellow depending on whether the mouse is hovering over
draw_sprite_ext(sprCardShopLeftArrow,
	(mouse_x>room_width-220 && mouse_x<room_width-180
	&& mouse_y>45 && mouse_y<85),
	room_width-200,65,1,1,-90,c_white,1);
draw_sprite_ext(sprCardShopLeftArrow,
	(mouse_x>room_width-220 && mouse_x<room_width-180
	&& mouse_y>room_height-85 && mouse_y<room_height-45),
	room_width-200,room_height-65,1,1,90,c_white,1);

if(mouse_check_button(mb_left))
{
	if(mouse_x>room_width-220 && mouse_x<room_width-180
	&& mouse_y>room_height-85 && mouse_y<room_height-45)
	{button_y+=scrollAmount;}
	else if(mouse_x>room_width-220 && mouse_x<room_width-180
	&& mouse_y>45 && mouse_y<85)
	{button_y-=scrollAmount;}
}

button_y = clamp(button_y,0,scrollDist);

scrollPercent = button_y/scrollDist;

draw_sprite(sprScrollLine,0,room_width-20,100+button_y);

#endregion