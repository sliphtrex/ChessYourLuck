#region Drawing the scrollbar and arrows

//draws the arrows as either black or yellow depending on whether the mouse is hovering over
draw_sprite(sprCardShopLeftArrow,
	(mouse_x>45 && mouse_x<85 && mouse_y>730 && mouse_y<770),
	65,750);
draw_sprite_ext(sprCardShopLeftArrow,
	(mouse_x>1115 && mouse_x<1155 && mouse_y>730 && mouse_y<770),
	1135,750, -1,1,0,c_white,1);

if(mouse_check_button(mb_left))
{
	if((mouse_x>1115 && mouse_x<1155 && mouse_y>730 && mouse_y<770))
	{button_x+=scrollAmount;}
	else if(mouse_x>45 && mouse_x<85 && mouse_y>730 && mouse_y<770)
	{button_x-=scrollAmount;}
}

button_x = clamp(button_x,0,scrollDist);

scrollPercent = button_x/scrollDist;

draw_sprite(sprScrollLine,0,100+button_x,619);

#endregion
