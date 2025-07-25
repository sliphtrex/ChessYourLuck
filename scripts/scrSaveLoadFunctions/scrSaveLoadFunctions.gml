#macro SDSaveDate 0
#macro SDPlayerCards 1
#macro SDPlayerSpareCards 2
#macro SDSpecialsUnlocked 3
#macro SDSpAbs 4
#macro SDMatchNumber 5
#macro SDConvos 6
#macro SDDiamonds 7
#macro SDUnlockableCards 8
#macro SDUnlockableSpAbs 9
#macro SDPlayerIcon 10
#macro SDDayNumber 11
#macro SDDayPart 12
#macro SDPlaythrough 13
#macro SDDogPlaythroughComplete 14

function SaveGame(saveName)
{
	if(file_exists(saveName)){file_delete(saveName);}
	
	var _saveData = [];
	
	//the time of the save
	_saveData[SDSaveDate] = string(current_month)+"/"+string(current_day)+"/"
		+string(current_year)+" "+string(current_hour)+":" +string(current_minute);
		
	#region player Card Section
	_saveData[SDPlayerCards] = global.PlayerCards;
	_saveData[SDPlayerSpareCards] = global.PlayerSpareCards;
	#endregion
	#region Player SpAbs Section
	_saveData[SDSpecialsUnlocked] = global.SpecialsUnlocked;
	_saveData[SDSpAbs][0] = global.PlayerSpecialAbility1;
	_saveData[SDSpAbs][1] = global.PlayerSpecialAbility2;
	_saveData[SDSpAbs][2] = global.PlayerSpecialAbility3;
	#endregion
	#region Character Info: _saveData[5] = MatchNum, _saveData[6] = Convos
	_saveData[SDMatchNumber][0] = global.AnuMatchNum;
	_saveData[SDMatchNumber][1] = global.TitusMatchNum;
	_saveData[SDMatchNumber][2] = global.AmandaMatchNum;
	_saveData[SDMatchNumber][3] = global.MarthaMatchNum;
	_saveData[SDMatchNumber][4] = global.SavannahMatchNum;
	_saveData[SDMatchNumber][5] = global.CelinaMatchNum;
	_saveData[SDMatchNumber][6] = global.AdamMatchNum;
	
	_saveData[SDConvos][0] = global.AnuConvos;
	_saveData[SDConvos][1] = global.TitusConvos;
	_saveData[SDConvos][2] = global.AmandaConvos;
	_saveData[SDConvos][3] = global.MarthaConvos;
	_saveData[SDConvos][4] = global.SavannahConvos;
	_saveData[SDConvos][5] = global.CelinaConvos;
	_saveData[SDConvos][6] = global.AdamConvos;
	#endregion
	#region Cafe Section
	_saveData[SDDiamonds] = global.pDiamonds;
	_saveData[SDUnlockableCards] = global.UnlockableCards;
	_saveData[SDUnlockableSpAbs] = global.UnlockableSpAbs;
	#endregion
	#region playthrough config
	_saveData[SDPlayerIcon] = global.PlayerIcon;
	_saveData[SDDayNumber] = global.DayNum;
	_saveData[SDDayPart] = global.DayPart;
	_saveData[SDPlaythrough] = global.Playthrough;
	_saveData[SDDogPlaythroughComplete] = global.DogPlaythroughComplete;
	#endregion
	
	var saveString = json_stringify(_saveData);
	var buffer = buffer_create(string_byte_length(saveString)+1,buffer_fixed,1);
	buffer_write(buffer,buffer_string,saveString);
	buffer_save(buffer, saveName);
	buffer_delete(buffer);
}

function LoadGame(fileName)
{
	if(file_exists(fileName))
	{
		var _buffer = buffer_load(fileName);
		var _string = buffer_read(_buffer,buffer_string);
		buffer_delete(_buffer);
	
		var _loadData = json_parse(_string);
		
		global.PlayerCards = _loadData[SDPlayerCards];
		global.PlayerSpareCards = _loadData[SDPlayerSpareCards];
		global.SpecialsUnlocked = _loadData[SDSpecialsUnlocked];
		global.PlayerSpecialAbility1 = _loadData[SDSpAbs][0];
		global.PlayerSpecialAbility2 = _loadData[SDSpAbs][1];
		global.PlayerSpecialAbility3 = _loadData[SDSpAbs][2];
		
		global.AnuMatchNum = _loadData[SDMatchNumber][0];
		global.TitusMatchNum = _loadData[SDMatchNumber][1];
		global.AmandaMatchNum = _loadData[SDMatchNumber][2];
		global.MarthaMatchNum = _loadData[SDMatchNumber][3];
		global.SavannahMatchNum = _loadData[SDMatchNumber][4];
		global.CelinaMatchNum = _loadData[SDMatchNumber][5];
		global.AdamMatchNum = _loadData[SDMatchNumber][6];
		
		global.AnuConvos = _loadData[SDConvos][0];
		global.TitusConvos = _loadData[SDConvos][1];
		global.AmandaConvos = _loadData[SDConvos][2];
		global.MarthaConvos = _loadData[SDConvos][3];
		global.SavannahConvos = _loadData[SDConvos][4];
		global.CelinaConvos = _loadData[SDConvos][5];
		global.AdamConvos = _loadData[SDConvos][6];
		
		global.pDiamonds = _loadData[SDDiamonds];
		global.UnlockableCards = _loadData[SDUnlockableCards];
		global.UnlockableSpAbs = _loadData[SDUnlockableSpAbs];
		
		global.PlayerIcon = _loadData[SDPlayerIcon];
		global.DayNum = _loadData[SDDayNumber];
		global.DayPart = _loadData[SDDayPart];
		global.Playthrough = _loadData[SDPlaythrough];
		global.DogPlaythroughComplete = _loadData[SDDogPlaythroughComplete];
	}
}