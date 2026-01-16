curX=camera_get_view_x(view_camera[0]);

if(!hidden)
{
	if(!surface_exists(maskSurface)){maskSurface = surface_create(room_width-600,300);}
	
	surface_set_target(maskSurface);
	draw_clear_alpha(c_black,0);
	draw_sprite(sprite_index,image_index,x-curX-100,150);
	surface_reset_target();
	draw_surface(maskSurface,curX+100,room_height-300);
}
