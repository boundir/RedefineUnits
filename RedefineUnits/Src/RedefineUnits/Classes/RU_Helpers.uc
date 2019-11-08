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
			`RU_Log(CharacterTemplate.DataName @ "is Psionic", ,'Redefine Units');
		}
		else if(CharacterConfig.IsPsionic == 'FALSE')
		{
			CharacterTemplate.bIsPsionic = false;
			`RU_Log(CharacterTemplate.DataName @ "is not Psionic", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.IsPsionic @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Robotic Unit
	if(CharacterConfig.IsRobotic != '')
	{
		if(CharacterConfig.IsRobotic == 'TRUE')
		{
			CharacterTemplate.bIsRobotic = true;
			`RU_Log(CharacterTemplate.DataName @ "is Robotic", ,'Redefine Units');
		}
		else if(CharacterConfig.IsRobotic == 'FALSE')
		{
			CharacterTemplate.bIsRobotic = false;
			`RU_Log(CharacterTemplate.DataName @ "is not Robotic", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.IsRobotic @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Unit takes bluescreen rounds effect
	if(CharacterConfig.IsWeakToBluescreen != '')
	{
		if(CharacterConfig.IsWeakToBluescreen == 'TRUE')
		{
			CharacterTemplate.bWeakAgainstTechLikeRobot = true;
			`RU_Log(CharacterTemplate.DataName @ "is weak to bluescreen rounds", ,'Redefine Units');
		}
		else if(CharacterConfig.IsWeakToBluescreen == 'FALSE')
		{
			CharacterTemplate.bWeakAgainstTechLikeRobot = false;
			`RU_Log(CharacterTemplate.DataName @ "is not weak to bluescreen rounds", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.IsWeakToBluescreen @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Unit is hidden from Shadow Chamber
	if(CharacterConfig.IsHiddenFromShadowChamber != '')
	{
		if(CharacterConfig.IsHiddenFromShadowChamber == 'TRUE')
		{
			CharacterTemplate.bHideInShadowChamber = true;
			`RU_Log(CharacterTemplate.DataName @ "is hidden from Shadow Chamber", ,'Redefine Units');
		}
		else if(CharacterConfig.IsHiddenFromShadowChamber == 'FALSE')
		{
			CharacterTemplate.bHideInShadowChamber = false;
			`RU_Log(CharacterTemplate.DataName @ "is not hidden from Shadow Chamber", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.IsHiddenFromShadowChamber @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Unit doesn't take damage from falling
	if(CharacterConfig.IsImmueToFalling != '')
	{
		if(CharacterConfig.IsImmueToFalling == 'TRUE')
		{
			CharacterTemplate.bImmueToFalling = true;
			`RU_Log(CharacterTemplate.DataName @ "is immune to falling", ,'Redefine Units');
		}
		else if(CharacterConfig.IsImmueToFalling == 'FALSE')
		{
			CharacterTemplate.bImmueToFalling = false;
			`RU_Log(CharacterTemplate.DataName @ "is not immune to falling", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.IsImmueToFalling @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Unit is hostile civilian
	if(CharacterConfig.IsHostileCivilian != '')
	{
		if(CharacterConfig.IsHostileCivilian == 'TRUE')
		{
			CharacterTemplate.bIsHostileCivilian = true;
			`RU_Log(CharacterTemplate.DataName @ "is hostile civilian", ,'Redefine Units');
		}
		else if(CharacterConfig.IsHostileCivilian == 'FALSE')
		{
			CharacterTemplate.bIsHostileCivilian = false;
			`RU_Log(CharacterTemplate.DataName @ "is not hostile civilian", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.IsHostileCivilian @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Unit is civilian
	if(CharacterConfig.IsCivilian != '')
	{
		if(CharacterConfig.IsCivilian == 'TRUE')
		{
			CharacterTemplate.bIsCivilian = true;
			`RU_Log(CharacterTemplate.DataName @ "is civilian", ,'Redefine Units');
		}
		else if(CharacterConfig.IsCivilian == 'FALSE')
		{
			CharacterTemplate.bIsCivilian = false;
			`RU_Log(CharacterTemplate.DataName @ "is not civilian", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.IsCivilian @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Unit can be carried
	if(CharacterConfig.CanBeCarried != '')
	{
		if(CharacterConfig.CanBeCarried == 'TRUE')
		{
			CharacterTemplate.bCanBeCarried = true;
			`RU_Log(CharacterTemplate.DataName @ "can be carried", ,'Redefine Units');
		}
		else if(CharacterConfig.CanBeCarried == 'FALSE')
		{
			CharacterTemplate.bCanBeCarried = false;
			`RU_Log(CharacterTemplate.DataName @ "cannot be carried", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.CanBeCarried @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Unit is afraid of fire
	if(CharacterConfig.IsAfraidOfFire != '')
	{
		if(CharacterConfig.IsAfraidOfFire == 'TRUE')
		{
			CharacterTemplate.bIsAfraidOfFire = true;
			`RU_Log(CharacterTemplate.DataName @ "is afraid of fire", ,'Redefine Units');
		}
		else if(CharacterConfig.IsAfraidOfFire == 'FALSE')
		{
			CharacterTemplate.bIsAfraidOfFire = false;
			`RU_Log(CharacterTemplate.DataName @ "is not afraid of fire", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.IsAfraidOfFire @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Unit can take cover
	if(CharacterConfig.CanTakeCover != '')
	{
		if(CharacterConfig.CanTakeCover == 'TRUE')
		{
			CharacterTemplate.bCanTakeCover = true;
			`RU_Log(CharacterTemplate.DataName @ "can take cover", ,'Redefine Units');
		}
		else if(CharacterConfig.CanTakeCover == 'FALSE')
		{
			CharacterTemplate.bCanTakeCover = false;
			`RU_Log(CharacterTemplate.DataName @ "cannot take cover", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.CanTakeCover @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Unit wears armor in base
	if(CharacterConfig.WearArmorInBase != '')
	{
		if(CharacterConfig.WearArmorInBase == 'TRUE')
		{
			CharacterTemplate.bWearArmorInBase = true;
			`RU_Log(CharacterTemplate.DataName @ "wears armor in base", ,'Redefine Units');
		}
		else if(CharacterConfig.WearArmorInBase == 'FALSE')
		{
			CharacterTemplate.bWearArmorInBase = false;
			`RU_Log(CharacterTemplate.DataName @ "doesn't wear armor in base", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.WearArmorInBase @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Unit is Humanoid
	if(CharacterConfig.IsHumanoid != '')
	{
		if(CharacterConfig.IsHumanoid == 'TRUE')
		{
			CharacterTemplate.bIsHumanoid = true;
			`RU_Log(CharacterTemplate.DataName @ "wears armor in base", ,'Redefine Units');
		}
		else if(CharacterConfig.IsHumanoid == 'FALSE')
		{
			CharacterTemplate.bIsHumanoid = false;
			`RU_Log(CharacterTemplate.DataName @ "doesn't wear armor in base", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.IsHumanoid @ "is neither true or false", ,'Redefine Units');
		}
	}
	// Unit is Alien
	if(CharacterConfig.IsAlien != '')
	{
		if(CharacterConfig.IsAlien == 'TRUE')
		{
			CharacterTemplate.bIsAlien = true;
			`RU_Log(CharacterTemplate.DataName @ "wears armor in base", ,'Redefine Units');
		}
		else if(CharacterConfig.IsAlien == 'FALSE')
		{
			CharacterTemplate.bIsAlien = false;
			`RU_Log(CharacterTemplate.DataName @ "doesn't wear armor in base", ,'Redefine Units');
		}
		else
		{
			`RU_Log(CharacterConfig.IsAlien @ "is neither true or false", ,'Redefine Units');
		}
	}
	if(CharacterConfig.GroupName != '')
	{
		CharacterTemplate.CharacterGroupName = CharacterConfig.GroupName;
	}
}