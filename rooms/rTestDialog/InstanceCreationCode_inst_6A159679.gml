//tb_settings.y = 300;
tb_settings.x = TB_POS.CENTER2;
tb_settings.y = TB_POS.CENTER2;

tb_settings.draw_options_top = true;

add_page("This is the first page");
second_page = add_page("This is the second page");

//add_page("This is the third page with options",[
//	make_option("Option one", function(){show_debug_message("We have hit option one");}),
//	make_option("Option two", function(){show_debug_message("We have hit option two");})
//	]);
	
add_page("This is the third page with options");

add_option("Option one", 
	function(){
		with(add_branch()){
			add_page("You have chosen the first option!");
		}
	}
);

is_option_two_enabled = false;
add_option("Option two", 
	function(){
		with(add_branch(second_page)){
			add_page("This is the second option! This convo will go back to the 2nd page");
			}
		}, 
	function(){return is_option_two_enabled;});

add_option("Option three", 
	function(){
		is_option_two_enabled = true;
		with(add_branch()){
			add_page("You chose option three! option two should now be enabled!");
		}
	}
);
