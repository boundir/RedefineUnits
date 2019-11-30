class RU_Helpers extends Object;

`define RU_Log(msg) `Log(`msg,, 'RedefineUnits')

static function ModifyTemplate(X2CharacterTemplate CharacterTemplate, CharacterNames CharacterConfig)
{
	// Psionic Unit
	if(CharacterConfig.IsPsionic != '')
	{
		if(CharacterConfig.IsPsionic == 'TRUE')
		{
			CharacterTemplate.bIsPsionic = true;
			`RU_Log(CharacterTemplate.DataName @ "is Psionic");
		}
		else if(CharacterConfig.IsPsionic == 'FALSE')
		{
			CharacterTemplate.bIsPsionic = false;
			`RU_Log(CharacterTemplate.DataName @ "is not Psionic");
		}
		else
		{
			`RU_Log(CharacterConfig.IsPsionic @ "is neither true or false");
		}
	}
	// Robotic Unit
	if(CharacterConfig.IsRobotic != '')
	{
		if(CharacterConfig.IsRobotic == 'TRUE')
		{
			CharacterTemplate.bIsRobotic = true;
			`RU_Log(CharacterTemplate.DataName @ "is Robotic");
		}
		else if(CharacterConfig.IsRobotic == 'FALSE')
		{
			CharacterTemplate.bIsRobotic = false;
			`RU_Log(CharacterTemplate.DataName @ "is not Robotic");
		}
		else
		{
			`RU_Log(CharacterConfig.IsRobotic @ "is neither true or false");
		}
	}
	// Unit takes bluescreen rounds effect
	if(CharacterConfig.IsWeakToBluescreen != '')
	{
		if(CharacterConfig.IsWeakToBluescreen == 'TRUE')
		{
			CharacterTemplate.bWeakAgainstTechLikeRobot = true;
			`RU_Log(CharacterTemplate.DataName @ "is weak to bluescreen rounds");
		}
		else if(CharacterConfig.IsWeakToBluescreen == 'FALSE')
		{
			CharacterTemplate.bWeakAgainstTechLikeRobot = false;
			`RU_Log(CharacterTemplate.DataName @ "is not weak to bluescreen rounds");
		}
		else
		{
			`RU_Log(CharacterConfig.IsWeakToBluescreen @ "is neither true or false");
		}
	}
	// Unit is hidden from Shadow Chamber
	if(CharacterConfig.IsHiddenFromShadowChamber != '')
	{
		if(CharacterConfig.IsHiddenFromShadowChamber == 'TRUE')
		{
			CharacterTemplate.bHideInShadowChamber = true;
			`RU_Log(CharacterTemplate.DataName @ "is hidden from Shadow Chamber");
		}
		else if(CharacterConfig.IsHiddenFromShadowChamber == 'FALSE')
		{
			CharacterTemplate.bHideInShadowChamber = false;
			`RU_Log(CharacterTemplate.DataName @ "is not hidden from Shadow Chamber");
		}
		else
		{
			`RU_Log(CharacterConfig.IsHiddenFromShadowChamber @ "is neither true or false");
		}
	}
	// Unit doesn't take damage from falling
	if(CharacterConfig.IsImmueToFalling != '')
	{
		if(CharacterConfig.IsImmueToFalling == 'TRUE')
		{
			CharacterTemplate.bImmueToFalling = true;
			`RU_Log(CharacterTemplate.DataName @ "is immune to falling");
		}
		else if(CharacterConfig.IsImmueToFalling == 'FALSE')
		{
			CharacterTemplate.bImmueToFalling = false;
			`RU_Log(CharacterTemplate.DataName @ "is not immune to falling");
		}
		else
		{
			`RU_Log(CharacterConfig.IsImmueToFalling @ "is neither true or false");
		}
	}
	// Unit is hostile civilian
	if(CharacterConfig.IsHostileCivilian != '')
	{
		if(CharacterConfig.IsHostileCivilian == 'TRUE')
		{
			CharacterTemplate.bIsHostileCivilian = true;
			`RU_Log(CharacterTemplate.DataName @ "is hostile civilian");
		}
		else if(CharacterConfig.IsHostileCivilian == 'FALSE')
		{
			CharacterTemplate.bIsHostileCivilian = false;
			`RU_Log(CharacterTemplate.DataName @ "is not hostile civilian");
		}
		else
		{
			`RU_Log(CharacterConfig.IsHostileCivilian @ "is neither true or false");
		}
	}
	// Unit is civilian
	if(CharacterConfig.IsCivilian != '')
	{
		if(CharacterConfig.IsCivilian == 'TRUE')
		{
			CharacterTemplate.bIsCivilian = true;
			`RU_Log(CharacterTemplate.DataName @ "is civilian");
		}
		else if(CharacterConfig.IsCivilian == 'FALSE')
		{
			CharacterTemplate.bIsCivilian = false;
			`RU_Log(CharacterTemplate.DataName @ "is not civilian");
		}
		else
		{
			`RU_Log(CharacterConfig.IsCivilian @ "is neither true or false");
		}
	}
	// Unit can be carried
	if(CharacterConfig.CanBeCarried != '')
	{
		if(CharacterConfig.CanBeCarried == 'TRUE')
		{
			CharacterTemplate.bCanBeCarried = true;
			`RU_Log(CharacterTemplate.DataName @ "can be carried");
		}
		else if(CharacterConfig.CanBeCarried == 'FALSE')
		{
			CharacterTemplate.bCanBeCarried = false;
			`RU_Log(CharacterTemplate.DataName @ "cannot be carried");
		}
		else
		{
			`RU_Log(CharacterConfig.CanBeCarried @ "is neither true or false");
		}
	}
	// Unit is afraid of fire
	if(CharacterConfig.IsAfraidOfFire != '')
	{
		if(CharacterConfig.IsAfraidOfFire == 'TRUE')
		{
			CharacterTemplate.bIsAfraidOfFire = true;
			`RU_Log(CharacterTemplate.DataName @ "is afraid of fire");
		}
		else if(CharacterConfig.IsAfraidOfFire == 'FALSE')
		{
			CharacterTemplate.bIsAfraidOfFire = false;
			`RU_Log(CharacterTemplate.DataName @ "is not afraid of fire");
		}
		else
		{
			`RU_Log(CharacterConfig.IsAfraidOfFire @ "is neither true or false");
		}
	}
	// Unit can take cover
	if(CharacterConfig.CanTakeCover != '')
	{
		if(CharacterConfig.CanTakeCover == 'TRUE')
		{
			CharacterTemplate.bCanTakeCover = true;
			`RU_Log(CharacterTemplate.DataName @ "can take cover");
		}
		else if(CharacterConfig.CanTakeCover == 'FALSE')
		{
			CharacterTemplate.bCanTakeCover = false;
			`RU_Log(CharacterTemplate.DataName @ "cannot take cover");
		}
		else
		{
			`RU_Log(CharacterConfig.CanTakeCover @ "is neither true or false");
		}
	}
	// Unit wears armor in base
	if(CharacterConfig.WearArmorInBase != '')
	{
		if(CharacterConfig.WearArmorInBase == 'TRUE')
		{
			CharacterTemplate.bWearArmorInBase = true;
			`RU_Log(CharacterTemplate.DataName @ "wears armor in base");
		}
		else if(CharacterConfig.WearArmorInBase == 'FALSE')
		{
			CharacterTemplate.bWearArmorInBase = false;
			`RU_Log(CharacterTemplate.DataName @ "doesn't wear armor in base");
		}
		else
		{
			`RU_Log(CharacterConfig.WearArmorInBase @ "is neither true or false");
		}
	}
	// Unit is Humanoid
	if(CharacterConfig.IsHumanoid != '')
	{
		if(CharacterConfig.IsHumanoid == 'TRUE')
		{
			CharacterTemplate.bIsHumanoid = true;
			`RU_Log(CharacterTemplate.DataName @ "wears armor in base");
		}
		else if(CharacterConfig.IsHumanoid == 'FALSE')
		{
			CharacterTemplate.bIsHumanoid = false;
			`RU_Log(CharacterTemplate.DataName @ "doesn't wear armor in base");
		}
		else
		{
			`RU_Log(CharacterConfig.IsHumanoid @ "is neither true or false");
		}
	}
	// Unit is Alien
	if(CharacterConfig.IsAlien != '')
	{
		if(CharacterConfig.IsAlien == 'TRUE')
		{
			CharacterTemplate.bIsAlien = true;
			`RU_Log(CharacterTemplate.DataName @ "wears armor in base");
		}
		else if(CharacterConfig.IsAlien == 'FALSE')
		{
			CharacterTemplate.bIsAlien = false;
			`RU_Log(CharacterTemplate.DataName @ "doesn't wear armor in base");
		}
		else
		{
			`RU_Log(CharacterConfig.IsAlien @ "is neither true or false");
		}
	}
	if(CharacterConfig.GroupName != '')
	{
		CharacterTemplate.CharacterGroupName = CharacterConfig.GroupName;
	}

	if(CharacterConfig.StatModifiers.Length != 0)
	{
		ManageStats(CharacterTemplate, CharacterConfig);
	}
}

