if(menusActive)
{
	var camX = camera_get_view_x(view_camera[0]);
	var camY = camera_get_view_y(view_camera[0]);
	draw_sprite_stretched(sprVoidBorders,0,
		camX+room_width-400, camY,
		400, room_height);
	draw_sprite_stretched(sprVoidBorders,0,
		camX, camY+room_height-300,
		room_width-400, 300);
	
	if(!editor)
	{
		if(!SpAbShop)
		{
			if(itemNumber!=undefined)
			{
				var cardName = "";
				var cardDesc = "";
				var cost = 0;
		
				switch(itemNumber)
				{
					case 52: sprite_index = spr_1oC;
						cardName = "1 of Clubs";
						cardDesc = "For a little extra hurt.";
						cost = 2;
					break;
					case 53: sprite_index = spr_1oH;
						cardName = "1 of Hearts";
						cardDesc = "For a little extra love.";
						cost = 1;
					break;
					case 54: sprite_index = spr_1oS;
						cardName = "1 of Spades";
						cardDesc = "Because you deserve to feel special.";
						cost = 2;
					break;
					case 55: sprite_index = spr_1oD;
						cardName = "1 of Diamonds";
						cardDesc = "Pay 1 diamond. Get 1 diamond.";
						cost = 1;
					break;
					case 56: sprite_index = spr_15oS;
						cardName = "15 of Spades";
						cardDesc = "Only 13 Spades? Check again.";
						cost = 15;
					break;
					case 57: sprite_index = spr_15oD;
						cardName = "15 of Diamonds";
						cardDesc = "THAT'S A LOT OF DIAMONDS!!!";
						cost = 15;
					break;
				}
		
				draw_text(room_width-350,50,cardName);
				draw_sprite(sprite_index,0,room_width-200,170);
				draw_text_ext(room_width-350,250,"DESCRIPTION:",45,300);
				draw_text_ext(room_width-350,300,"  "+cardDesc,45,300);
		
				//draw button
				draw_set_colour($BC7200);
				draw_rectangle(room_width-350,room_height-200,room_width-50,room_height-50,false);
				draw_set_colour($00A0AB);
				var costString = "Buy For: " + string(cost);
				var csWidth = string_width_ext(costString,45,250);
				var csHeight = string_height_ext(costString,45,250);
				draw_text_ext(room_width-200-(csWidth/2),room_height-150-(csHeight/2),costString,
					45,250);
				draw_set_colour(c_white);
		
				if(mouse_check_button_released(mb_left)
					&&mouse_x>(room_width-350)&&mouse_x<(room_width-50)
					&&mouse_y>(room_height-200)&&mouse_y<(room_height-50)
					&&global.pDiamonds>=cost)
				{BuyCard(cost);}
			}
		}
		else
		{
			if(previewSpAb!=undefined)
			{
				draw_set_colour($BC7200);
				draw_rectangle(50,room_height-250,250,room_height-50,false);
				draw_set_colour($00A0AB);
				var costString = "Buy For: " + string(previewSpAb.cost);
				var csWidth = string_width_ext(costString,45,200);
				var csHeight = string_height_ext(costString,45,200);
				draw_text_ext(150-(csWidth/2),room_height-150-(csHeight/2),costString,
					45,200);
				draw_set_colour(c_white);
		
				if(mouse_check_button_released(mb_left)
					&&mouse_x>50&&mouse_x<250
					&&mouse_y>(room_height-250)&&mouse_y<(room_height-50)
					&&global.pDiamonds>=previewSpAb.cost)
				{BuySpAb();}
			}
		}
	}
}