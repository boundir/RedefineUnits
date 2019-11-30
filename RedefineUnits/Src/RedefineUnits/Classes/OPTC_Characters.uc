class OPTC_Characters extends X2DownloadableContentInfo config(RedefineUnits);

`define RU_Log(msg) `Log(`msg,, 'RedefineUnits')

struct StatReferenced
{
	var ECharStatType StatRef;
	var float PercentValue;
};

struct StatOperations
{
	var ECharStatType Stat;
	var int Add;
	var int Substract;
	var float MultiplyBy;
	var float DivideBy;
	var int Set;
	var array<StatReferenced> PercentOf;
};

struct CharacterNames
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
	var Name IsHumanoid;
	var Name IsAlien;
	var Name GroupName;
	var array<StatOperations> StatModifiers;
	// TODO
	var Name DefaultLoadout;
	var Name bCanUse_eTraversal_Phasing;
	var Name strBehaviorTree;
	var Name strScamperBT;
	var Int AIOrderPriority;
};

var config array<CharacterNames> Characters;

static event OnPostTemplatesCreated()
{
	`RU_Log("Redefine Units loaded");

	PatchCharacterTemplates();
}


static function PatchCharacterTemplates()
{
	local X2CharacterTemplateManager CharacterMgr;
	local X2CharacterTemplate CharacterTemplate;
	local array<X2DataTemplate> TemplateAllDifficulties;
	local int ScanTemplates, ScanGroup, ScanCharacter;
	local array<name> AllTemplateNames;
	local name TemplateName;

	CharacterMgr = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();
	
	CharacterMgr.GetTemplateNames(AllTemplateNames);

	foreach AllTemplateNames(TemplateName)
	{
		CharacterMgr.FindDataTemplateAllDifficulties(TemplateName, TemplateAllDifficulties);

		for ( ScanTemplates = 0; ScanTemplates < TemplateAllDifficulties.Length; ++ScanTemplates )
		{
			CharacterTemplate = X2CharacterTemplate(TemplateAllDifficulties[ScanTemplates]);
			if (CharacterTemplate != none)
			{
				ScanGroup = default.Characters.Find('GroupName', CharacterTemplate.CharacterGroupName);
				if (ScanGroup != INDEX_NONE && default.Characters[ScanGroup].GroupName != '')
				{
					class'RU_Helpers'.static.ModifyTemplate(CharacterTemplate, default.Characters[ScanGroup]);
				}
				ScanCharacter = default.Characters.Find('TemplateName', CharacterTemplate.DataName);
				if (ScanCharacter != INDEX_NONE && default.Characters[ScanCharacter].TemplateName != '')
				{
					class'RU_Helpers'.static.ModifyTemplate(CharacterTemplate, default.Characters[ScanCharacter]);
				}
			}
		}
	}
}