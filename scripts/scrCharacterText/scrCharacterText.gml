/*
* This script handles all the character dialogue in the Rainy Knight's Cafe.
* The conversation that starts up is decided by:
*
*  - global.convoChar (the character we're currently speaking to)
*  - global.[CharNameHere]Convos (how many conversations we've completed so far)
*  - global.subText (where are we currently in this conversation)
*
*/

//This is called whenever we start a dialogue after we've set global.ConvoChar.
//It determines which character we're talking to and sends us to that char's dialogue options
function CharacterText()
{
	with(instance_create_layer(1920*global.curTable,960,"Text",oRKCTextBox))
	{
		switch(global.ConvoChar)
		{
			case "Savannah":
				if(global.SavannahCheckpoint!="")
				{global.ConvoString = global.SavannahCheckpoint;}
				show_debug_message(global.ConvoString);
				SavannahText();
			break;
			case "Anu": AnuText(); break;
		}
	}
}

function Add_A() {global.ConvoString += "A"; CharacterText();}
function Add_B() {global.ConvoString += "B"; CharacterText();}
function Add_C() {global.ConvoString += "C"; CharacterText();}
function Add_D() {global.ConvoString += "D"; CharacterText();}

#region Anu Convos / Card Shop
//This determines if Anu has available dialogue and generates it if it exists
function AnuText()
{
	switch(global.AnuConvos)
	{
		case -1:
			global.AnuConvos=2;
			Add_Text("I'm sorry. It appears as though you don't have any spare cards with which to edit your deck. Why not try buying some first?");
			break;
		case 0:
			global.AnuConvos++;
			Add_Text("Ah! Welcome weary traveller.\nIt is I. Anu!\n\nAm I how you expected?\n(Don't worry this is simply placeholder art for now.)");
			Add_Text("Welcome to the Rainy Knight's Cafe.\nI am the one and only Rainy Knight.\n\nWhy do they call me that?\nOnly time will tell.");
			Add_Text("At any rate. This is the card shop. Since it is your first venture here I will give you some funds.");
			NextMove=StartConvo;
		break;
		case 1:
			global.AnuConvos++;
			global.pDiamonds += (30-global.pDiamonds);
			Add_Text("There you go friend! Diamonds are the currency around here.\n\nNow, if you'd like to buy something, click the item on the shelf.\nYou can also talk to me if you just want to edit your deck or abilities.");
			Add_Text("Also, feel free to use that reservation list at the end of the bar to leave a record of your progress.");
		break;
		default:
			Add_Text("So, how can I be of service?");
				Add_Option("Edit Special Abilities", SelectedEditSpAbs);
				Add_Option("Edit Deck",SelectedEditDeck);
		break;
	}
}

function SelectedEditDeck()
{
	if(array_length(global.PlayerSpareCards)>0||array_length(global.PlayerCards)>20)
	{instance_find(oShopGenerator,0).SetupDeckEditor();}
	else
	{global.AnuConvos=-1; StartConvo();}
}

function SelectedEditSpAbs()
{instance_find(oShopGenerator,0).SetupSpAbEditor();}

#endregion

#region Savannah's Story

