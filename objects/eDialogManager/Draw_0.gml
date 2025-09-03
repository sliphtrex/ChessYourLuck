var cur_page = tb_content.cur_page;
var chars_drawn = tb_content.chars_drawn;
var line_spacing = tb_settings.line_spacing;
var line_width = tb_settings.line_width;
var border = tb_settings.border;

var cam_x = camera_get_view_x(view_camera[0]);
var cam_y = camera_get_view_y(view_camera[0]);
var cam_w = camera_get_view_width(view_camera[0]);
var cam_h = camera_get_view_height(view_camera[0]);

//show_debug_message("screen width: " + string(cam_w));

var txt = string_copy(tb_content.pages[cur_page].txt, 1,chars_drawn);

var ttb_w = tb_settings.w == TB_DIM.FILL_W ? cam_w : tb_settings.w;
var ttb_h = tb_settings.h == TB_DIM.FILL_H ? cam_h : tb_settings.h;

var tb_w = tb_settings.fixed_dim ? ttb_w : string_width_ext(txt, line_spacing, line_width) + border * 2;
var tb_h = tb_settings.fixed_dim ? ttb_h : string_height_ext(txt, line_spacing, line_width) + border * 2;




var page = tb_content.pages[tb_content.cur_page];
var page_x = page.settings.x;
var page_y = page.settings.y;

var bg_img = tb_settings.bg_img;							

//NOTE: we inherit these in child class

var ctb_w = tb_w;
switch(tb_settings.x){
	case TB_POS.CENTER2:
		ctb_w = string_width_ext(tb_content.pages[cur_page].txt, line_spacing, line_width) + border * 2;
	case TB_POS.CENTER:{
		tb_x = cam_x + (cam_w/2) - (ctb_w/2) + page_x;
	}break;
	
	case TB_POS.LEFT:{
		tb_x = 0; //TODO: do we want a fixed offset??
	}break;
	case TB_POS.RIGHT:{
		tb_x = cam_w - tb_w;
	}break;
	
	default:{
		tb_x = cam_x + tb_settings.x + page_x;
		}break;
}

var ctb_h = tb_h;
switch(tb_settings.y){
	case TB_POS.CENTER2:
		ctb_h = string_height_ext(tb_content.pages[cur_page].txt, line_spacing, line_width) + border * 2;
	case TB_POS.CENTER:{
		tb_y = cam_y + (cam_h/2) - (ctb_h/2) + page_y;
	}break;
	
	case TB_POS.TOP:{
		tb_y = 0; //TODO: do we want a fixed offset
	}break;
	case TB_POS.BOTTOM:{
		tb_y = cam_h - tb_h;
	}break;
	
	default:{
		tb_y = cam_y + tb_settings.y + page_y;
	}break;
}
					
function count_active_options(options){
	var count = 0;
	
	for(var i = 0; i < array_length(options); i ++){
		var option = options[i];
		count = option.cond() ? count + 1 : count;
	}
	
	return count;
}

//TODO:bg animation??

draw_sprite_stretched(bg_img,
	0,
	tb_x,
	tb_y,
	tb_w,tb_h);
	
draw_text_ext(tb_x + border,
	tb_y + border,
	txt, line_spacing,line_width);
	

var page_len = tb_content.pages[tb_content.cur_page].len;
tb_content.cur_selected = undefined;
var opt_offset = 0;
var is_top = tb_settings.draw_options_top;
var start_y = is_top ? tb_y - (get_total_option_height() + tb_settings.option_y_offset) : tb_y + tb_h;

for(var i = 0; tb_content.chars_drawn == page_len && i < array_length(page.options); i++){
	var option = page.options[i];
	
	if(!option.cond()){
		continue;
	}
	
	var h = string_height(option.txt) + (border * 2);
	
	
	opt_offset += h + tb_settings.option_spacing;
	var w = string_width(option.txt) + (border * 2);
	var ox = tb_x + tb_w - w;
	var oy = start_y + opt_offset;
		
	var bg_selection = (mouse_x >= ox && mouse_x <= ox+w && mouse_y >= oy && mouse_y <= oy+h) ? 1 : 0;
	tb_content.cur_selected = bg_selection == 1? option : tb_content.cur_selected;
	draw_sprite_stretched(bg_img,bg_selection,ox,oy,w,h);
	draw_text(ox + border, oy + border, option.txt);
	
		
}	

function get_total_option_height(){
	var h = 0;
	
	var page_len = tb_content.pages[tb_content.cur_page].len;
	var page = tb_content.pages[tb_content.cur_page];
	var border = tb_settings.border;
	
	for(var i = 0; tb_content.chars_drawn == page_len && i < array_length(page.options); i++){
		var option = page.options[i];
		
		if(!option.cond()){
			continue;
		}
		
		h += string_height(option.txt) + (border * 2) + tb_settings.option_spacing;
	}
	
	return h;
}
