#region Drawing the scrollbar and arrows
curX=camera_get_view_x(view_camera[0]);

//draws the arrows as either black or yellow depending on whether the mouse is hovering over
draw_sprite(sprCardShopLeftArrow,
	(mouse_x>curX+45 && mouse_x<curX+85 && mouse_y>930 && mouse_y<970),
	curX+65,950);
draw_sprite_ext(sprCardShopLeftArrow,
	(mouse_x>curX+1215 && mouse_x<curX+1255 && mouse_y>930 && mouse_y<970),
	curX+1235,950, -1,1,0,c_white,1);

if(mouse_check_button(mb_left))
{
	if((mouse_x>curX+1215 && mouse_x<curX+1255 && mouse_y>930 && mouse_y<970))
	{button_x+=scrollAmount;}
	else if(mouse_x>curX+45 && mouse_x<curX+85 && mouse_y>930 && mouse_y<970)
	{button_x-=scrollAmount;}
}

button_x = clamp(button_x,0,scrollDist);

scrollPercent = button_x/scrollDist;

draw_sprite(sprScrollLine,0,curX+100+button_x,769);

#endregion
