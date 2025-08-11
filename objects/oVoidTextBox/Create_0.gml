/***********************************************************************************
* This is the main textbox that will be used for dialogue in The Void. It should
* only be as wide as our dialogue and shouldn't contain more than 2 lines of text.
* It should be able to move around the room dynamically when passed an (x,y). It
* should display any dialogue options as right aligned from the text, stacking
* downwards. It is a simple black box with white text, no name or character
* portraits required.
***********************************************************************************/

textbox_width[0] = 1200;//the distance between the borders
textbox_height = 110;//2 lines of dialogue means (line_spacing*2)+top and bottom border
text_x_offset[0] = 0;
text_y_offset[0] = 0;
border = 10;
line_spacing=45;
line_width[0] = textbox_width[0]-(border*2);

textbox_spr[0] = sprVoidTextBox;
textbox_img=0;
textbox_imgSpd = 0;

page = 0;
page_number = 0;
text[0] = "";
text_length = string_length(text[0]);

char[0,0] = "";
char_x[0,0] = 0;
char_y[0,0] = 0;

draw_char=0;
text_speed = 1;

//options
option[0]="";
optionLinkID[0] = undefined;
option_pos=-1;
option_number=0;

NextMove=undefined;

setup=false;

//essentially saying "we are free to break the line here!"
last_free_space = 0;

//# of frames to pause typing
pauseTime = 10;
curTimer=0;