if(matchOver&&!defeated)
{
	textbox_x = camera_get_view_x(view_camera[0]);
	textbox_y = camera_get_view_y(view_camera[0]);
	draw_sprite_stretched(sprRKCTextBox,0,200,0,1200,900);
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	show_debug_message(postMatchDialogue);
	
	if(postMatchDialogue==0)
	{draw_text_ext(textbox_x+800,textbox_y+450,"Looks like you just completed the demo! Congratulations champ!",45,1100);}
	else if(postMatchDialogue==1)
	{draw_text_ext(textbox_x+800,textbox_y+450,"Thanks for playing! Let me know what you think.",45,1100);}
	else if(postMatchDialogue==2)
	{draw_text_ext(textbox_x+800,textbox_y+450,"I'm hoping to get a team together to flesh this out more and hopefully bring it to Steam.",45,1100);}
	else if(postMatchDialogue==3)
	{draw_text_ext(textbox_x+800,textbox_y+450,"If you liked this, please consider checking out my other project Red's Righteous Auto.",45,1100);}
	else
	{draw_text_ext(textbox_x+800,textbox_y+450,"Whichever one gets the most engagement will likely be what I work on next.\n\nThis has been Chess Your Luck\na.k.a.\nRainy Knight's Cafe\n\nAnd once again the other project I'm working on is\n\nRed's Righteous Auto\n\nStay tuned for more.",45,1100);}
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	if(mouse_check_button_released(mb_left)){postMatchDialogue++;}
}
else if(matchOver&&defeated)
{
	textbox_x = camera_get_view_x(view_camera[0]);
	textbox_y = camera_get_view_y(view_camera[0]);
	draw_sprite_stretched(sprBlackoutScreen,0,200,0,1200,900);
}