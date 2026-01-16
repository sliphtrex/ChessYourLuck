/******************************************************************************
* This object handles which characters appear at which tables on which days.
******************************************************************************/
switch(global.DayNum)
{
	case 0:
	switch(global.DayPart)
	{
		case 0:
			if(global.TitusAffinity>0){instance_create_layer(2880,450,"Instances",oTitus);}
			if(global.AmandaAffinity>0){instance_create_layer(4800,450,"Instances",oAmanda);}
			if(global.MarjorieAffinity>0){instance_create_layer(6720,450,"Instances",oMarjorie);}
		break;
		case 1:
			if(global.JarodAffinity>0){instance_create_layer(2880,450,"Instances",oJarod);}
			if(global.DanteAffinity>0){instance_create_layer(4800,450,"Instances",oDante);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
		case 2:
			if(global.AdamAffinity>0){instance_create_layer(2880,450,"Instances",oAdam);}
			if(global.CedricAffinity>0){instance_create_layer(4800,450,"Instances",oCedric);}
			if(global.SavannahAffinity>0){instance_create_layer(6720,450,"Instances",oSavannah);}
		break;
	}
	break;
	
	case 1:
	switch(global.DayPart)
	{
		case 0:
			if(global.SusanAffinity>0){instance_create_layer(2780,450,"Instances",oSusan);}
			if(global.ConnieAffinity>0){instance_create_layer(2980,450,"Instances",oConnie);}
			if(global.DrewAffinity>0){instance_create_layer(4800,450,"Instances",oDrew);}
		break;
		case 1:
			if(global.AmandaAffinity>0){instance_create_layer(4800,450,"Instances",oAmanda);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
		case 2:
			if(global.AdamAffinity>0){instance_create_layer(2880,450,"Instances",oAdam);}
			if(global.DanteAffinity>0){instance_create_layer(4800,450,"Instances",oDante);}
			if(global.SavannahAffinity>0){instance_create_layer(6720,450,"Instances",oSavannah);}
		break;
	}
	break;
	
	case 2:
	switch(global.DayPart)
	{
		case 0:
			if(global.CedricAffinity>0){instance_create_layer(4800,450,"Instances",oCedric);}
			if(global.MarjorieAffinity>0){instance_create_layer(6720,450,"Instances",oMarjorie);}
		break;
		case 1:
			if(global.JarodAffinity>0){instance_create_layer(2880,450,"Instances",oJarod);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
		case 2:
			if(global.LindsayAffinity>0){instance_create_layer(2780,450,"Instances",oLindsay);}
			if(global.MarthaAffinity>0){instance_create_layer(2980,450,"Instances",oMartha);}
			if(global.DrewAffinity>0){instance_create_layer(4800,450,"Instances",oDrew);}
			if(global.SavannahAffinity>0){instance_create_layer(6720,450,"Instances",oSavannah);}
		break;
	}
	break;
	
	case 3:
	switch(global.DayPart)
	{
		case 0:
			if(global.SusanAffinity>0){instance_create_layer(2780,450,"Instances",oSusan);}
			if(global.ConnieAffinity>0){instance_create_layer(2980,450,"Instances",oConnie);}
			if(global.DrewAffinity>0){instance_create_layer(4800,450,"Instances",oDrew);}
		break;
		case 1:
			if(global.AmandaAffinity>0){instance_create_layer(4800,450,"Instances",oAmanda);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
		case 2:
			if(global.AdamAffinity>0){instance_create_layer(2880,450,"Instances",oAdam);}
			if(global.DanteAffinity>0){instance_create_layer(4800,450,"Instances",oDante);}
			if(global.SavannahAffinity>0){instance_create_layer(6720,450,"Instances",oSavannah);}
		break;
	}
	break;
	
	case 4:
	switch(global.DayPart)
	{
		case 0:
			if(global.CedricAffinity>0){instance_create_layer(4800,450,"Instances",oCedric);}
			if(global.MarjorieAffinity>0){instance_create_layer(6720,450,"Instances",oMarjorie);}
		break;
		case 1:
			if(global.JarodAffinity>0){instance_create_layer(2880,450,"Instances",oJarod);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
		case 2:
			if(global.LindsayAffinity>0){instance_create_layer(2780,450,"Instances",oLindsay);}
			if(global.MarthaAffinity>0){instance_create_layer(2980,450,"Instances",oMartha);}
			if(global.DrewAffinity>0){instance_create_layer(4800,450,"Instances",oDrew);}
		break;
	}
	break;
	
	case 5:
	switch(global.DayPart)
	{
		case 0:
			if(global.TitusAffinity>0){instance_create_layer(2880,450,"Instances",oTitus);}
			if(global.SusanAffinity>0){instance_create_layer(4400,500,"Instances",oSusan);}
			if(global.ConnieAffinity>0){instance_create_layer(4600,400,"Instances",oConnie);}
			if(global.LindsayAffinity>0){instance_create_layer(5000,400,"Instances",oLindsay);}
			if(global.MarthaAffinity>0){instance_create_layer(5200,500,"Instances",oMartha);}
			if(global.DrewAffinity>0){instance_create_layer(6720,450,"Instances",oDrew);}
		break;
		case 1:
			if(global.DanteAffinity>0){instance_create_layer(4800,450,"Instances",oDante);}
			if(global.MarjorieAffinity>0){instance_create_layer(6720,450,"Instances",oMarjorie);}
		break;
		case 2:
			if(global.AdamAffinity>0){instance_create_layer(2880,450,"Instances",oAdam);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
	}
	break;
	
	case 6:
	switch(global.DayPart)
	{
		case 0:
			if(global.TitusAffinity>0){instance_create_layer(2880,450,"Instances",oTitus);}
		break;
		case 1:
			if(global.JarodAffinity>0){instance_create_layer(2880,450,"Instances",oJarod);}
			if(global.MarjorieAffinity>0){instance_create_layer(6720,450,"Instances",oMarjorie);}
		break;
		case 2:
			if(global.CedricAffinity>0){instance_create_layer(4800,450,"Instances",oCedric);}
		break;
	}
	break;
	
	case 7:
	switch(global.DayPart)
	{
		case 0:
			if(global.TitusAffinity>0){instance_create_layer(2880,450,"Instances",oTitus);}
			if(global.MarjorieAffinity>0){instance_create_layer(6720,450,"Instances",oMarjorie);}
		break;
		case 1:
			if(global.JarodAffinity>0){instance_create_layer(2880,450,"Instances",oJarod);}
			if(global.DanteAffinity>0){instance_create_layer(4800,450,"Instances",oDante);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
		case 2:
			if(global.AdamAffinity>0){instance_create_layer(2880,450,"Instances",oAdam);}
			if(global.CedricAffinity>0){instance_create_layer(4800,450,"Instances",oCedric);}
			if(global.SavannahAffinity>0){instance_create_layer(6720,450,"Instances",oSavannah);}
		break;
	}
	break;
	
	case 8:
	switch(global.DayPart)
	{
		case 0:
			if(global.SusanAffinity>0){instance_create_layer(2780,450,"Instances",oSusan);}
			if(global.ConnieAffinity>0){instance_create_layer(2980,450,"Instances",oConnie);}
			if(global.DrewAffinity>0){instance_create_layer(4800,450,"Instances",oDrew);}
		break;
		case 1:
			if(global.AmandaAffinity>0){instance_create_layer(4800,450,"Instances",oAmanda);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
		case 2:
			if(global.AdamAffinity>0){instance_create_layer(2880,450,"Instances",oAdam);}
			if(global.DanteAffinity>0){instance_create_layer(4800,450,"Instances",oDante);}
			if(global.SavannahAffinity>0){instance_create_layer(6720,450,"Instances",oSavannah);}
		break;
	}
	break;
	
	case 9:
	switch(global.DayPart)
	{
		case 0:
			if(global.TitusAffinity>0){instance_create_layer(2880,450,"Instances",oTitus);}
			if(global.CedricAffinity>0){instance_create_layer(4800,450,"Instances",oCedric);}
			if(global.MarjorieAffinity>0){instance_create_layer(6720,450,"Instances",oMarjorie);}
		break;
		case 1:
			if(global.JarodAffinity>0){instance_create_layer(2880,450,"Instances",oJarod);}
			if(global.AmandaAffinity>0){instance_create_layer(4800,450,"Instances",oAmanda);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
		case 2:
			if(global.LindsayAffinity>0){instance_create_layer(2780,450,"Instances",oLindsay);}
			if(global.MarthaAffinity>0){instance_create_layer(2980,450,"Instances",oMartha);}
			if(global.DrewAffinity>0){instance_create_layer(4800,450,"Instances",oDrew);}
			if(global.SavannahAffinity>0){instance_create_layer(6720,450,"Instances",oSavannah);}
		break;
	}
	break;
	
	case 10:
	switch(global.DayPart)
	{
		case 0:
			if(global.SusanAffinity>0){instance_create_layer(2780,450,"Instances",oSusan);}
			if(global.ConnieAffinity>0){instance_create_layer(2980,450,"Instances",oConnie);}
			if(global.DrewAffinity>0){instance_create_layer(4800,450,"Instances",oDrew);}
		break;
		case 1:
			if(global.AmandaAffinity>0){instance_create_layer(4800,450,"Instances",oAmanda);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
		case 2:
			if(global.AdamAffinity>0){instance_create_layer(2880,450,"Instances",oAdam);}
			if(global.DanteAffinity>0){instance_create_layer(4800,450,"Instances",oDante);}
			if(global.SavannahAffinity>0){instance_create_layer(6720,450,"Instances",oSavannah);}
		break;
	}
	break;
	
	case 11:
	switch(global.DayPart)
	{
		case 0:
			if(global.TitusAffinity>0){instance_create_layer(2880,450,"Instances",oTitus);}
			if(global.CedricAffinity>0){instance_create_layer(4800,450,"Instances",oCedric);}
			if(global.MarjorieAffinity>0){instance_create_layer(6720,450,"Instances",oMarjorie);}
		break;
		case 1:
			if(global.JarodAffinity>0){instance_create_layer(2880,450,"Instances",oJarod);}
			if(global.AmandaAffinity>0){instance_create_layer(4800,450,"Instances",oAmanda);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
		case 2:
			if(global.LindsayAffinity>0){instance_create_layer(2780,450,"Instances",oLindsay);}
			if(global.MarthaAffinity>0){instance_create_layer(2980,450,"Instances",oMartha);}
			if(global.DrewAffinity>0){instance_create_layer(4800,450,"Instances",oDrew);}
		break;
	}
	break;
	
	case 12:
	switch(global.DayPart)
	{
		case 0:
			if(global.SusanAffinity>0){instance_create_layer(4400,450,"Instances",oSusan);}
			if(global.ConnieAffinity>0){instance_create_layer(4700,400,"Instances",oConnie);}
			if(global.LindsayAffinity>0){instance_create_layer(4900,400,"Instances",oLindsay);}
			if(global.MarthaAffinity>0){instance_create_layer(5200,450,"Instances",oMartha);}
			if(global.DrewAffinity>0){instance_create_layer(6720,450,"Instances",oDrew);}
		break;
		case 1:
			if(global.DanteAffinity>0){instance_create_layer(4800,450,"Instances",oDante);}
			if(global.MarjorieAffinity>0){instance_create_layer(6720,450,"Instances",oMarjorie);}
		break;
		case 2:
			if(global.AdamAffinity>0){instance_create_layer(2880,450,"Instances",oAdam);}
			if(global.RebeccaAffinity>0){instance_create_layer(6720,450,"Instances",oRebecca);}
		break;
	}
	break;
	
	case 13:
	switch(global.DayPart)
	{
		case 0:
		break;
		case 1:
			if(global.JarodAffinity>0){instance_create_layer(2880,450,"Instances",oJarod);}
			if(global.MarjorieAffinity>0){instance_create_layer(6720,450,"Instances",oMarjorie);}
		break;
		case 2:
			if(global.CedricAffinity>0){instance_create_layer(4800,450,"Instances",oCedric);}
		break;
	}
	break;
}