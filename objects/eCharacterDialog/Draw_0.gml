event_inherited();
/*
var txt = string_copy(tb_content.pages[cur_page].txt, 1,chars_drawn);
var tb_w = string_width_ext(txt, line_spacing, line_width) + border * 2;
var tb_h = string_height_ext(txt, line_spacing, line_width) + border * 2;

//NOTE: we inherit these in child class
tb_x = tb_settings.x >= 0 ? cam_x + tb_settings.x + page_x : 
					cam_x + (cam_w/2) - (ctb_w/2) + page_x;
					
tb_y = tb_settings.y >= 0 ? cam_y + tb_settings.y + page_y :
					cam_y + (cam_h/2) - (ctb_h/2) + page_y;
					
draw_sprite_stretched(bg_img,
	0,
	tb_x,
	tb_y,
	tb_w,tb_h);
	
draw_text_ext(tb_x + border,
	tb_y + border,
	txt, line_spacing,line_width);
*/



var line_spacing = tb_settings.line_spacing;
var line_width = tb_settings.line_width;
var img = tb_settings.bg_img;
var border = tb_settings.border;

var name = char_settings.name;
var char_w = string_width_ext(name,line_spacing,line_width) + border * 2;
var char_h = string_height_ext(name,line_spacing,line_width) + border * 2;
var char_x = tb_x;
var char_y = tb_y - char_h;

draw_sprite_stretched(img,0,char_x,char_y,char_w,char_h);
draw_text_ext(char_x + border, char_y + border, name, line_spacing,line_width);

//TODO: have option to draw options on the top. probs will need to be in the parent function
