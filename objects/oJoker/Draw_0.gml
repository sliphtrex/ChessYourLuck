if(frames<room_speed)
{
	//Because we're calling ChangeTurns on Create, we will need to set this up
	//based on who's turn it was previously, rather than who's turn it is now

	//475 = middle of screen(800) - oDeck.x(292 || 1307)
	//356 = oDeck.y(800 || 100) - middle of screen(450)
	//if it's now the opponent's turn, then the player drew the joker
	if(!instance_find(oMatchManager,0).pTurn)
	{
		//move from the player's joker to the center screen
		draw_sprite_ext(sprJoker,0,
			//508 = middle of screen(800) - PlayerDeck.x(292)
			global.pDeck.x + ((frames/room_speed)*508),
			//350 = PlayerDeck.y(800) - middle of screen(450)
			global.pDeck.y - ((frames/room_speed)*350),
			1 + frames/room_speed,
			1 + frames/room_speed,
			0,c_white,1);
	}
	//if it's now the player's turn, then the opponent drew the joker
	else
	{
		//move from the opponent's joker to the center screen
		draw_sprite_ext(sprJoker,0,
			//OpDeck.x(1307) - middle of screen(800) 
			global.opDeck.x - ((frames/room_speed)*507),
			//middle of screen(450) - OpDeck.y(100)
			global.opDeck.y + ((frames/room_speed)*350),
			1 + frames/room_speed,
			1 + frames/room_speed,
			0,c_white,1);
	}
}
else if(frames<room_speed*2)
{
	//draw in the middle of the screen
	draw_sprite_ext(sprJoker,0,800,450,2,2,0,c_white,1);
}
else
{
	instance_destroy(id);
}
frames++;