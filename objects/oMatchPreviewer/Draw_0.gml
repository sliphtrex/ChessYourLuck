curX = camera_get_view_x(view_camera[0]);

draw_sprite_stretched(sprRKCTextBox,0,curX,780,1300,300);
draw_text_ext(curX+border,650,call,45,1200);

var op1w = string_width(response1)+(border*2);
//dimensions of response1 textbox [x1,y1,x2,y2]
var op1D = [curX+1300-op1w,330,curX+1300,465];
var op1Selected = (mouse_x>=op1D[0]&&mouse_y>=op1D[1]&&mouse_x<=op1D[2]&&mouse_y<=op1D[3]);
var op2w = string_width(response2)+(border*2);
//dimensions of response2 textbox [x1,y1,x2,y2]
var op2D = [curX+1300-op2w,465,curX+1300,600];
var op2Selected = (mouse_x>=op2D[0]&&mouse_y>=op2D[1]&&mouse_x<=op2D[2]&&mouse_y<=op2D[3]);

draw_sprite_stretched(sprRKCTextBox,op1Selected,op1D[0],op1D[1],op1w,135);
draw_text(op1D[0]+border,op1D[1]+border,response1);
draw_sprite_stretched(sprRKCTextBox,op2Selected,op2D[0],op2D[1],op2w,135);
draw_text(op2D[0]+border,op2D[1]+border,response2);

if(mouse_check_button_released(mb_left))
{
	if(op1Selected){StartMatch();}
	else if(op2Selected){ClosePreview();}
}

draw_sprite_stretched(sprRKCTextBox,0,curX+1300,0,300,900);