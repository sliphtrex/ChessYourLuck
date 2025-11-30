event_inherited();

function TurnManager()
{
	//1. Have we drawn a card this turn?
		//I. if our hand is full, we need to play cards first.
			//i. if we have the Queen in hand, play it.
			//ii. if we have hearts and queen is played, heal the queen.
			//iii. if we have clubs, upgrade lower rank pieces.
			//iV. Otherwise, combine two cards. (max rank: bishop)
		//II. Draw a card.
	//2. Has the king moved this turn?
		//I. Can it move?
			//i. if yes, move to least harmful spot.
		//II. if not, set it's hasMoved = true 
	//3. Is the King protected from the player's pieces?
		//I. What pieces do we have that can surround the king?
			//i. move them there.
		//II. Do we need more pieces to surround the king? (goal 5)
			//i. Do we already have 10 pieces on the board? (blackPieces[]<10)
				//A. can we combine cards and play optimal pieces? (max rank: bishop)
				//B. otherwise, just play pawns as stand-ins
			//ii. Otherwise, move on.
		//III. can we attack threats with any piece?
	//4. Move the Queen.
		//I. Prioritize, putting the player's king(s) in check
	//5. Move any other unmoved pieces.
		//I.Prioritze attacking.
		//II. Try to get closer to king if nothing to attack.
		//III. Set up an attack if king is surrounded (goal 5)
		//IV. Choose to move randomly or stay put based on least harmful placement.
	//6. If Queen is defeated use Esteem first then Anger when possible
		//I. Have we used Esteem this match? (if not, use it)
		//II. Can we use Anger with our current SP? (Do so)
	//7. End Turn.
}