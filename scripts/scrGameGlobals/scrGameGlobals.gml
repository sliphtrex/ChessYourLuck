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
* 52 = 1 of Spades, 53 = 1 of Diamonds, 54 = 13 of Spades, 55 = 13 of Diamonds,
* 56 = 15 of Spades, 57 = 15 of Diamonds, 58 = King of Queens
*
***********************************************************************************/
#endregion
/*
global.PlayerCards = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,
	25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51];
*/
global.PlayerCards = [1,2,3,4,5,14,15,16,17,18,27,28,29,30,31,40,41,42,43,44];
	
//this lists cards that the player owns but that aren't currently in their deck
global.PlayerSpareCards = undefined;

//shows the special cards which can be generated at the shop
global.UnlockableCards = [52,53,54,55,56,57];

#region list of Abilities
/***********************************************************************************
* This is simply an array of booleans that tells us whether we've unlocked a special
* ability or not. I set it to 36 for now since that's how many abilities are
* currently planned, but this could change.
*
* Maslow's Hierarchy:
* 0 - Survival: Creates a king with 1HP and 1ATK
* 1 - 
* 2 - Society: Any of your pieces which border another gain 3 HP
* 3 - 
* 4 - 
*
* The 7 Stages of Grief:
* 5 - 
* 6 - 
* 7 - 
* 8 - 
* 9 - 
* 10 - 
* 11 - 
*
* The 8 Types of Love:
* 12 - 
* 13 - 
* 14 - Pragma: Allows a piece that would be captured to survive with 1HP
* 15 - 
* 16 - 
* 17 - 
* 18 - Philautia: Each piece you control gains 1HP
* 19 - 
*
* The 8 C's of IFS
* 20 - 
* 21 - 
* 22 - 
* 23 - 
* 24 - 
* 25 - 
* 26 - 
* 27 - 
*
* The 8 Innate Human Fears:
* 28 - 
* 29 - 
* 30 - 
* 31 - 
* 32 - 
* 33 - 
* 34 - Pain: Choose a piece. This piece loses 1HP
* 35 - 
***********************************************************************************/
#endregion
global.SpecialsUnlocked = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0];

//the player's 3 special abilities that will be available in a match
global.PlayerSpecialAbility1 = 34;
global.PlayerSpecialAbility2 = -1;
global.PlayerSpecialAbility3 = -1;

//we should never need 34 as an unlock because it's unlocked from the start
global.UnlockableSpAbs = [0,2,14,18];

//The player's running total of diamonds
global.pDiamonds=0;
//0 = Male, 1 = Female, 2 = Dog, 3 = Cat 
global.PlayerIcon=undefined;
//How many days have we spent at the RKC
global.DayNum = 0;
// 0 = morning, 1 = afternoon, 2 = evening
global.DayPart = 0;
//starts at 0 and increases each time we finish the game.
global.Playthrough = 0;
//will be set true upon completion of a playthrough where the PlayerIcon==2
global.DogPlaythroughComplete=false;

//who are we speaking to currently; should be set whenever we start a dialogue
global.ConvoChar = undefined; //"Savannah";

//will mark our current table for when we come back to the cafe from the void
// 0 = bar (for Anu only), 1-3 = tables 1-3
global.curTable = undefined;
//will store if the last match ended in defeat or victory
global.playerDefeated = false;
//triggered when we finish a match, reset when we change day parts
global.postMatch=false;

//how many matches have we played against Anu
global.AnuMatchNum=0;
//What line are we at in the story
global.AnuConvos=0;

global.TitusMatchNum=0;
global.TitusConvos=0;

global.AmandaMatchNum=0;
global.AmandaConvos=0;

global.MarthaMatchNum=0;
global.MarthaConvos=0;

global.SavannahMatchNum=0;
global.SavannahConvos=0;

global.CelinaMatchNum=0;
global.CelinaConvos=0;

global.AdamMatchNum=0;
global.AdamConvos=0;