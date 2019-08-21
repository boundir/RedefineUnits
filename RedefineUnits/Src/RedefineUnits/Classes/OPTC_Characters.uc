class OPTC_Characters extends X2DownloadableContentInfo config(RedefineUnits);

struct native CharacterNames
{
	var Name TemplateName;
	var Name IsPsionic;
	var Name IsRobotic;
	var Name IsWeakToBluescreen;
	var Name IsHiddenFromShadowChamber;
	var Name IsImmueToFalling;
	var Name IsHostileCivilian;
	var Name IsCivilian;
	var Name CanBeCarried;
	var Name IsAfraidOfFire;
	var Name CanTakeCover;
	var Name WearArmorInBase;
};

var config array<CharacterNames> Characters;

static event OnPostTemplatesCreated()
{
	local X2CharacterTemplateManager CharacterMgr;
	local array<X2DataTemplate> TemplateAllDifficulties;
	local X2DataTemplate Template;
	local X2CharacterTemplate CharacterTemplate;

	local CharacterNames CharacterConfig;

	`LOG("Redefine Units loaded");

	CharacterMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

	foreach default.Characters(CharacterConfig)
	{
		CharacterMgr.FindDataTemplateAllDifficulties(CharacterConfig.TemplateName, TemplateAllDifficulties);

		foreach TemplateAllDifficulties(Template)
		{
			CharacterTemplate = X2CharacterTemplate(Template);

			if (CharacterTemplate != none)
			{
				// Psionic Unit
				if(CharacterConfig.IsPsionic != '')
				{
					if(CharacterConfig.IsPsionic == 'TRUE')
					{
						CharacterTemplate.bIsPsionic = true;
						`LOG(CharacterConfig.TemplateName @ "is Psionic", ,'Redefine Units');
					}
					else if(CharacterConfig.IsPsionic == 'FALSE')
					{
						CharacterTemplate.bIsPsionic = false;
						`LOG(CharacterConfig.TemplateName @ "is not Psionic", ,'Redefine Units');
					}
					else
					{
						`LOG(CharacterConfig.IsPsionic @ "is neither true or false", ,'Redefine Units');
					}
				}
				// Robotic Unit
				if(CharacterConfig.IsRobotic != '')
				{
					if(CharacterConfig.IsRobotic == 'TRUE')
					{
						CharacterTemplate.bIsRobotic = true;
						`LOG(CharacterConfig.TemplateName @ "is Robotic", ,'Redefine Units');
					}
					else if(CharacterConfig.IsRobotic == 'FALSE')
					{
						CharacterTemplate.bIsRobotic = false;
						`LOG(CharacterConfig.TemplateName @ "is not Robotic", ,'Redefine Units');
					}
					else
					{
						`LOG(CharacterConfig.IsRobotic @ "is neither true or false", ,'Redefine Units');
					}
				}
				// Unit takes bluescreen rounds effect
				if(CharacterConfig.IsWeakToBluescreen != '')
				{
					if(CharacterConfig.IsWeakToBluescreen == 'TRUE')
					{
						CharacterTemplate.bWeakAgainstTechLikeRobot = true;
						`LOG(CharacterConfig.TemplateName @ "is weak to bluescreen rounds", ,'Redefine Units');
					}
					else if(CharacterConfig.IsWeakToBluescreen == 'FALSE')
					{
						CharacterTemplate.bWeakAgainstTechLikeRobot = false;
						`LOG(CharacterConfig.TemplateName @ "is not weak to bluescreen rounds", ,'Redefine Units');
					}
					else
					{
						`LOG(CharacterConfig.IsWeakToBluescreen @ "is neither true or false", ,'Redefine Units');
					}
				}
				// Unit is hidden from Shadow Chamber
				if(CharacterConfig.IsHiddenFromShadowChamber != '')
				{
					if(CharacterConfig.IsHiddenFromShadowChamber == 'TRUE')
					{
						CharacterTemplate.bHideInShadowChamber = true;
						`LOG(CharacterConfig.TemplateName @ "is hidden from Shadow Chamber", ,'Redefine Units');
					}
					else if(CharacterConfig.IsHiddenFromShadowChamber == 'FALSE')
					{
						CharacterTemplate.bHideInShadowChamber = false;
						`LOG(CharacterConfig.TemplateName @ "is not hidden from Shadow Chamber", ,'Redefine Units');
					}
					else
					{
						`LOG(CharacterConfig.IsHiddenFromShadowChamber @ "is neither true or false", ,'Redefine Units');
					}
				}
				// Unit doesn't take damage from falling
				if(CharacterConfig.IsImmueToFalling != '')
				{
					if(CharacterConfig.IsImmueToFalling == 'TRUE')
					{
						CharacterTemplate.bImmueToFalling = true;
						`LOG(CharacterConfig.TemplateName @ "is immune to falling", ,'Redefine Units');
					}
					else if(CharacterConfig.IsImmueToFalling == 'FALSE')
					{
						CharacterTemplate.bImmueToFalling = false;
						`LOG(CharacterConfig.TemplateName @ "is not immune to falling", ,'Redefine Units');
					}
					else
					{
						`LOG(CharacterConfig.IsImmueToFalling @ "is neither true or false", ,'Redefine Units');
					}
				}
				// Unit is hostile civilian
				if(CharacterConfig.IsHostileCivilian != '')
				{
					if(CharacterConfig.IsHostileCivilian == 'TRUE')
					{
						CharacterTemplate.bIsHostileCivilian = true;
						`LOG(CharacterConfig.TemplateName @ "is hostile civilian", ,'Redefine Units');
					}
					else if(CharacterConfig.IsHostileCivilian == 'FALSE')
					{
						CharacterTemplate.bIsHostileCivilian = false;
						`LOG(CharacterConfig.TemplateName @ "is not hostile civilian", ,'Redefine Units');
					}
					else
					{
						`LOG(CharacterConfig.IsHostileCivilian @ "is neither true or false", ,'Redefine Units');
					}
				}
				// Unit is civilian
				if(CharacterConfig.IsCivilian != '')
				{
					if(CharacterConfig.IsCivilian == 'TRUE')
					{
						CharacterTemplate.bIsCivilian = true;
						`LOG(CharacterConfig.TemplateName @ "is civilian", ,'Redefine Units');
					}
					else if(CharacterConfig.IsCivilian == 'FALSE')
					{
						CharacterTemplate.bIsCivilian = false;
						`LOG(CharacterConfig.TemplateName @ "is not civilian", ,'Redefine Units');
					}
					else
					{
						`LOG(CharacterConfig.IsCivilian @ "is neither true or false", ,'Redefine Units');
					}
				}
				// Unit can be carried
				if(CharacterConfig.CanBeCarried != '')
				{
					if(CharacterConfig.CanBeCarried == 'TRUE')
					{
						CharacterTemplate.bCanBeCarried = true;
						`LOG(CharacterConfig.TemplateName @ "can be carried", ,'Redefine Units');
					}
					else if(CharacterConfig.CanBeCarried == 'FALSE')
					{
						CharacterTemplate.bCanBeCarried = false;
						`LOG(CharacterConfig.TemplateName @ "cannot be carried", ,'Redefine Units');
					}
					else
					{
						`LOG(CharacterConfig.CanBeCarried @ "is neither true or false", ,'Redefine Units');
					}
				}
				// Unit is afraid of fire
				if(CharacterConfig.IsAfraidOfFire != '')
				{
					if(CharacterConfig.IsAfraidOfFire == 'TRUE')
					{
						CharacterTemplate.bIsAfraidOfFire = true;
						`LOG(CharacterConfig.TemplateName @ "is afraid of fire", ,'Redefine Units');
					}
					else if(CharacterConfig.IsAfraidOfFire == 'FALSE')
					{
						CharacterTemplate.bIsAfraidOfFire = false;
						`LOG(CharacterConfig.TemplateName @ "is not afraid of fire", ,'Redefine Units');
					}
					else
					{
						`LOG(CharacterConfig.IsAfraidOfFire @ "is neither true or false", ,'Redefine Units');
					}
				}
				// Unit can take cover
				if(CharacterConfig.CanTakeCover != '')
				{
					if(CharacterConfig.CanTakeCover == 'TRUE')
					{
						CharacterTemplate.bCanTakeCover = true;
						`LOG(CharacterConfig.TemplateName @ "can take cover", ,'Redefine Units');
					}
					else if(CharacterConfig.CanTakeCover == 'FALSE')
					{
						CharacterTemplate.bCanTakeCover = false;
						`LOG(CharacterConfig.TemplateName @ "cannot take cover", ,'Redefine Units');
					}
					else
					{
						`LOG(CharacterConfig.CanTakeCover @ "is neither true or false", ,'Redefine Units');
					}
				}
				// Unit wears armor in base
				if(CharacterConfig.WearArmorInBase != '')
				{
					if(CharacterConfig.WearArmorInBase == 'TRUE')
					{
						CharacterTemplate.bWearArmorInBase = true;
						`LOG(CharacterConfig.TemplateName @ "wears armor in base", ,'Redefine Units');
					}
					else if(CharacterConfig.WearArmorInBase == 'FALSE')
					{
						CharacterTemplate.bWearArmorInBase = false;
						`LOG(CharacterConfig.TemplateName @ "doesn't wear armor in base", ,'Redefine Units');
					}
					else
					{
						`LOG(CharacterConfig.WearArmorInBase @ "is neither true or false", ,'Redefine Units');
					}
				}
			}
		}
	}
}