//This determines where we are in Savannah's story and generates the appropriate dialogue
function SavannahText()
{	
	switch(global.ConvoString)
	{
	case "Preview":
		instance_destroy(instance_find(oRKCTextBox,0));
		PreviewPlayer();
	break;
	
	#region convo 0
	
	case "Sav0":
		var pronoun = "";
		if(global.PlayerIcon==0){pronoun = ", man";}
		else if(global.PlayerIcon==1){pronoun = ", girl";}
		else if(global.PlayerIcon==2){pronoun = ", little cutie";}
		Add_Text("Heyo, I'm Savannah. Nice to meet you"+pronoun+".\nPeace, love, and wubs and all that jazz.");
		Add_Text("Tell me, are you the partying type?");
			if(global.PlayerIcon==0||global.PlayerIcon==1)
			{
			Add_Option("Not really.", Add_A);
			Add_Option("I love to party!",Add_B);
			}
			else if(global.PlayerIcon==2)
			{
			Add_Option("Sniff... Sneeze... Shake head", Add_A);
			Add_Option("Confident woof",Add_B);
			}
			else if(global.PlayerIcon==3)
			{
			Add_Option("Yawn", Add_A);
			Add_Option("Emphatic meow",Add_B);
			}
	break;
	case "Sav0A":
		global.SavannahCheckpoint = "Sav0AA";
		if(global.PlayerIcon==0||global.PlayerIcon==1)
		{
		var pronoun = (global.PlayerIcon==0) ? "man" : "guuurl"
		Add_Text(((global.PlayerIcon==0) ? "":"Oh, come on now. ")+"That's no fun, "+pronoun+"! You gotta learn to cut loose!");
		}
	case "Sav0AA":
		if(global.PlayerIcon==0||global.PlayerIcon==1)
		{Add_Text("Relax. Kidding! What the world needs now... is love, sweet love.");}
		else if(global.PlayerIcon==2)
		{Add_Text("Nah, you just like belly rubs?? Me too, little guy. Me too.");}
		else{Add_Text("Boring!! I know. You're a cat. You just want attention, huh?");}
	break;
	case "Sav0B":
		var pronoun = "";
		if(global.PlayerIcon==0){pronoun = ", man.";}
		else if(global.PlayerIcon==1){pronoun = ", am I right?!";}
		else if(global.PlayerIcon==2||global.PlayerIcon==3){pronoun = "!";}
		Add_Text(((global.PlayerIcon==2||global.PlayerIcon==3) ? "That's what I'm talking about! ":"")+"Gotta love the P.L.U.R. vibes"+pronoun+" No one judges you for being yourself.");
		if(global.PlayerIcon==0||global.PlayerIcon==1)
		{
		Add_Text("Just got back from the rave at Molly Darkly Moon Arena, love that name!");
		Add_Text("Hey, tell me... are you trying to escape? I may have a little left in my pocket.");
			Add_Option("Escape from what?",Add_A);
			Add_Option("I'll take one escape please",Add_B);
		}
		else{global.SavannahCheckpoint="Preview"; NextMove = PreviewPlayer;}
	break;
	case "Sav0BA":
		global.SavannahAffinity--;
		Add_Text("Oh, you sweet innocent child. I'm sorry, I should relax. I'm trying to quit, but it's hard you know?");
		global.SavannahCheckpoint = "Sav0BA";
	break;
	case "Sav0BB":
		Add_Text("That's what I'm talking about!\nSo...spill. What kinda shtuff you into?");
			Add_Option("You know... that drink", Add_A);
			Add_Option("Only the green stuff", Add_B);
			Add_Option("The harder the better", Add_C);
	break;
	case "Sav0BBA":
		Add_Text("Yeah, the best way to get all loosey-goosey. Let it all out!");
		global.SavannahCheckpoint = "Preview";
		NextMove = PreviewPlayer;
	break;
	case "Sav0BBB":
		Add_Text("I hear yuh. Don't want to get too wild. Keep it mild.");
		global.SavannahCheckpoint = "Preview";
		NextMove = PreviewPlayer;
	break;
	case "Sav0BBC":
		global.SavannahAffinity++;
		Add_Text("Respect... That's ... respect. I think we've all been there.");
		Add_Text("Not gonna lie. I didn't expect that from you.");
		global.SavannahCheckpoint = "Preview";
		NextMove = PreviewPlayer;
	break;
	
	//Savannah wins the match
	case "Sav0W":
		Add_Text("HEEEYYYOOOOO!! Booyah!\nThat's just how the cookie crumbles.");
		Add_Text("Don't worry. Be Happy!\n There's always tomorrow.");
		NextMove = ChangeDayPart;
	break;
	
	//Savannah loses the match
	case "Sav0L":
		global.SavannahConvos++;
		global.SavannahMatchNum++;
		Add_Text("Yo, what the heck! That's crazy! ..."+((global.PlayerIcon==2||global.PlayerIcon==3) ? " I just lost to a "+((global.PlayerIcon==2) ? "dog":"cat")+"!" : ""));
		Add_Text("You must have cheated.\nNo way you're THAT good.");
		Add_Text("Only way I could've lost that badly is if there was some kind of foul play involved.");
			if(global.PlayerIcon==0||global.PlayerIcon==1)
			{
			Add_Option("Foul play?", Add_A);
			Add_Option("I didn't cheat!", Add_B);
			}
			else if(global.PlayerIcon==2)
			{
			Add_Option("Whimper, confused bark", Add_A);
			Add_Option("Angry bark!", Add_B);
			}
			else if(global.PlayerIcon==3)
			{
			Add_Option("Stare down", Add_A);
			Add_Option("Hiss", Add_B);
			}
	break;
	case "Sav0LA":
		Add_Text("Yeah, I know a con job when I see it. You some kind of hustler or something?");
		Add_Text("I'm just kidding. Relax. Sorry if I'm being a sore loser. I just hate to lose.");
		Add_Text("At any rate, I expect a proper rematch next time. No funny business.");
		NextMove = ChangeDayPart;
	break;
	case "Sav0LB":
		Add_Text("Sure you didn't. You just happened to take out my queen with pure skill.");
		Add_Text("Whatever. I expect a proper rematch next time. No funny business.");
		NextMove = ChangeDayPart;
	break;
	
	#endregion
	
	#region convo 1
	
	case "Sav1":
		Add_Text("So tell me, what do you think of Anu?");
			if(global.PlayerIcon==0||global.PlayerIcon==1)
			{
			Add_Option("He's alright, I guess.",Add_A);
			Add_Option("I'm not sure yet.",Add_B);
			}
			else if(global.PlayerIcon==2)
			{
			Add_Option("Nod, paw at table",Add_A);
			Add_Option("tilt head",Add_B);
			}
			else if(global.PlayerIcon==3)
			{
			Add_Option("eyes wide, full attention",Add_A);
			Add_Option("sneeze",Add_B);
			}
	break;
	case "Sav1A":
		global.SavannahAffinity--;
		Add_Text("I should've known you'd take his side.\nYou seem like two peas in a pod.\nAll buddy buddy type.");
		NextMove = Add_A;
	break;
	
	//fail state 1
	case "Sav1AA":
		global.SavannahCheckpoint = "Sav1AA";
		Add_Text("Okay, you can go now. I don't have time for the likes of you.");
		if(global.SavannahAffinity<=0){NextMove=EndSavannahRoute;}
	break;
	
	case "Sav1B":
		var pronoun = "";
		if(global.PlayerIcon==0){pronoun = ", man";}
		else if(global.PlayerIcon==1){pronoun = ", gurl";}
		else if(global.PlayerIcon==2){pronoun = ", doggo";}
		else if(global.PlayerIcon==2){pronoun = ", pretty kitty";}
		Add_Text("Right!?! That's what I'm saying"+pronoun+"! You can't trust him either, can you?\n\nI knew you'd be the type to agree with me. We homies now.");
		Add_Text("I'm telling you though, it's always the quiet ones who you can't trust. You think everything is fine until they stab you in the back.\n\nNo warnings!\nCold blooded.");
		if(global.PlayerIcon==0||global.PlayerIcon==1)
		{
		Add_Text("Nah, for real though, we should go to a rave together sometime.\nIt'd be a great way to get back at my ex.\nDude's a total prick.\nDude totally cheated on me!");
			Add_Option("You deserve someone better.",Add_A);
			Add_Option("When did this happen?",Add_B);
		}
		else if(global.PlayerIcon==2||global.PlayerIcon==3){NextMove = Add_A;}
	break;
	case "Sav1BA":
		var intro = (global.PlayerIcon==0||global.PlayerIcon==1) ? "I know.\n" : "Sorry, just thinking about my ex. ";
		Add_Text(intro + "I told him I wanted an open relationship,\nbut that doesn't mean he can sleep with whoever he wants.");
		Add_Text("I told him I couldn't contain my love to one person.\nBut then he got all bent out of shape when I didn't want him seeing other women.");
		Add_Text("Doesn't he get it's about female empowerment, not male conquest?\n\nChauvanist jerk!");
		global.SavannahCheckpoint = "Preview";
		NextMove = PreviewPlayer;
	break;
	case "Sav1BB":
		global.SavannahAffinity--;
		if(global.SavannahAffinity==0)
		{
			Add_Text("I'm done with you constantly trying to read further into things. Why can't you just go with the flow!");
			NextMove = EndSavannahRoute;
		}
		else
		{
			Add_Text("You know that an open relationship doesn't mean you can just sleep with whoever you want right?");
			Add_Text("Well, I kinda slept with another girl before we were official.");
			Add_Text("Then when I told him I didn't want to be tied to just one person since I'm still exploring he said it should go both ways, and he should be able to explore too.\n\nMen are pigs!");
			NextMove = Add_A;
		}
	break;
	
	//fail state 2
	case "Sav1BBA":
		global.SavannahCheckpoint = "Sav1BBA";
		Add_Text("Men are PIGS!!");
	break;
	
	//Savannah wins the match
	case "Sav1W":
		Add_Text("Haha! Serves you right after cheating last time, "+((global.PlayerIcon==1||global.PlayerIcon==2) ? "bitch" : "pussy")+"!");
		Add_Text("Sorry. That's not cool. Drugs are one hell of a drug.");
		Add_Text("I'm gonna go sleep this off. Maybe we can play again another day?");
	break;
	
	//Savannah loses the match
	case "Sav1L":
		global.SavannahConvos++;
		global.SavannahMatchNum++;
		var pronoun = "";
		if(global.PlayerIcon==0){pronoun = "man";}
		if(global.PlayerIcon==1){pronoun = "dude";}
		if(global.PlayerIcon==2){pronoun = "little buddy";}
		if(global.PlayerIcon==3){pronoun = "you sweet thing, you";}
		var firstText = "Hey "+pronoun+", I'm sorry for being such a bitch.";
		if(global.PlayerIcon==2){firstText+="... Oh, sorry, buddy. Is that species-ist?";}
		Add_Text(firstText);
		Add_Text("I'm just... I always get like this after a big night out. I turn all paranoid and like... aggressive.");
		Add_Text("I just keep thinking about my ex. You know? He used to be so open with me about what was on his mind.");
		Add_Text("When I finally agreed that we could both see other people, he always made it a point to check in with me and make sure I was \"really okay\" before asking anyone out.");
		Add_Text("It was kind of cute in hindsight.");
		Add_Text("But one day, after a show, I got upset and told him I didn't want to hear about every stray thought he had.");
		Add_Text("...And, well, he kinda just shut down on me after that.");
		Add_Text("About a month later he came crying to me about how he had cheated by having a one night stand with some girl at a party.");
		Add_Text("He said he was sorry, but I know better. He just wanted to get back at me.");
			if(global.PlayerIcon==0||global.PlayerIcon==1)
			{
			Add_Option("Sounds like a lot to process", Add_C);
			Add_Option("sounds like you both made mistakes",Add_B);
			Add_Option("Sounds like he's evil",Add_A);
			}
			else if(global.PlayerIcon==2)
			{
			Add_Option("Tilt head", Add_C);
			Add_Option("Shake head aggressively",Add_B);
			Add_Option("Bark assertively",Add_A);
			}
			else if(global.PlayerIcon==3)
			{
			Add_Option("stick out tongue", Add_C);
			Add_Option("hop down from chair",Add_B);
			Add_Option("Hiss into the distance",Add_A);
			}
	break;
	case "Sav1LA":
		if(global.PlayerIcon==0||global.PlayerIcon==1){Add_Text("Plain and simple. No two ways about it.");}
		else if(global.PlayerIcon==2){Add_Text("You don't like him either huh? You're such a good judge of character.");}
		else if(global.PlayerIcon==3){Add_Text("You're getting the bad vibes from him too huh? If only you were there to stop me.");}
		Add_Text("...Anyway, let's play again sometime. It's nice to just talk, you know?");
		NextMove = ChangeDayPart;
	break;
	case "Sav1LB":
		if(global.PlayerIcon==0||global.PlayerIcon==1)
		{
		global.SavannahAffinity--;
		var pronoun = (global.PlayerIcon==0) ? "man" : "girl, come on";
		Add_Text("You're really gonna blame ME for this!? I'm the victim here! Don't blame the victim, "+pronoun+".");
		}
		else if(global.PlayerIcon==2)
		{
			Add_Text("No? Was that you saying no? I don't know, man! You didn't know him like I did.");
			Add_Text("What am I even getting worked up over? I'm talking to a dog!");
		}
		else if(global.PlayerIcon==3)
		{
			global.SavannahAffinity--;
			Add_Text("You're done with me? Well, jeez. I'm sorry.");
		}
		Add_Text("God, and here I thought we were getting along.");
		NextMove = ChangeDayPart;
	break;
	case "Sav1LC":
		if(global.PlayerIcon==0||global.PlayerIcon==1)
		{
		global.SavannahAffinity--;
		Add_Text("Nah, it's pretty cut and dry. I'm right. He's wrong. Plain and simple.");
		}
		else if(global.PlayerIcon==2){Add_Text("You don't understand a thing I'm saying, do you? It's okay, baby. Humans are complicated.");}
		else if(global.PlayerIcon==3){Add_Text("Oh, am I overloading you're tiny kitty brain? It's okay, baby. Humans are complicated.");}
		Add_Text("Sorry, I can't really handle nuance right now. Let's reconviene some other time.");
		NextMove = ChangeDayPart;
	break;
	
	#endregion
	
	#region convo 2
	
	case "Sav2":
		Add_Text("Hey, you came back! Let me start by apologizing for last time. I'm trying to quit smoking, but it's hard, you know?");
		Add_Text("I'm trying to replace bad habits with good ones. The problem is that there's just so many bad habits to break, and they make it so easy for me to fall right back into it.");
		Add_Text("Who are they? The government, of course! Really, look it up! The Nixon era?... Jerome Jaffe?\n...And now they're doing the same thing with weed.");
		Add_Text("They say they need to make their own synthetic shit for research purposes, but now you've got drugs that are stronger than ever and could kill an elephant.");
			if(global.PlayerIcon==0||global.PlayerIcon==1)
			{
			Add_Option("Breaking habits is hard", Add_C);
			Add_Option("Take some accountability", Add_B);
			Add_Option("Who's Jarome Jaffe?", Add_A);
			}
			else if(global.PlayerIcon==2)
			{
			Add_Option("Lick Savannah's face", Add_C);
			Add_Option("Whimper", Add_B);
			}
			else if(global.PlayerIcon==3)
			{
			Add_Option("Purr softly", Add_C);
			Add_Option("Lick paws", Add_B);
			}
	break;
	
	case "Sav2A":
		global.SavannahCheckpoint = "Sav2A";
		var pronoun = "";
		if(global.PlayerIcon==1){pronoun = ", girlfriend";}
		Add_Text("Oh man! You really need to do your homework"+pronoun+". I can't be educating you on basic politics. Next you'll tell me you don't know MLK.");
	break;
	
	case "Sav2B":
		var intro = "";
		if(global.PlayerIcon==0||global.PlayerIcon==1)
		{
			intro = "I am! ";
			global.SavannahAffinity--;
		}
		else if(global.PlayerIcon==2){intro = "You don't like it when I do drugs do you? ";}
		else if(global.PlayerIcon==3){intro = "You think I should be taking better care of myself, huh? ";}
		Add_Text(intro+"I realize I have to be part of the solution, not part of the problem.");
		Add_Text("I also realize that it's not entirely my fault since the system is rigged against me.");
		global.SavannahCheckpoint="Sav2BA";
	case "Sav2BA":
		Add_Text("I am trying to quit. It's just hard, okay?!");
	break;
	
	case "Sav2C":
		if(global.PlayerIcon==0||global.PlayerIcon==1)
		{
		Add_Text("Yeah, I know right? I replaced alcohol with weed. Then when that got too much, I switched to shrooms, which I could do every few months at first.");
		Add_Text("That didn't work for too long so I tried LSD. Then I found clinical trials for Ketamine. That was wild, but after that trial finished I didn't know what to do.");
		Add_Text("So, I went and tried party drugs, then switched to inhalants because they were cheaper. I almost died, got scared, and went back to weed cause that felt safer...");
		Add_Text("Honestly, I just don't know anymore.");
			Add_Option("Rely on your friends.", Add_A);
			Add_Option("That's... a lot.", Add_B);
		}
		else if(global.PlayerIcon==2)
		{
			Add_Text("Awe, you're so sweet! If I could bring you home with me that'd be a perfect distraction from all that bad stuff!");
			Add_Text("Unfortunately, my landlord won't let me have pets... my dad's alergic.");
			NextMove = Add_A;
		}
		else if(global.PlayerIcon==3)
		{
			Add_Text("Yeah... you don't understand what I'm saying at all. You just like the attention.");
			Add_Text("Gotta admit, your purring is kinda calming. If my dad wasn't allergic, I'd invite you to come live with me.");
			NextMove = Add_A;
		}
	break;
	
	case "Sav2CA":
		if(global.PlayerIcon==0||global.PlayerIcon==1)
		{
			var pronoun = (global.PlayerIcon==1) ? ", right?":"";
			Add_Text("Yeah, that would be the best option. Though that would require me to find more friends like you that don't live at the club.");
			Add_Text("Hey, we're friends"+pronoun+"! That's a good start!");
			global.SavannahCheckpoint = "Preview";
			NextMove = PreviewPlayer;
		}
		else if(global.PlayerIcon==2||global.PlayerIcon==3)
		{
			Add_Text("I guess, I just need to find more friends like you who don't live at the club.");
			Add_Text("...And preferably some who are human... no offense.");
			global.SavannahCheckpoint = "Preview";
			NextMove = PreviewPlayer;
		}
	break;
	
	case "Sav2CB":
		Add_Text("Yeeeaaah... It kind of is.");
		Add_Text("Never really thought about it before.");
	case "Sav2CBA":
		global.SavannahCheckpoint = "Sav2CBA";
		Add_Text("Now I'm feeling self-conscious.");
		Add_Text("Sorry, I gotta process this.");
	break;
	
	//Savannah wins the match
	case "Sav2W":
		Add_Text("Awe yeah! Booyah baby! I should go pro at this game.");
		Add_Text("Hey, that'd take my mind off drugs. Not such a bad idea.");
		Add_Text("We'll definitely play again soon.");
		NextMove = ChangeDayPart;
	break;
	
	//Savannah loses the match
	case "Sav2L":
		global.SavannahConvos++;
		global.SavannahMatchNum++;
		if(global.PlayerIcon==0||global.PlayerIcon==1)
		{
		Add_Text("So, I just got back from this underground rave, right? I was all gassed up for it, you know? Whipped it real good, if you know what I mean.");
		Add_Text("But in the middle of all the festivities I suddenly remembered my friend Becca. That really brought down my mood.");
		Add_Text("See, I love Becca. We're besties. She's a real ride or die that one, but bitch also owes me mad money. I'm talking like 300 dollars.");
			Add_Option("She's still your friend.", Add_C);
			Add_Option("Maybe she's hurting too.", Add_B);
			Add_Option("But who's counting?", Add_A);
		}
		if(global.PlayerIcon==2||global.PlayerIcon==3)
		{
		Add_Text("You know, that match reminded me of last night. I was at this underground rave, and I got totally whipped up on laughing gas.");
		Add_Text("But in the middle of all the festivities I suddenly remembered my friend Becca. That really brought down my mood.");
		Add_Text("I love Becca. We're besties, but that girl owes me mad money.");
			if(global.PlayerIcon==2)
			{
			Add_Option("Paw hand and shake head", Add_C);
			Add_Option("Paw hand and whimper", Add_B);
			Add_Option("Paw hand and bark", Add_A);
			}
			else if(global.PlayerIcon==3)
			{
			Add_Option("Blink twice slowly", Add_C);
			Add_Option("Hiss into distance", Add_B);
			Add_Option("Sneeze", Add_A);
			}
		}
	break;
	
	case "Sav2LA":
		var intro = "";
		if(global.PlayerIcon==0||global.PlayerIcon==1){intro="Yeah, ";}
		else if(global.PlayerIcon==2){intro="Nah, it's not that big a deal. ";}
		else if(global.PlayerIcon==3){intro="Bless you. You know what? ";}
		Add_Text(intro+"I guess 300 clams isn't really a lot to pay for friendship.");
		Add_Text("Maybe I should ask around about her. I haven't heard from her in like for-eevveerrr.");
		Add_Text("See, at first I just figured she didn't want to show her face around me without my money, but now...");
		Add_Text("I feel like it's been an unusually long wait... I hope everything is alright.");
		NextMove = ChangeDayPart;
	break;
	
	case "Sav2LB":
		var intro = "";
		if(global.PlayerIcon==2){intro="What, you think she's in trouble or something?\n";}
		else if(global.PlayerIcon==3)
		{
			intro="";
			Add_Text("Are you trying to protect me?... Or do you think she needs protection. Well, maybe.");
		}
		Add_Text(intro+"Nah, are you kidding me? That "+((global.PlayerIcon==2) ? "girl":"bitch")+"? She's so resourceful she'd put life-hack videos to shame.");
		Add_Text("Although, now that you mention it... it has been unusually long since we last spoke.");
		Add_Text("...And I guess everyone is dealing with something or other around here.");
		Add_Text("Maybe I should ask around.");
		NextMove = ChangeDayPart;
	break;
	
	case "Sav2LC":
		var intro = "";
		if(global.PlayerIcon==0||global.PlayerIcon==1){intro="Yeah! ";}
		else if(global.PlayerIcon==2||global.PlayerIcon==3){intro="No, you're right. ";}
		Add_Text(intro+"We're besties! I love that "+((global.PlayerIcon==3) ? "girl":"bitch")+" like a sister!");
		Add_Text("A sister I haven't spoken to in like... 4 months?");
		Add_Text("Okay, yeah. On second thought, I'm gonna do some digging and make sure she's not in trouble.");
		Add_Text("We're all dealing with something around here. Guess it's my turn to check in on her.");
		NextMove = ChangeDayPart;
	break;
	
	#endregion
	
	#region convo 3
	
	case "Sav3":
		var pronoun = "";
		if(global.PlayerIcon==0){pronoun = "duderino";}
		else if(global.PlayerIcon==1){pronoun = "girlie mc-girl face";}
		else if(global.PlayerIcon==2){pronoun = "doggy doggo";}
		else if(global.PlayerIcon==2){pronoun = "cool cat";}
		Add_Text("Hey "+pronoun+"!");
		Add_Text("Can you keep a secret?");
		if(global.PlayerIcon==0)
		{
			Add_Option("Are you okay?",Add_B);
			Add_Option("What's up, friend?",Add_A);
		}
		else if(global.PlayerIcon==1)
		{
			Add_Option("Oh no! what happened?",Add_B);
			Add_Option("What is it?",Add_A);
		}
		else if(global.PlayerIcon==2)
		{
			Add_Option("sniff and cover nose",Add_B);
			Add_Option("nod head",Add_A);
		}
		else if(global.PlayerIcon==3)
		{
			Add_Option("meow loudly",Add_B);
			Add_Option("do nothing",Add_A);
		}
	break;
	
	case "Sav3B":
		if(global.PlayerIcon==0)
		{
			global.SavannahAffinity-=3;
			Add_Text("I'm fine! I'm just a little drunk... and maybe a little high.");
			if(global.SavannahAffinity<=0){ Add_Text("Why does always something needs to always happen with you for me to get like this?");}
		}
		else if(global.PlayerIcon==1)
		{
			global.SavannahAffinity-=3;
			Add_Text("Shut uu-uup. You're so mean to me!");
			if(global.SavannahAffinity<=0){ Add_Text("Why does something always need to HAPPEN with you?");}
		}
		else if(global.PlayerIcon==2)
		{
			Add_Text("Ohhhh! It's okay baby! Don't leave, please.");
		}
		else if(global.PlayerIcon==3)
		{
			global.SavannahAffinity-=3;
			Add_Text("Shhh! Not so loud! I'm trying not to make a scene!");
		}
		NextMove=Add_A;
	break;
	
	case "Sav3BA":
		global.SavannahCheckpoint = "Sav3BA";
		if(global.PlayerIcon==0)
		{
			Add_Text("Can't a girl just get lit and have fun?");
			if(global.SavannahAffinity<=0) {Add_Text("FORGET IT!! You're no fun! I'm leaving!");}
		}
		else if(global.PlayerIcon==1)
		{
			Add_Text((global.SavannahAffinity<=0) ? "I'm so tired of you judging me all the time. You're no fun! I'm leaving!"
			: "You're no fun. Quit harshing my vibe.");
		}
		else if(global.PlayerIcon==2)
		{
			Add_Text("Awe, you're no fun, pup.");
		}
		else if(global.PlayerIcon==3)
		{
			Add_Text((global.SavannahAffinity<=0) ? "Go on, get out of here! Why don't you just leave me like everyone else?!"
			: "I'm sorry, the vibes just aren't there today.");
		}
		if(global.SavannahAffinity<=0){NextMove=EndSavannahRoute;}
	break;
	
	case "Sav3A":
		if(global.PlayerIcon==0)
		{
			Add_Text("You're so supportive. Why can't all men be like you, haha! To tell you the truth, I'm kinda drunk right now... and maybe a little high.");
			global.SavannahAffinity++;
		}
		else if(global.PlayerIcon==1){Add_Text("I'm just going through it right now. A little drunk, a little high.");}
		else if(global.PlayerIcon==2){Add_Text("Awe baby, you're such a good listener.");}
		else if(global.PlayerIcon==3){Add_Text("I'll take that as a yee-aaassss.");}
		
		Add_Text("It's Becca! Can you believe she's been sleeping on the streets!");
		Add_Text("That dumb bitch! Why wouldn't she even tell me? I thought we were friends!");
		Add_Text("I mean... it's not like I could really do much... but like... I'm her friend. I could've done something.");
		Add_Text("I wouldn't have been mad if she had just told me. Whatever! I can't with her.");
		
		global.SavannahCheckpoint = "Preview";
		NextMove = PreviewPlayer;
	break;
	
	//Savannah wins the match
	case "Sav3W":
		Add_Text("Hey, even at my worst, I'm still good at this game. I guess that's something.");
		Add_Text("Play again sometime?");
		NextMove = ChangeDayPart;
	break;
	
	//Savannah loses the match
	case "Sav3L":
		global.SavannahConvos++;
		global.SavannahMatchNum++;
		var pronoun = "";
		if(global.PlayerIcon==0){pronoun = "dude... bro.";}
		else if(global.PlayerIcon==1){pronoun = "girlie-friend.";}
		else if(global.PlayerIcon==2){pronoun = "doggo, puppy friend.";}
		else if(global.PlayerIcon==2){pronoun = "kitty mc-kitty face... fat... kate... huh?";}
		
		Add_Text("Hey "+pronoun+" Can I ask you something? Why is it that everyone leaves me?");
		if(global.PlayerIcon==0)
		{
			Add_Option("I don't know.", Add_A);
			Add_Option("You're kinda self-absorbed", Add_B);
		}
		else if(global.PlayerIcon==1)
		{
			Add_Option("I don't know.", Add_A);
			Add_Option("You're a conceited jerk", Add_B);
		}
		else if(global.PlayerIcon==2)
		{
			Add_Option("shake head", Add_A);
			Add_Option("bark", Add_B);
		}
		else if(global.PlayerIcon==3)
		{
			Add_Option("blink slowly", Add_A);
			Add_Option("walk away", Add_B);
		}
	break;
	
	case "Sav3LA":
		if(global.PlayerIcon==0)
		{
			global.SavannahAffinity-=3;
			Add_Text("Sure you don't. Man, no one ever thinks I can handle criticism.");
			if(global.SavannahAffinity<=0){Add_Text("It's okay, I'll get out of your hair.");}
		}
		else if(global.PlayerIcon==1)
		{
			global.SavannahAffinity-=3;
			Add_Text("Sure you don't. You really are just another bitch, huh?");
			if(global.SavannahAffinity<=0){Add_Text("I thought you would be different. Turns out I was wrong.");}
		}
		else if(global.PlayerIcon==2)
		{
			global.SavannahAffinity-=3;
			Add_Text("Sorry little buddy. I'm probably overloading your tiny mind right now, huh?");
			if(global.SavannahAffinity<=0){Add_Text("I guess I'll just get out of your fur and stop trying to have conversations with aminals.");}
		}
		else if(global.PlayerIcon==3)
		{
			global.SavannahAffinity-=3;
			Add_Text("Yeah, I don't really know what I was expecting honestly. That was a hard one for a cat. Man, I'm in deep.");
			if(global.SavannahAffinity<=0){Add_Text("I guess I'll just get out of your fur and stop trying to have conversations with aminals.");}
		}
		if(global.SavannahAffinity<=0){NextMove=EndSavannahRoute;}
		NextMove = ChangeDayPart;
	break;
	
	case "Sav3LB":
		if(global.PlayerIcon==0)
		{
			global.SavannahAffinity-=10;
			Add_Text("What the heck! Come on man! That's totally bull and you know it! You barely freaking know me! Geez, who asked you anyway?");
			if(global.SavannahAffinity<=0){Add_Text("It's okay, I'll get out of your hair. Since CLEARLY I'm the problem here!");}
		}
		else if(global.PlayerIcon==1)
		{
			global.SavannahAffinity+=3;
			Add_Text("Damn! Well aren't YOU a bitch today.");
			Add_Text("That's okay. I really respect that. Tell me like it is. Everyone else just seems to walk on eggshells because they think I can't handle criticism.");
			Add_Text("Reality is, most people can't take the same kinds of criticism they dish out.");
			Add_Text("Honestly, I had a feeling I might come across that way to outsiders. Guess I just needed to hear it from another bitch like me.");
			Add_Text("Thanks bestie! I'll see you soon.");
		}
		else if(global.PlayerIcon==2)
		{
			global.SavannahAffinity-=2;
			Add_Text("Hey! You scared me there, buddy!");
			if(global.SavannahAffinity<=0)
			{
			Add_Text("Wait, you're seriously afraid of me right now? Oh my god!");
			Add_Text("I'm so sorry little one. I didn't realize I was this bad.");
			Add_Text("I should go.");
			}else{
			Add_Text("Sorry, that really threw off the vibe. I'm a mess aren't I? I should probably go.");
			}
		}
		else if(global.PlayerIcon==3)
		{
			global.SavannahAffinity-=3;
			Add_Text("NOT YOU TOO!!");
			if(global.SavannahAffinity<=0)
			{
			Add_Text("Fine then!");
			Add_Text("Go on, get out! Leave me just like everyone else does!");
			}
		}
		if(global.SavannahAffinity<=0){NextMove=EndSavannahRoute;}
		NextMove = ChangeDayPart;
	break;
	
	#endregion
	
	#region convo 4
	
	case "Sav4":
		var pronoun = "";
		if(global.PlayerIcon==0){pronoun = "buddy";}
		else if(global.PlayerIcon==1){pronoun = "bestie";}
		else if(global.PlayerIcon==2){pronoun = "friendo";}
		else if(global.PlayerIcon==3){pronoun = "kitty";}
		Add_Text("Hey "+pronoun+", can I tell you something?");
		if(global.PlayerIcon==0)
		{
			Add_Option("Kinda busy right now",Add_A);
			Add_Option("What is it now?", Add_D);
			Add_Option("Yeah! what's up?",Add_B);
		}
		else if(global.PlayerIcon==1)
		{
			Add_Option("I don't want to hear it.", Add_A);
			Add_Option("What is it now?", Add_C);
			Add_Option("What's on your mind?",Add_B);
		}
		else if(global.PlayerIcon==2)
		{
			Add_Option("bark aggressively", Add_A);
			Add_Option("bark playfully", Add_C);
		}
		else if(global.PlayerIcon==3) 
		{
			Add_Option("Hiss", Add_A);
			Add_Option("Look away impassively", Add_B);
		}
	break;

	case "Sav4A":
		global.SavannahAffinity--;
		NextMove=Add_A;
    
	case "Sav4AA":
		global.SavannahCheckpoint = "Sav4AA";
		Add_Text("That's cold... but I get it.");
		if(global.SavannahAffinity<=0){NextMove=EndSavannahRoute;}
	break;

	case "Sav4B": case "Sav4C":
		if(global.ConvoString=="Sav4B")
		{
			if(global.PlayerIcon==0)
			{
			Add_Text("Man, you need to grow a pair! I've been walking all over you. You're too nice. Why do you let me do that?");
			Add_Text("Though really, I guess I should be thanking you for thaaa...");
			}
			else if(global.PlayerIcon==1) {Add_Text("Girl, stand up to me more! Where's that bitchy energy from last time?");}
			else if(global.PlayerIcon==3) {Add_Text("Whatever. I'll just tell you since you're still here.");}
		}
		else if(global.ConvoString=="Sav4C")
		{
			if(global.PlayerIcon==1){Add_Text("Damn bestie! I see you being a bitch! You're getting really good at thaaa...");}
			if(global.PlayerIcon==2){Add_Text("Someone's feeling playful today. Unfortunately, I'm kinda glued to the chair at the moment.");}
		}
	  
		Add_Text("...Sorry, the brownies chose the worst time to kick in...");
		Add_Text("I've been thinking though. I've gotta get better when it comes to love. Both self-love, and compassion for others.");
		Add_Text("Self-love means not tripping balls all the time.");
		Add_Text("But enough about me, I've been acting like a total "+((global.PlayerIcon==2) ? "jerk":"bitch")+" lately. That's not fair to others.");
		Add_Text("I'm not gonna be like all those hypocrites that judge people for stupid stuff. I really am trying to change.");
		Add_Text("Do you think I'm being a hypocrite?");
		
		if(global.PlayerIcon==0)
		{
			Add_Option("No way!",Add_A);
			Add_Option("Yeah, totally.",Add_B);
		}
		else if(global.PlayerIcon==1)
		{
			Add_Option("You want honesty?",Add_A);
			Add_Option("No doubt about it!",Add_B);
		}
		else if(global.PlayerIcon==2)
		{
			Add_Option("shake head",Add_A);
			Add_Option("Nod in confirmation", Add_B);
		}
		else if(global.PlayerIcon==3)
		{
			Add_Option("Yawn.",Add_A);
			Add_Option("Nod deliberately",Add_B);
		}
	break;
	
	case "Sav4BA": case "Sav4BB": case "Sav4CA": case "Sav4CB":
		if(global.ConvoString=="Sav4BA" || global.ConvoString=="Sav4CA")
		{
			if(global.PlayerIcon==0){Add_Text("You don't have to lie to protect me.");}
			else if(global.PlayerIcon==1){Add_Text("Gurl, give me the truth! I can handle it!");}
			else if(global.PlayerIcon==2){Add_Text("You know, at least I've got your undying loyalty.");}
			else if(global.PlayerIcon==3){Add_Text("Am I boring you now?");}
		}
		else if(global.ConvoString=="Sav4BB" || global.ConvoString=="Sav4CB")
		{
			if(global.PlayerIcon==0){Add_Text("He finally said it!");}
			else if(global.PlayerIcon==1){Add_Text("Damn straight, bitch!");}
			else if(global.PlayerIcon==2){Add_Text("Even this dog knows my ways.");}
			else if(global.PlayerIcon==3){Add_Text("Hey now. I'm starting to think you did that on purpose.");}
		}
		
		Add_Text("It's okay. I know I'm a bit judgy sometimes. I'm gonna make a serious effort to not do that so much anymore.");
		Add_Text("I hope you'll support me on this journey.");
		NextMove=PreviewPlayer;
	break;
	
	case "Sav4D":
		global.SavannahAffinity--;
		Add_Text("Hey man, watch your tone.");
	case "Sav4DA":
		global.SavannahCheckpoint="Sav4DA";
		Add_Text("It's okay. It wasn't that important anyway.");
		if(global.SavannahAffinity<=0){NextMove=EndSavannahRoute;}
	break;
	
	//Savannah wins the match
	case "Sav4W":
		Add_Text("Hey, that was fun. I really like playing against you.");
		Add_Text("Play again next time?");
		NextMove=ChangeDayPart;
	break;
	
	case "Sav4L":
		global.SavannahConvos++;
		global.SavannahMatchNum++;
		Add_Text("Wait... no. Something feels wrong... am I...");
		Add_Text("...dead?");
		Add_Text("How did this...?");
		Add_Text("That's right. It must've been that concert... The Molly Darkly Moon Arena.");
		Add_Text("I invited Becca to see her fave band, on me. We did some party stuff, and then my heart just started racing...");
		Add_Text("I didn't want things to end like this. I was gonna change. I swear I was on the verge of a breakthrough.");
		Add_Text("Promise me you'll pass on my message of meeting people where they're at. And always be true to yourself. Even if it means you're a "+((global.PlayerIcon==2) ? "jerk":"bitch")+".");
		Add_Text("P.L.U.R. vibes all day.");
		global.SavannahComplete=true;
		NextMove=EndSavannahRoute;
	break;
	
	#endregion
	
	}
}

function EndSavannahRoute() {global.SavannahAffinity = -1; instance_destroy(oSavannah);}

#endregion

#region Adam's Story
function AdamText()
{
	switch(global.AdamConvos)
	{
	case 0:
		Add_Text("It's me Adam.");
		NextMove = PreviewPlayer();
	break;
	}
}
#endregion

//the oMatchPreviewer object will set up the appropriate preview for a given match using
//the MatchPreview variable to determine which character we're currently talking to and
//that player's Match number to determine what their deck and abilities will look like.
function PreviewPlayer()
{
	instance_create_layer(0,0,"CardShop",oMatchPreviewer);
}

function ChangeDayPart()
{
	if(!(global.DayPart==2 && global.DayNum==13))
	{
		global.postMatch = false;
		global.DayPart++;
		if(global.DayPart==3){global.DayPart=0; global.DayNum++;}
	}
	
	curX = camera_get_view_x(view_camera[0]);
	instance_create_layer(curX,0,"Text",oFadeTransition);
}