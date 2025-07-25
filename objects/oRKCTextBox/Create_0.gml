/***********************************************************************************
*This is the main textbox that will be used for dialogue in the Rainy Knight's Cafe.
* It should take up the entire width of the bottom of the screen and have any
* dialogue options presented to the right stacking upwards. It should also have the
* character's name in a box to the left opposite the options. This should support
* displaying a character portrait but should not require it.
***********************************************************************************/

textbox_width = 1600;//will likely be 1920 for the full game, but for the demo 1600
textbox_height = 300;//will likely change as well, but for now 300
border = 45;//will likely change

//These 2 should not change
line_spacing = 45;//our line spacing shouldn't change unless we make the text larger
line_width = textbox_width-(border*2);

textbox_spr[0] = sprRKCTextBox;
textbox_img=0;
textbox_imgSpd = 0;

textbox_speaker_sprite[0] = undefined;
textbox_speaker_name[0] = "";

//text
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