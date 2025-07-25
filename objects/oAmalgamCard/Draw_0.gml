draw_self();
if(clubs!=0){draw_sprite(sprBlackNumbers,clubs-1,x-35,y-57);}
if(hearts!=0){draw_sprite(sprRedNumbers,hearts-1,x+35,y-57);}
if(spades!=0){draw_sprite(sprBlackNumbers,spades-1,x+35,y+57);}
if(diamonds!=0){draw_sprite(sprRedNumbers,diamonds-1,x-35,y+57);}

if(pips<11)
{
	for(var i=0; i<pips; i++)
	{
		switch(i)
		{
			case 0: xx=x-13; yy=y-39; break;
			case 1: xx=x+13; yy=y-39; break;
			case 2: xx=x;    yy=y-26; break;
			case 3: xx=x-13; yy=y-13; break;
			case 4: xx=x+13; yy=y-13; break;
			case 5: xx=x-13; yy=y+13; break;
			case 6: xx=x+13; yy=y+10; break;
			case 7: xx=x;    yy=y+26; break;
			case 8: xx=x-13; yy=y+39; break;
			case 9: xx=x+13; yy=y+39; break;
		}
		switch(pip[i])
		{
			case "c":
				draw_sprite(sprClubPip,0,xx,yy);
				break;
			case "h":
				draw_sprite(sprHeartPip,0,xx,yy);
				break;
			case "s":
				draw_sprite(sprSpadePip,0,xx,yy);
				break;
			case "d":
				draw_sprite(sprDiamondPip,0,xx,yy);
				break;
		}
	}
}