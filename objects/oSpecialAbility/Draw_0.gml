if(hoverText!="" && hovering)
{
	if(playerAb)
	{
		draw_sprite(sprAbDescriptionBox,0,0,y-75);
		draw_text_ext(200,y-69,hoverText,45,590);
	}
	else
	{
		draw_set_halign(fa_right);
		draw_sprite(sprAbDescriptionBox,0,800,y-75);
		draw_text_ext(1400,y-69,hoverText,45,590);
		draw_set_halign(fa_left);
	}
}

//set the image to grey if the user doesn't have enough SP
//when we do, set it to blue for the player and red for the opponent 
image_index = (CheckIfUsable()) ? ((playerAb) ? 0:2) : 1;

draw_self();
if(hovering && specialAbility!=-1)
{
	var strlng = string_width(string(cost)+"SP");
	draw_text(x-(strlng/2),y,string(cost)+"SP");
}