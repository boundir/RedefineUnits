class OPTC_Characters extends X2DownloadableContentInfo config(RedefineUnits);

struct native CharacterNames
{
	var Name TemplateName;
	var Name IsPsionic;
	var Name IsRobotic;
	var Name IsWeakToBluescreen;
	var Name IsHiddenFromShadowChamber;
	var Name IsImmueToFalling;
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
			}
		}
	}
}