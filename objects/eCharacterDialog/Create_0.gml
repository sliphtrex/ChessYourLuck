event_inherited();


#region main object definitions
char_settings = {
	name : "",
	portrait : noone, // TODO: Use this
};
#endregion


#region functions

function rkcsettings(name){
	tb_settings.bg_img = sprRKCTextBox;
	tb_settings.draw_options_top = true;
	
	tb_settings.x = TB_POS.LEFT;
	tb_settings.y = TB_POS.BOTTOM;
	
	tb_settings.border = 45;
	//tb_settings.w = 1600 - (tb_settings.border * 2);
	tb_settings.w = TB_DIM.FILL_W;
	tb_settings.h = 300;
	tb_settings.fixed_dim = true;
	tb_settings.option_y_offset = 120;
	tb_settings.option_spacing = 0;
	recalculate_line_width();
	
//	tb_settings.w = TB_DIM.FILL_W;
//	recalculate_line_width();
	
	//TODO: sprite box
	char_settings.name = name;
}
#endregion

#region setup code

#endregion

