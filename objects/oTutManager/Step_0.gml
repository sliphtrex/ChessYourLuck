if(queenSelected)
{
	if(queenSelectedFrames<room_speed)
	{
		queenSelectedFrames++;
	}
	else
	{
		AnuPlaysQueen();
		queenSelected=false;
	}
}

if(selected6H)
{
	if(selected6HFrames < room_speed)
	{
		selected6HFrames++;
	}
	else
	{
		AnuPlays6H();
		selected6H=false;
	}
}