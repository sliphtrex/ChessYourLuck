if(hoverText!="" && hovering)
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
if(specialAbility!=-1)
{
	draw_set_halign(fa_center);
	draw_text(x,y+75,"Cost: "+string(cost)+"SP");
	draw_set_halign(fa_left);
}