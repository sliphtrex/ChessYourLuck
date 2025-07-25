function DefaultCafeTextBox()
{
	line_break_pos[0,page_number]=1600;
	line_break_num[page_number]=0;
	line_break_offset[page_number]=0;
	
	textbox_width[page_number] = 1600;
	line_width[page_number] = textbox_width[page_number]-(border*2);
	textbox_spr[page_number] = sprRKCTextBox;
	//character portraits should be bottom left aligned
	textbox_speaker_sprite[page_number] = undefined;
	textbox_speaker_name[page_number] = global.ConvoChar;
	
}

function DefaultVoidTextBox()
{
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
}

//Call this when we click on a char in the cafe after setting global.CharConvo
//and it will take care of the rest.
function StartConvo()
{
	with(instance_create_layer(0,600,"Text",oRKCTextBox))
	{
		CharacterText();
	}
}

//1st param(string): the text we want to display
//2nd param(int): tells us if we're setting up a Cafe textbox(0) or a Void textbox(1) or an other(-1)
//3rd param(function): any check we should perform before continuing on (i.e. did the player play a specific card)
function Add_Text(_text, RKCorVoid=0, _widthMax = undefined, _xpos=undefined, _ypos=undefined, _check=undefined, _sprite=undefined)
{
	text[page_number]=_text;
	
	if(RKCorVoid==0){DefaultCafeTextBox();}
	else if(RKCorVoid==1)
	{DefaultVoidTextBox();}
		
	if(_widthMax!=undefined)
	{
		textbox_width[page_number] = _widthMax;
		line_width[page_number] = textbox_width[page_number]-(border*2);
	}
		
	if(_xpos!=undefined){text_x_offset[page_number]=_xpos;}
	if(_ypos!=undefined){text_y_offset[page_number]=_ypos;}
	
	if(_sprite!=undefined){textbox_spr[page_number] = sprRKCTextBox;}
	
	text_check[page_number] = _check;
	page_number++;
}

//1st param(string): the text to display
//2nd param(function): where will this take us
function Add_Option(_option, _linkID)
{
	option[option_number] = _option;
	optionLinkID[option_number] = _linkID;
	option_number++;
}