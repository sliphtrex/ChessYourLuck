text = "";
//0 is default scrolling, 1 is static typewriter
type = 0;

bg = sprVoidTextBox;
textDuration = 8;
color = c_white;
border = 4;
x = 1920;
y = irandom_range(50,room_height-string_height("I")-(border*2)-50);
NextMove = undefined;

//type 0 vars
boxSpeed=(room_width*2)/(room_speed*textDuration);

//type 1 vars
curText="";
curChar=1;
curTimer=0;
totalTime=textDuration*room_speed;