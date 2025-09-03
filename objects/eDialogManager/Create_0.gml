#region main object definition
/* **Look at these. we might want to support these:
<< DefaultVoidTextBox
	//our line width[per line, per page]
	line_break_pos[0,page_number]=500;
	//how many line breaks are on a given page
	line_break_num[page_number]=0;
	//how many pixels of overflow from the last line
	line_break_offset[page_number]=0;
	
	textbox_spr[page_number] = sprVoidTextBox;
	textbox_width[page_number] = 1200;
	line_width[page_number] = textbox_width[page_number]-(border*2);
	text_x_offset[page_number] = 235;
	text_y_offset[page_number] = 170;
	
	//**also ask dakota what these are
	//these look like per page settings. we might want to support some of these. 
	We might want to support some default settings??
*/
tb_settings = {
	x : tb_x,
	y: tb_y,
	w : tb_width, //TODO: support per page width??
	h : tb_height,
	border : tb_border,
	line_spacing : tb_line_spacing,
	line_width : 0,
	
	//NOTE: this is for bg animations which we do not support yet
	bg_img : tb_bg_img,
	bg_spd : tb_bg_spd,
	draw_options_top : tb_draw_options_top,
	
	fixed_dim : false,
	option_y_offset : 0,
	option_spacing : 10,
};

enum TB_POS{
	CENTER = -1,
	CENTER2 = -2,
	
	//x only
	LEFT = -3,
	RIGHT = -4,
	
	//y only
	TOP = -3,
	BOTTOM = -4,
};

enum TB_DIM{
	FILL_W = -1,
	FILL_H = -1,
};

tb_content = {
	pages : [],
	cur_page : 0,
	chars_drawn : 0,
	cur_selected : undefined,	
};



EOD_cb = instance_destroy; // what to do at the end of a dialog. this may be better: instance_deactivate_object(id);
caller = {
	id : noone,
	page : -1, //NOTE: we could just write this directly into tb_content.cur_page instead. will revisit later
	//maybe this should be somewhere else
	//env_id : noone
}; // who called us? we can use this for branches
#endregion

#region functions
//TODO: maybe all callbacks should take the id of the caller?? look into this ig
//NOTE: DO NOT CALL THIS FUNCTION
function recalculate_line_width(){
	var cam_w = camera_get_view_width(view_camera[0]);
	var w = tb_settings.w >= 0 ? tb_settings.w : cam_w;
	//var w = tb_settings.w;
	tb_settings.line_width = w - (tb_settings.border * 2);
}

function next_page(){
	tb_content.chars_drawn = 0;
	tb_content.cur_page = tb_content.cur_page + 1 == array_length(tb_content.pages) ? 
		EOD_cb() : tb_content.cur_page + 1;	
}

function add_branch(next_page = -1,next_id = id, cr_layer = layer){
	var inst = instance_create_layer(x,y,cr_layer,eDialogManager);
	show_debug_message("-----------\n" + string(id) + " created " + string(inst));
	inst.caller.id = next_id;
	inst.caller.page = next_page == -1 ? tb_content.cur_page : next_page;
	//inst.caller.env_id = next_id.caller.env_id;
	var settings = tb_settings;
	
	with(inst){
		inst.tb_settings = settings;
		//TODO: we assume that we want to go (back) to caller
		//have to override this in a 'with' statement if we want other behaviors
		EOD_cb = function(){
			instance_activate_object(caller.id);
			caller.id.tb_content.cur_page = caller.page;
			instance_destroy();
		}
		
	}
	
	instance_deactivate_object(id);
	return inst;
}


function add_detatched_branch(to_destroy_caller = false){
	inst = add_branch(-1,id);
	with(inst){
		if(to_destroy_caller){
			show_debug_message("-----------\n" + string(id) + " deleteting " + string(caller.id));
			instance_destroy(caller.id);
		}
		
		EOD_cb = instance_destroy;
	}
	
	return inst;
}


function make_page(text, options = [], x = 0, y = 0, speed = 1){
	return {txt : text, len : string_length(text), options : options,
		settings : { x : x, y : y, spd : speed},
		page_actions : {before : undefined, after : id.next_page}
		};
}

function add_page(text, x = 0, y = 0, speed = 1, options = []){
	array_push(tb_content.pages, make_page(text,options,x,y,speed));
	return array_length(tb_content.pages) - 1; // we can use this to id a specific page to jump to
}

function add_page_action(after, before = undefined){
	tb_content.pages[array_length(tb_content.pages) - 1].page_actions.before = before;
	tb_content.pages[array_length(tb_content.pages) - 1].page_actions.after = after;
}

function make_option(text, callback = undefined, conditional_check = function(){return true;}){
	return {txt : text, cb : callback, cond : conditional_check};
}

function add_option(text, callback = undefined, conditional_check = function(){return true;}){
	array_push(tb_content.pages[array_length(tb_content.pages) - 1].options,
	{txt : text, cb : callback, cond : conditional_check});
}


function reset_content(){
	tb_content.cur_page = 0;
	tb_content.chars_drawn = 0;
}

function clear_content(){
	tb_content.pages = [];
	reset_content();
}

function voidsettings(){
	tb_settings.bg_img = sprVoidTextBox;
	tb_settings.w = 1200;
	recalculate_line_width();
	tb_settings.y = 375;
}

/*
function DefaultCafeTextBox()
{
	line_break_pos[0,page_number]=1600;
	line_break_num[page_number]=0;
	line_break_offset[page_number]=0;
	
	textbox_width[page_number] = 1600;
	line_width[page_number] = textbox_width[page_number]-(border*2);
	textbox_spr[page_number] = sprRKCTextBox;
	//character portraits should be bottom left aligned
	textbox_speaker_sprite[page_number] = noone;
	textbox_speaker_name[page_number] = global.ConvoChar;
	
}
*/

#endregion


#region setup code

recalculate_line_width();


draw_set_font(global.font_main);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
#endregion

