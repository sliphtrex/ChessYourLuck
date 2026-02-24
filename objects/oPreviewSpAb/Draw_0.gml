if(editable && instance_find(oShopGenerator,0).heldSpAb==id)
{
	draw_sprite(sprEmptyAb, (playerAb) ? 0 : 2, start_x,start_y);
	draw_self();
}
else
{
	if(hovering && hoverText!="")
	{
		if(descSide)
		{
			draw_set_halign(fa_right);
			draw_sprite(sprAbDescriptionBox,0,x+75-sprite_get_width(sprAbDescriptionBox),y-75);
			draw_text_ext(x-75,y-69,hoverText,45,590);
			draw_set_halign(fa_left);
		}
		else
		{
			draw_sprite(sprAbDescriptionBox,0,x-75,y-75);
			draw_text_ext(x+75,y-69,hoverText,45,590);
		}
	}
	draw_self();
	if(spAb!=-1)
	{
		draw_set_halign(fa_center);
		draw_text(x,y+75,"Cost: "+string(cost)+"SP");
		draw_set_halign(fa_left);
	}
}