var is_clicked = mouse_check_button_released(mb_left);
var pages = tb_content.pages;
var page_len = pages[tb_content.cur_page].len;
var page_spd = pages[tb_content.cur_page].settings.spd;
var page_actions = pages[tb_content.cur_page].page_actions;


var rebind_cb = function(cb){
	return method(id,cb);
}

if(page_actions.before != undefined){
	page_actions.before();
}

if(is_clicked){
	
	if(tb_content.chars_drawn == page_len){
		
		if(!array_length(pages[tb_content.cur_page].options) == 0){
			var cur_selected = tb_content.cur_selected;
			if(cur_selected != undefined && cur_selected.cb != undefined){
				var cb = rebind_cb(cur_selected.cb);
				cb();
			}
			return;
		}
		rebind_cb(page_actions.after)();
	}
	
	else{
		tb_content.chars_drawn = page_len;
	}

}


tb_content.chars_drawn = clamp(tb_content.chars_drawn + page_spd, 0, page_len);

