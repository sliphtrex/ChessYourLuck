curX=camera_get_view_x(view_camera[0]);

if(!hidden)
{
	draw_sprite(sprite_index,image_index,x,y);
	
	/*
	if(maskSurface==undefined){maskSurface = surface_create(1000,300);}
	
	surface_set_target(maskSurface);
	draw_clear_alpha(c_black,0);
	draw_sprite(sprite_index,image_index,curX-100,0);
	surface_reset_target();
	draw_surface(maskSurface,curX+100,780);
	*/
}