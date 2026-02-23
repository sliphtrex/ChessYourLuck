#region card explanation
/***********************************************************************************
* Each number in the array[52] reperesents a card in the player's deck.
*
* 0=AC, 1-9=2C-10C, 10=JC, 11=QC, 12=KC
* 13=AH, 14-22=2H-10H, 23=JH, 24=QH, 25=KH
* 26=AS, 27-35=2S-10S, 36=JS, 37=QS, 38=KS
* 39=AD, 40-48=2D-10D, 49=JD, 50=QD, 51=KD
*
* Anything index higher than 51 marks a special card and will be handled slightly
* differently by the oDeck and oStandardCard objects when created in a match.
*
* 52 = 1 of clubs, 53 = 1 of hearts, 54 = 1 of Spades, 55 = 1 of Diamonds,
* 56 = 15 of Spades, 57 = 15 of Diamonds,
* 60 = King of Queens, 61 = Queen of Kings, 62 = Wheel of Wonder, 64 = 2 of Dice,
* 65 = Stock Card, 66 = Bond Card, 67 = Transfer of Power, 68 = King of Pong,
* 69 = Department of Defense, 70 = Library Card
*
***********************************************************************************/
#endregion

#region Savannah's Card Decks
//[QC,2H,2H,3H,3H,4H,4H,2S,2S,3S,3S,4S,4S,1D,2D,2D,3D,3D,4D,4D]
//global.SavannahsDecks[0] = [11,14,14,15,15,16,16,27,27,28,28,29,29,55,40,40,41,41,42,42];
global.SavannahsDecks[0] = [11,27,27,27,28,28,28,29,29,29,54,27,27,27,28,28,28,29,29,29,40,41,42];
//[1C,2C,2C,3C,3C,QC,4H,4H,1S,2S,2S,2S,3S,3S,3S,4S,4S,4S,15S,15S,2D,3D,4D,15D,15D]
global.SavannahsDecks[1] = [52,1,1,2,2,11,16,16,54,27,27,27,28,28,28,29,29,29,56,56,40,41,42,57,57];
//[2C,3C,4C,5C,6C,7C,QC,5H,6H,7H,1S,2S,3S,4S,5S,5S,6S,6S,7S,7S,15S,15S,2D,3D,4D,5D,6D,7D,15D,15D]
global.SavannahsDecks[2] = [52,1,2,3,4,5,6,11,17,18,19,54,27,28,29,30,30,31,31,32,32,56,56,40,41,42,43,44,45,57,57];
//[1C,1C,1C,1C,2C,3C,4C,QC,2H,2H,3H,3H,4H,4H,5H,6H,7H,1S,2S,2S,3S,3S,4S,4S,5S,5S,6S,6S,7S,7S,15S,15S,15S,1D,2D,3D,4D,15D,15D,15D]
global.SavannahsDecks[3] = [52,52,52,52,1,2,3,11,14,14,15,15,16,16,17,18,19,54,27,27,28,28,29,29,30,30,31,31,32,32,56,56,56,55,40,41,42,57,57,57];
//[1C,1C,1C,1C,2C,3C,4C,QC,2H,2H,3H,3H,4H,4H,5H,5H,6H,6H,7H,7H,8H,8H,9H,9H,10H,10H,1S,2S,3S,4S,5S,6S,7S,8S,9S,10S,15S,15S,15S,2D,3D,4D,15D,15D,15D]
global.SavannahsDecks[4] = [52,52,52,52,1,2,3,11,14,14,15,15,16,16,17,17,18,18,19,19,20,20,21,21,22,22,54,27,28,29,30,31,32,33,34,35,56,56,56,40,41,42,57,57,57];
#endregion

