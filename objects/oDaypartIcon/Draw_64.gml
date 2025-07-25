dayText=undefined;
switch(global.DayNum)
{
	case 0: case 7:
	dayText = "Day: Monday";
	break;
	case 1: case 8:
	dayText = "Day: Tuesday";
	break;
	case 2: case 9:
	dayText = "Day: Wednesday";
	break;
	case 3: case 10:
	dayText = "Day: Thursday";
	break;
	case 4: case 11:
	dayText = "Day: Friday";
	break;
	case 5: case 12:
	dayText = "Day: Saturday";
	break;
	case 6: case 13:
	dayText = "Day: Sunday";
	break;
}
draw_text(10,10,dayText);
daypartText = "Time: ";
draw_text(10,string_height(dayText)+20,daypartText);
draw_sprite_ext(sprDaypartIcon,global.DayPart,10+string_width(daypartText),
	string_height(dayText)+20,1.5,1.5,0,c_white,1);
