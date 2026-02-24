if(!hidden && instance_find(oShopGenerator,0).heldSpAb!=id)
{
	if(global.SpecialsUnlocked[spAb] && !inUse && hovering && hoverText!="")
	{
		draw_set_halign(fa_right);
		draw_sprite(sprAbDescriptionBox,0,x+75-sprite_get_width(sprAbDescriptionBox),y-75);
		draw_text_ext(x-75,y-69,hoverText,45,590);
		draw_set_halign(fa_left);
	}
	
	if(!surface_exists(maskSurface)){maskSurface = surface_create(400,room_height-200);}
	surface_set_target(maskSurface);
	draw_clear_alpha(c_black,0);
	draw_sprite(sprite_index,(global.SpecialsUnlocked[spAb] && !inUse) ? 0 : 1 ,200,y-100);
	surface_reset_target();
	draw_surface(maskSurface,room_width-400,100);
}
else if(!hidden || instance_find(oShopGenerator,0).heldSpAb==id)
{
	draw_sprite(sprite_index,0,x,y);
}