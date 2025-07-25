if(!hidden)
{
	if(maskSurface==undefined){maskSurface = surface_create(1000,300);}
	
	surface_set_target(maskSurface);
	draw_clear_alpha(c_black,0);
	draw_sprite(sprite_index,image_index,x-100,y-600);
	surface_reset_target();
	draw_surface(maskSurface,100,600);
}