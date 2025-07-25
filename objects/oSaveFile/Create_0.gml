myFile=0;
saving=true;
deleting=false;
selected = false;
fileName = "";
saved=false;
sprite_index = sprLargeBlueCardBack;
image_speed=0;
start_x=x;
start_y=y;

setup = false;
curSetupFrame=0;
setupFrames=room_speed/2;
flipCard=false;
midturn=false;
setupFinished=false;

moveOut=false;

function Setup()
{
	saved = (file_exists("CYL"+string(myFile)+".sav"));
	setup=true;
}

function MoveOut()
{
	setupFinished=false;
	moveOut=true;
	flipCard=true;
}