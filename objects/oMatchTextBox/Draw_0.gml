if(type==0)
{
	draw_sprite_stretched_ext(bg,0,x,y,
		string_width(text)+border*2,
		string_height(text)+border*2,
		c_white,1);
	draw_text_color(x+border,y+border,text,color,color,color,color,1);
}
else if(type==1)
{
	draw_sprite_stretched_ext(bg,0,x,y,
		string_width(curText)+border*2,
		string_height(curText)+border*2,
		c_white,1);
	if(curText!=text){curText = string_copy(text,1,curChar); curChar++;}
	draw_text_color(x+border,y+border,curText,color,color,color,color,1);
}