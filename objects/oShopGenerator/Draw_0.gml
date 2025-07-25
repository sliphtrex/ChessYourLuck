if(menusActive)
{
	var camX = camera_get_view_x(view_camera[0]);
	var camY = camera_get_view_y(view_camera[0]);
	draw_sprite_stretched(sprVoidBorders,0,camX+1200,camY,400,900);
	draw_sprite_stretched(sprVoidBorders,0,camX,camY+600,1200,300);
	
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
					case 52: sprite_index = spr_1oS;
						cardName = "1 of Spades";
						cardDesc = "Worth 1SP.";
						cost = 2;
					break;
					case 53: sprite_index = spr_1oD;
						cardName = "1 of Diamonds";
						cardDesc = "Pay 1 diamond. Get 1 diamond.";
						cost = 1;
					break;
					case 54: sprite_index = spr_13oS;
						cardName = "13 of Spades";
						cardDesc = "Unlucky to some, Worth 13SP to others.";
						cost = 10;
					break;
					case 55: sprite_index = spr_13oD;
						cardName = "13 of Diamonds";
						cardDesc = "13 diamonds is 13 diamonds.";
						cost = 10;
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
		
				draw_text(1250,50,cardName);
				draw_sprite(sprite_index,0,1400,170);
				draw_text_ext(1250,250,"DESCRIPTION:",45,300);
				draw_text_ext(1250,300,"    "+cardDesc,45,300);
		
				//draw button
				draw_set_colour($BC7200);
				draw_rectangle(1250,700,1550,850,false);
				draw_set_colour($00A0AB);
				var costString = "Buy For: " + string(cost);
				var csWidth = string_width_ext(costString,45,250);
				var csHeight = string_height_ext(costString,45,250);
				draw_text_ext(1400-(csWidth/2),750-(csHeight/2),costString,
					45,250);
				draw_set_colour(c_white);
		
				if(mouse_check_button_released(mb_left)
					&&mouse_x>1250&&mouse_x<1550&&mouse_y>700&&mouse_y<850
					&&global.pDiamonds>=cost)
				{BuyCard(cost);}
			}
		}
		else
		{
			if(previewSpAb!=undefined)
			{
				draw_set_colour($BC7200);
				draw_rectangle(50,650,250,850,false);
				draw_set_colour($00A0AB);
				var costString = "Buy For: " + string(previewSpAb.cost);
				var csWidth = string_width_ext(costString,45,200);
				var csHeight = string_height_ext(costString,45,200);
				draw_text_ext(150-(csWidth/2),750-(csHeight/2),costString,
					45,200);
				draw_set_colour(c_white);
		
				if(mouse_check_button_released(mb_left)
					&&mouse_x>50&&mouse_x<250&&mouse_y>650&&mouse_y<850
					&&global.pDiamonds>=previewSpAb.cost)
				{BuySpAb();}
			}
		}
	}
}