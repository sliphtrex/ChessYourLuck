//this is where we draw our starting hand
if(pDeck){CreateCard(global.PlayerCards[deckOrder[curCard]]);}
else{CreateCard(global.opCards[deckOrder[curCard]]);}
audio_play_sound(sndDrawCard,1,false);
curCard++;

//if we have less than 5 cards keep drawing cards
if(++firstHand<5){alarm[0] = .2 * room_speed;}