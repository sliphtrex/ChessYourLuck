#region Drawing the scrollbar and arrows

//draws the arrows as either black or yellow depending on whether the mouse is hovering over
draw_sprite_ext(sprCardShopLeftArrow,
	(mouse_x>1380 && mouse_x<1420 && mouse_y>45 && mouse_y<85),
	1400,65,1,1,-90,c_white,1);
draw_sprite_ext(sprCardShopLeftArrow,
	(mouse_x>1380 && mouse_x<1420 && mouse_y>815 && mouse_y<855),
	1400,835,1,1,90,c_white,1);

if(mouse_check_button(mb_left))
{
	if(mouse_x>1380 && mouse_x<1420 && mouse_y>815 && mouse_y<855)
	{button_y+=scrollAmount;}
	else if(mouse_x>1380 && mouse_x<1420 && mouse_y>45 && mouse_y<85)
	{button_y-=scrollAmount;}
}

button_y = clamp(button_y,0,scrollDist);

scrollPercent = button_y/scrollDist;

draw_sprite(sprScrollLine,0,1580,100+button_y);

#endregion