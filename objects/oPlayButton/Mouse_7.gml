//if set to new game go to the Void.
//if set to continue go to the Rainy Knight's Cafe
var nextRoom = (image_index) ? rRainyKnightsCafe : rVoid;
room_goto(nextRoom);