static function ManageStats(X2CharacterTemplate CharacterTemplate, CharacterNames CharacterConfig)
{
	local StatOperations StatOperation;
	local int NewStatValue;

	foreach CharacterConfig.StatModifiers(StatOperation)
	{
		if(StatOperation.Set != 0)
		{
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = StatOperation.Set;
			`RU_Log(CharacterTemplate.DataName @ "now have" @ CharacterTemplate.CharacterBaseStats[StatOperation.Stat] @ StatOperation.Stat);
		}
		if(StatOperation.Add != 0)
		{
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = CharacterTemplate.CharacterBaseStats[StatOperation.Stat] + StatOperation.Add;
			`RU_Log(CharacterTemplate.DataName @ "now have" @ CharacterTemplate.CharacterBaseStats[StatOperation.Stat] @ StatOperation.Stat);
		}
		if(StatOperation.Substract != 0)
		{
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = CharacterTemplate.CharacterBaseStats[StatOperation.Stat] - StatOperation.Substract;
			`RU_Log(CharacterTemplate.DataName @ "now have" @ CharacterTemplate.CharacterBaseStats[StatOperation.Stat] @ StatOperation.Stat);
		}
		if(StatOperation.MultiplyBy != 0)
		{
			NewStatValue = int(CharacterTemplate.CharacterBaseStats[StatOperation.Stat] * StatOperation.MultiplyBy);
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = NewStatValue;
			`RU_Log(CharacterTemplate.DataName @ "now have" @ NewStatValue @ StatOperation.Stat);
		}
		if(StatOperation.DivideBy != 0)
		{
			NewStatValue = int(CharacterTemplate.CharacterBaseStats[StatOperation.Stat] / StatOperation.DivideBy);
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = NewStatValue;
			`RU_Log(CharacterTemplate.DataName @ "now have" @ NewStatValue @ StatOperation.Stat);
		}
		if(StatOperation.PercentOf.Length != 0)
		{
			NewStatValue = int(CharacterTemplate.CharacterBaseStats[StatOperation.Stat] + CharacterTemplate.CharacterBaseStats[StatOperation.PercentOf[0].StatRef] * StatOperation.PercentOf[0].PercentValue);
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = NewStatValue;
			`RU_Log(CharacterTemplate.DataName @ "now have" @ NewStatValue @ StatOperation.Stat);
		}
	}
}