if(!hidden && instance_find(oShopGenerator,0).heldCard!=id)
{
	if(maskSurface==undefined){maskSurface = surface_create(400,700);}
	
	surface_set_target(maskSurface);
	draw_clear_alpha(c_black,0);
	draw_sprite(sprite_index,0,x-1200,y-100);
	surface_reset_target();
	draw_surface(maskSurface,1200,100);
}
else
{
	draw_sprite(sprite_index,0,x,y);
}