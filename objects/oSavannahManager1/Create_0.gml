event_inherited();

pStart=false;

function TurnManager()
{
	//1. Can we promote a pawn?
		//I. if(no Queen) {promote to Queen}
		//II. if(Queen) {promote to bishop (bestie)}
	//2. if(Queen==undefined && turn!=1)
		//I. {if(angerCheck){UseAngerAbility();}
	//3. Have we a Queen?
		//I. if(yes) {check Sub-optimal Health}
		//II. if(QC in hand) {play it}
		//III. if(QC ! in hand) {try to force the draw}
	//4. Has King moved this turn? (excluding 1st turn)
		//I. if(no) {look for spot to left or right and move there}
	//5. Has Queen moved this turn? (excluding 1st turn)
	
		/**********************************************************************
		/* NOTE: don't target Kings unless there's more than 1.
		/  We could avoid this entirely by just skipping the first
		/  whitePiece in the array, since that'll always be the initial king.
		**********************************************************************/
		
		//I. if(possible) {Attack}
		//II. if(can we move into atk position?) {do that}
		//III. Let's move as far as we can.
	//6. Is King Protected?
		//I. if(available pieces can surround King) {do that}
		//II. if(we have cards (besides clubs) in hand) {
			//i. play them in front of the King.
			//ii. set hasMoved=true for that piece.}
		//III. if(PainCheck) {use Pain}
	//7. if(clubs in hand && we have a piece (!king, !Queen, !guarding the king))
		//I. {use the club to boost their atk}
	//8. if(other pieces hasMoved=false)
		//I. if(can they atk && (if pawn(is our atk > opponent hp)) {atk}
		//II. else if(can we get in atk range of a king) {do that}
		//II. else if(pawns can advance) {advance them}
	//9. if(pieces>=5 && sp>=Esteem.cost) {use Esteem}
}