#region Marjorie's Card Decks
//[2H,3H,4H,5H,6H,7H,2S,2S,3S,3S,4S,4S,2D,3D,4D,5D,6D,7D,KC,QH]
global.MarjoriesDecks[0] = [14,15,16,17,18,19,27,27,28,28,29,29,40,41,42,43,44,45,12,24];
//[2H,3H,4H,5H,6H,7H,2S,2S,3S,3S,4S,4S,2D,3D,4D,5D,6D,7D,8D,9D,10D,KC,KS,QH]
global.MarjoriesDecks[1] = [14,15,16,17,18,19,27,27,28,28,29,29,40,41,42,43,44,45,46,47,48,12,38,24];
//[2H,3H,4H,5H,6H,7H,8H,9H,10H,2S,3S,4S,5S,6S,7S,2D,3D,4D,KC,KS,QH]
global.MarjoriesDecks[2] = [14,15,16,17,18,19,20,21,22,27,28,29,30,31,32,40,41,42,12,38,24];
//[2C,3C,4C,2H,3H,4H,5H,6H,7H,8H,9H,10H,2S,3S,4S,5S,6S,7S,8S,9S,10S,2D,3D,4D,KC,KS,QH]
global.MarjoriesDecks[3] = [1,2,3,14,15,16,17,18,19,20,21,22,27,28,29,30,31,32,33,34,35,40,41,42,12,38,24];
//[2C,3C,4C,5C,6C,7C,8C,9C,10C,2H,3H,4H,5H,6H,7H,8H,9H,10H,2S,3S,4S,5S,6S,7S,2D,3D,4D,5D,6D,7D,KC,KS,QC,QH,JH]
global.MarjoriesDecks[4] = [1,2,3,4,5,6,7,8,9,14,15,16,17,18,19,20,21,22,27,28,29,30,31,32,40,41,42,43,44,45,12,38,11,24,23];
//[2C,3C,4C,5C,6C,7C,2H,3H,4H,5H,6H,7H,8H,9H,10H,2S,3S,4S,5S,6S,7S,2D,3D,4D,5D,6D,7D,8D,9D,10D,KC,KS,QC,QH,JC,JH,AH]
global.MarjoriesDecks[5] = [1,2,3,4,5,6,14,15,16,17,18,19,20,21,22,27,28,29,30,31,32,40,41,42,43,44,45,46,47,48,12,38,11,24,10,23,13];
//[2C,3C,4C,5C,6C,7C,2H,3H,4H,5H,6H,7H,8H,9H,10H,2S,3S,4S,5S,6S,7S,2D,3D,4D,5D,6D,7D,8D,9D,10D,KC,KS,QC,QH,JC,JC,JH,JH,AH,KQ]
global.MarjoriesDecks[6] = [1,2,3,4,5,6,14,15,16,17,18,19,20,21,22,27,28,29,30,31,32,40,41,42,43,44,45,46,47,48,12,38,24,11,23,23,10,10,13,/*KQ*/];
//[2C,3C,4C,5C,6C,7C,8C,9C,10C,2H,3H,4H,5H,6H,7H,8H,9H,10H,2S,3S,4S,5S,6S,7S,2D,3D,4D,5D,6D,7D,8D,9D,10D,KC,KH,KS,QC,QH,JC,JC,JH,JH,AH,KQ]
global.MarjoriesDecks[7] = [1,2,3,4,5,6,7,8,9,14,15,16,17,18,19,20,21,22,27,28,29,30,31,32,40,41,42,43,44,45,46,47,48,12,25,38,24,11,23,23,10,10,13,/*KQ*/];
//[2C,3C,4C,5C,6C,7C,8C,9C,10C,2H,3H,4H,5H,6H,7H,8H,9H,10H,2S,3S,4S,5S,6S,7S,8S,9S,10S,2D,3D,4D,5D,6D,7D,8D,9D,10D,KC,KH,KS,QC,QH,JC,JC,JH,JH,AH,KQ]
global.MarjoriesDecks[8] = [1,2,3,4,5,6,7,8,9,14,15,16,17,18,19,20,21,22,27,28,29,30,31,32,33,34,35,40,41,42,43,44,45,46,47,48,12,38,25,24,24,11,23,23,10,10,13,/*KQ*/];
#endregion

#region Adam's Card Decks
global.AdamDecks[0] = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];
#endregion