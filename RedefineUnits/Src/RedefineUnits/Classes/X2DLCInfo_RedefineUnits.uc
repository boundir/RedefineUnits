class X2DLCInfo_RedefineUnits extends X2DownloadableContentInfo config(RedefineUnits);

struct StatRandomizations
{
	var ECharStatType Stat;
	var int BaseStat;
	var int RandAmount;
	var int Cap;

	structdefaultproperties
	{
		Stat = eStat_Invalid;
		BaseStat = -100;
		RandAmount = -100;
		Cap = -100;
	}
};

struct StatReferenced
{
	var ECharStatType StatRef;
	var float PercentValue;

	structdefaultproperties
	{
		StatRef = eStat_Invalid;
	}
};

struct StatOperations
{
	var ECharStatType Stat;
	var int Add;
	var int Substract;
	var float MultiplyBy;
	var float DivideBy;
	var int Set;
	var StatReferenced PercentOf;
};

struct PrimitiveRedefinition
{
	var name Property;
	var string Value;
};

struct PrimitiveArrayRedefinition
{
	var name Property;
	var array<string> Add;
	var array<string> Remove;
	var array<string> Replace;
};

struct CharacterDefinition
{
	// Selector

	var name CharacterName;
	var name GroupName;
	var name ClassName;

	// Primitive handling

	var array<PrimitiveRedefinition> PropertyEdition;
	var array<PrimitiveArrayRedefinition> ArrayPropertyEdition;

	// Special handling

	var array<StatOperations> StatEdition;
	var array<StatRandomizations> StatRandomizer;
};

var config(Engine) bool EnableLogs;
var config array<CharacterDefinition> RedefineUnit;
var array<Name> UnitExclusions;

static private function X2DLCInfo_RedefineUnits GetClassDefaultObject()
{
	return X2DLCInfo_RedefineUnits(class'XComEngine'.static.GetClassDefaultObjectByName(default.Class.Name));
}

static event OnPostTemplatesCreated()
{
	`Log(`StaticLocation, default.EnableLogs, 'RedefineUnits');

	RedefineUnits();
}

static function RedefineUnits()
{
	local X2CharacterTemplateManager CharacterManager;
	local X2CharacterTemplate CharacterTemplate;
	local array<X2DataTemplate> TemplateAllDifficulties;
	local X2DataTemplate DataTemplate;
	local array<name> AllTemplateNames;
	local name TemplateName;
	local CharacterDefinition CharacterEdit;
	local int Index;
	local bool ShouldLog;

	CharacterManager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

	CharacterManager.GetTemplateNames(AllTemplateNames);

	foreach AllTemplateNames(TemplateName)
	{
		CharacterManager.FindDataTemplateAllDifficulties(TemplateName, TemplateAllDifficulties);

		foreach TemplateAllDifficulties(DataTemplate, Index)
		{
			CharacterTemplate = X2CharacterTemplate(DataTemplate);

			if (CharacterTemplate == none)
			{
				continue;
			}

			if (default.UnitExclusions.Find(CharacterTemplate.DataName) != INDEX_NONE)
			{
				`Log(CharacterTemplate.DataName @ "is in the exclusion list. Skipping.", default.EnableLogs, 'RedefineUnits');
			}

			ShouldLog = false;

			if (default.EnableLogs && Index == 0)
			{
				ShouldLog = true;
			}

			foreach default.RedefineUnit(CharacterEdit)
			{
				RedefineCharacter(CharacterTemplate, CharacterEdit, Index, ShouldLog);
				RedefineGroup(CharacterTemplate, CharacterEdit, Index, ShouldLog);
				RedefineClass(CharacterTemplate, CharacterEdit, Index, ShouldLog);
			}
		}
	}
}

static function RedefineCharacter(X2CharacterTemplate CharacterTemplate, CharacterDefinition CharacterEdit, int Difficulty, bool ShouldLog)
{
	if (CharacterEdit.CharacterName == '' || CharacterEdit.CharacterName != CharacterTemplate.DataName)
	{
		return;
	}

	ApplyChanges(CharacterTemplate, CharacterEdit, Difficulty, ShouldLog);
}

static function RedefineGroup(X2CharacterTemplate CharacterTemplate, CharacterDefinition CharacterEdit, int Difficulty, bool ShouldLog)
{
	if (CharacterEdit.GroupName == '' || CharacterEdit.GroupName != CharacterTemplate.CharacterGroupName)
	{
		return;
	}

	ApplyChanges(CharacterTemplate, CharacterEdit, Difficulty, ShouldLog);
}

static function RedefineClass(X2CharacterTemplate CharacterTemplate, CharacterDefinition CharacterEdit, int Difficulty, bool ShouldLog)
{
	if (CharacterEdit.ClassName == '' || CharacterEdit.ClassName != CharacterTemplate.DefaultSoldierClass)
	{
		return;
	}

	ApplyChanges(CharacterTemplate, CharacterEdit, Difficulty, ShouldLog);
}

static function ApplyChanges(X2CharacterTemplate CharacterTemplate, CharacterDefinition CharacterEdit, int Difficulty, bool ShouldLog)
{
	local PrimitiveRedefinition Edit;
	local PrimitiveArrayRedefinition EditArray;

	foreach CharacterEdit.PropertyEdition(Edit)
	{
		ApplyPrimitiveChanges(CharacterTemplate, Edit, ShouldLog);
	}

	foreach CharacterEdit.ArrayPropertyEdition(EditArray)
	{
		ApplyPrimitiveArrayChanges(CharacterTemplate, EditArray, ShouldLog);
	}

	ApplyStatsOperationChanges(CharacterTemplate, CharacterEdit, Difficulty, ShouldLog);
	ApplyRandomizedStatsChanges(CharacterTemplate, CharacterEdit, ShouldLog);
}

static function ApplyPrimitiveChanges(X2CharacterTemplate CharacterTemplate, PrimitiveRedefinition Edit, bool ShouldLog)
{
	local string LogHeader;

	LogHeader = "[" $ CharacterTemplate.DataName $ "][" $ Edit.Property $ "]";

	switch (Edit.Property)
	{
		case 'bCanUse_eTraversal_Normal':
			CharacterTemplate.bCanUse_eTraversal_Normal = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_Normal);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_Normal, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_ClimbOver':
			CharacterTemplate.bCanUse_eTraversal_ClimbOver = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_ClimbOver);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_ClimbOver, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_ClimbOnto':
			CharacterTemplate.bCanUse_eTraversal_ClimbOnto = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_ClimbOnto);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_ClimbOnto, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_ClimbLadder':
			CharacterTemplate.bCanUse_eTraversal_ClimbLadder = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_ClimbLadder);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_ClimbLadder, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_DropDown':
			CharacterTemplate.bCanUse_eTraversal_DropDown = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_DropDown);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_DropDown, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_Grapple':
			CharacterTemplate.bCanUse_eTraversal_Grapple = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_Grapple);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_Grapple, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_Landing':
			CharacterTemplate.bCanUse_eTraversal_Landing = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_Landing);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_Landing, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_BreakWindow':
			CharacterTemplate.bCanUse_eTraversal_BreakWindow = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_BreakWindow);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_BreakWindow, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_KickDoor':
			CharacterTemplate.bCanUse_eTraversal_KickDoor = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_KickDoor);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_KickDoor, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_JumpUp':
			CharacterTemplate.bCanUse_eTraversal_JumpUp = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_JumpUp);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_JumpUp, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_WallClimb':
			CharacterTemplate.bCanUse_eTraversal_WallClimb = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_WallClimb);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_WallClimb, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_Phasing':
			CharacterTemplate.bCanUse_eTraversal_Phasing = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_Phasing);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_Phasing, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_BreakWall':
			CharacterTemplate.bCanUse_eTraversal_BreakWall = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_BreakWall);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_BreakWall, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_Launch':
			CharacterTemplate.bCanUse_eTraversal_Launch = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_Launch);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_Launch, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_Flying':
			CharacterTemplate.bCanUse_eTraversal_Flying = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_Flying);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_Flying, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanUse_eTraversal_Land':
			CharacterTemplate.bCanUse_eTraversal_Land = GetConfigBool(Edit.Value, CharacterTemplate.bCanUse_eTraversal_Land);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanUse_eTraversal_Land, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsTooBigForArmory':
			CharacterTemplate.bIsTooBigForArmory = GetConfigBool(Edit.Value, CharacterTemplate.bIsTooBigForArmory);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsTooBigForArmory, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanBeCriticallyWounded':
			CharacterTemplate.bCanBeCriticallyWounded = GetConfigBool(Edit.Value, CharacterTemplate.bCanBeCriticallyWounded);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanBeCriticallyWounded, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanBeCarried':
			CharacterTemplate.bCanBeCarried = GetConfigBool(Edit.Value, CharacterTemplate.bCanBeCarried);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanBeCarried, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanBeRevived':
			CharacterTemplate.bCanBeRevived = GetConfigBool(Edit.Value, CharacterTemplate.bCanBeRevived);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanBeRevived, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanBeTerrorist':
			CharacterTemplate.bCanBeTerrorist = GetConfigBool(Edit.Value, CharacterTemplate.bCanBeTerrorist);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanBeTerrorist, ShouldLog, 'RedefineUnits');
			break;

		case 'bDiesWhenCaptured':
			CharacterTemplate.bDiesWhenCaptured = GetConfigBool(Edit.Value, CharacterTemplate.bDiesWhenCaptured);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bDiesWhenCaptured, ShouldLog, 'RedefineUnits');
			break;

		case 'bAppearanceDefinesPawn':
			CharacterTemplate.bAppearanceDefinesPawn = GetConfigBool(Edit.Value, CharacterTemplate.bAppearanceDefinesPawn);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bAppearanceDefinesPawn, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsAfraidOfFire':
			CharacterTemplate.bIsAfraidOfFire = GetConfigBool(Edit.Value, CharacterTemplate.bIsAfraidOfFire);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsAfraidOfFire, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsAlien':
			CharacterTemplate.bIsAlien = GetConfigBool(Edit.Value, CharacterTemplate.bIsAlien);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsAlien, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsHumanoid':
			CharacterTemplate.bIsHumanoid = GetConfigBool(Edit.Value, CharacterTemplate.bIsHumanoid);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsHumanoid, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsAdvent':
			CharacterTemplate.bIsAdvent = GetConfigBool(Edit.Value, CharacterTemplate.bIsAdvent);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsAdvent, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsCivilian':
			CharacterTemplate.bIsCivilian = GetConfigBool(Edit.Value, CharacterTemplate.bIsCivilian);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsCivilian, ShouldLog, 'RedefineUnits');
			break;

		case 'bDisplayUIUnitFlag':
			CharacterTemplate.bDisplayUIUnitFlag = GetConfigBool(Edit.Value, CharacterTemplate.bDisplayUIUnitFlag);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bDisplayUIUnitFlag, ShouldLog, 'RedefineUnits');
			break;

		case 'bNeverSelectable':
			CharacterTemplate.bNeverSelectable = GetConfigBool(Edit.Value, CharacterTemplate.bNeverSelectable);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bNeverSelectable, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsHostileCivilian':
			CharacterTemplate.bIsHostileCivilian = GetConfigBool(Edit.Value, CharacterTemplate.bIsHostileCivilian);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsHostileCivilian, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsPsionic':
			CharacterTemplate.bIsPsionic = GetConfigBool(Edit.Value, CharacterTemplate.bIsPsionic);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsPsionic, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsRobotic':
			CharacterTemplate.bIsRobotic = GetConfigBool(Edit.Value, CharacterTemplate.bIsRobotic);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsRobotic, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsSoldier':
			CharacterTemplate.bIsSoldier = GetConfigBool(Edit.Value, CharacterTemplate.bIsSoldier);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsSoldier, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsCosmetic':
			CharacterTemplate.bIsCosmetic = GetConfigBool(Edit.Value, CharacterTemplate.bIsCosmetic);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsCosmetic, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsTurret':
			CharacterTemplate.bIsTurret = GetConfigBool(Edit.Value, CharacterTemplate.bIsTurret);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsTurret, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsChosen':
			CharacterTemplate.bIsChosen = GetConfigBool(Edit.Value, CharacterTemplate.bIsChosen);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsChosen, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanTakeCover':
			CharacterTemplate.bCanTakeCover = GetConfigBool(Edit.Value, CharacterTemplate.bCanTakeCover);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanTakeCover, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsExalt':
			CharacterTemplate.bIsExalt = GetConfigBool(Edit.Value, CharacterTemplate.bIsExalt);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsExalt, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsEliteExalt':
			CharacterTemplate.bIsEliteExalt = GetConfigBool(Edit.Value, CharacterTemplate.bIsEliteExalt);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsEliteExalt, ShouldLog, 'RedefineUnits');
			break;

		case 'bSkipDefaultAbilities':
			CharacterTemplate.bSkipDefaultAbilities = GetConfigBool(Edit.Value, CharacterTemplate.bSkipDefaultAbilities);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bSkipDefaultAbilities, ShouldLog, 'RedefineUnits');
			break;

		case 'bDoesNotScamper':
			CharacterTemplate.bDoesNotScamper = GetConfigBool(Edit.Value, CharacterTemplate.bDoesNotScamper);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bDoesNotScamper, ShouldLog, 'RedefineUnits');
			break;

		case 'bDoesAlwaysFly':
			CharacterTemplate.bDoesAlwaysFly = GetConfigBool(Edit.Value, CharacterTemplate.bDoesAlwaysFly);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bDoesAlwaysFly, ShouldLog, 'RedefineUnits');
			break;

		case 'bAllowSpawnInFire':
			CharacterTemplate.bAllowSpawnInFire = GetConfigBool(Edit.Value, CharacterTemplate.bAllowSpawnInFire);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bAllowSpawnInFire, ShouldLog, 'RedefineUnits');
			break;

		case 'bAllowSpawnInPoison':
			CharacterTemplate.bAllowSpawnInPoison = GetConfigBool(Edit.Value, CharacterTemplate.bAllowSpawnInPoison);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bAllowSpawnInPoison, ShouldLog, 'RedefineUnits');
			break;

		case 'bAllowSpawnFromATT':
			CharacterTemplate.bAllowSpawnFromATT = GetConfigBool(Edit.Value, CharacterTemplate.bAllowSpawnFromATT);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bAllowSpawnFromATT, ShouldLog, 'RedefineUnits');
			break;

		case 'bFacesAwayFromPod':
			CharacterTemplate.bFacesAwayFromPod = GetConfigBool(Edit.Value, CharacterTemplate.bFacesAwayFromPod);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bFacesAwayFromPod, ShouldLog, 'RedefineUnits');
			break;

		case 'bLockdownPodIdleUntilReveal':
			CharacterTemplate.bLockdownPodIdleUntilReveal = GetConfigBool(Edit.Value, CharacterTemplate.bLockdownPodIdleUntilReveal);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bLockdownPodIdleUntilReveal, ShouldLog, 'RedefineUnits');
			break;

		case 'bWeakAgainstTechLikeRobot':
			CharacterTemplate.bWeakAgainstTechLikeRobot = GetConfigBool(Edit.Value, CharacterTemplate.bWeakAgainstTechLikeRobot);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bWeakAgainstTechLikeRobot, ShouldLog, 'RedefineUnits');
			break;

		case 'bUsesWillSystem':
			CharacterTemplate.bUsesWillSystem = GetConfigBool(Edit.Value, CharacterTemplate.bUsesWillSystem);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bUsesWillSystem, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsMeleeOnly':
			CharacterTemplate.bIsMeleeOnly = GetConfigBool(Edit.Value, CharacterTemplate.bIsMeleeOnly);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsMeleeOnly, ShouldLog, 'RedefineUnits');
			break;

		case 'bUsePoolSoldiers':
			CharacterTemplate.bUsePoolSoldiers = GetConfigBool(Edit.Value, CharacterTemplate.bUsePoolSoldiers);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bUsePoolSoldiers, ShouldLog, 'RedefineUnits');
			break;

		case 'bUsePoolVIPs':
			CharacterTemplate.bUsePoolVIPs = GetConfigBool(Edit.Value, CharacterTemplate.bUsePoolVIPs);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bUsePoolVIPs, ShouldLog, 'RedefineUnits');
			break;

		case 'bUsePoolDarkVIPs':
			CharacterTemplate.bUsePoolDarkVIPs = GetConfigBool(Edit.Value, CharacterTemplate.bUsePoolDarkVIPs);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bUsePoolDarkVIPs, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsScientist':
			CharacterTemplate.bIsScientist = GetConfigBool(Edit.Value, CharacterTemplate.bIsScientist);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsScientist, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsEngineer':
			CharacterTemplate.bIsEngineer = GetConfigBool(Edit.Value, CharacterTemplate.bIsEngineer);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsEngineer, ShouldLog, 'RedefineUnits');
			break;

		case 'bStaffingAllowed':
			CharacterTemplate.bStaffingAllowed = GetConfigBool(Edit.Value, CharacterTemplate.bStaffingAllowed);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bStaffingAllowed, ShouldLog, 'RedefineUnits');
			break;

		case 'bAppearInBase':
			CharacterTemplate.bAppearInBase = GetConfigBool(Edit.Value, CharacterTemplate.bAppearInBase);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bAppearInBase, ShouldLog, 'RedefineUnits');
			break;

		case 'bWearArmorInBase':
			CharacterTemplate.bWearArmorInBase = GetConfigBool(Edit.Value, CharacterTemplate.bWearArmorInBase);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bWearArmorInBase, ShouldLog, 'RedefineUnits');
			break;

		case 'bBlocksPathingWhenDead':
			CharacterTemplate.bBlocksPathingWhenDead = GetConfigBool(Edit.Value, CharacterTemplate.bBlocksPathingWhenDead);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bBlocksPathingWhenDead, ShouldLog, 'RedefineUnits');
			break;

		case 'bCanTickEffectsEveryAction':
			CharacterTemplate.bCanTickEffectsEveryAction = GetConfigBool(Edit.Value, CharacterTemplate.bCanTickEffectsEveryAction);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bCanTickEffectsEveryAction, ShouldLog, 'RedefineUnits');
			break;

		case 'bManualCooldownTick':
			CharacterTemplate.bManualCooldownTick = GetConfigBool(Edit.Value, CharacterTemplate.bManualCooldownTick);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bManualCooldownTick, ShouldLog, 'RedefineUnits');
			break;

		case 'bHideInShadowChamber':
			CharacterTemplate.bHideInShadowChamber = GetConfigBool(Edit.Value, CharacterTemplate.bHideInShadowChamber);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bHideInShadowChamber, ShouldLog, 'RedefineUnits');
			break;

		case 'bDontClearRemovedFromPlay':
			CharacterTemplate.bDontClearRemovedFromPlay = GetConfigBool(Edit.Value, CharacterTemplate.bDontClearRemovedFromPlay);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bDontClearRemovedFromPlay, ShouldLog, 'RedefineUnits');
			break;

		case 'bDontUseOTSTargetingCamera':
			CharacterTemplate.bDontUseOTSTargetingCamera = GetConfigBool(Edit.Value, CharacterTemplate.bDontUseOTSTargetingCamera);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bDontUseOTSTargetingCamera, ShouldLog, 'RedefineUnits');
			break;

		case 'bIsResistanceHero':
			CharacterTemplate.bIsResistanceHero = GetConfigBool(Edit.Value, CharacterTemplate.bIsResistanceHero);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIsResistanceHero, ShouldLog, 'RedefineUnits');
			break;

		case 'bImmueToFalling':
			CharacterTemplate.bImmueToFalling = GetConfigBool(Edit.Value, CharacterTemplate.bImmueToFalling);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bImmueToFalling, ShouldLog, 'RedefineUnits');
			break;

		case 'bRevealMatineeAlwaysValid':
			CharacterTemplate.bRevealMatineeAlwaysValid = GetConfigBool(Edit.Value, CharacterTemplate.bRevealMatineeAlwaysValid);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bRevealMatineeAlwaysValid, ShouldLog, 'RedefineUnits');
			break;

		case 'bDisableRevealLookAtCamera':
			CharacterTemplate.bDisableRevealLookAtCamera = GetConfigBool(Edit.Value, CharacterTemplate.bDisableRevealLookAtCamera);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bDisableRevealLookAtCamera, ShouldLog, 'RedefineUnits');
			break;

		case 'bDisableRevealForceVisible':
			CharacterTemplate.bDisableRevealForceVisible = GetConfigBool(Edit.Value, CharacterTemplate.bDisableRevealForceVisible);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bDisableRevealForceVisible, ShouldLog, 'RedefineUnits');
			break;

		case 'bNeverShowFirstSighted':
			CharacterTemplate.bNeverShowFirstSighted = GetConfigBool(Edit.Value, CharacterTemplate.bNeverShowFirstSighted);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bNeverShowFirstSighted, ShouldLog, 'RedefineUnits');
			break;

		case 'bSetGenderAlways':
			CharacterTemplate.bSetGenderAlways = GetConfigBool(Edit.Value, CharacterTemplate.bSetGenderAlways);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bSetGenderAlways, ShouldLog, 'RedefineUnits');
			break;

		case 'bForceAppearance':
			CharacterTemplate.bForceAppearance = GetConfigBool(Edit.Value, CharacterTemplate.bForceAppearance);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bForceAppearance, ShouldLog, 'RedefineUnits');
			break;

		case 'bHasFullDefaultAppearance':
			CharacterTemplate.bHasFullDefaultAppearance = GetConfigBool(Edit.Value, CharacterTemplate.bHasFullDefaultAppearance);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bHasFullDefaultAppearance, ShouldLog, 'RedefineUnits');
			break;

		case 'bHasCharacterExclusiveAppearance':
			CharacterTemplate.bHasCharacterExclusiveAppearance = GetConfigBool(Edit.Value, CharacterTemplate.bHasCharacterExclusiveAppearance);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bHasCharacterExclusiveAppearance, ShouldLog, 'RedefineUnits');
			break;

		case 'bIgnoreEndTacticalHealthMod':
			CharacterTemplate.bIgnoreEndTacticalHealthMod = GetConfigBool(Edit.Value, CharacterTemplate.bIgnoreEndTacticalHealthMod);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIgnoreEndTacticalHealthMod, ShouldLog, 'RedefineUnits');
			break;

		case 'bIgnoreEndTacticalRestoreArmor':
			CharacterTemplate.bIgnoreEndTacticalRestoreArmor = GetConfigBool(Edit.Value, CharacterTemplate.bIgnoreEndTacticalRestoreArmor);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bIgnoreEndTacticalRestoreArmor, ShouldLog, 'RedefineUnits');
			break;

		case 'CanFlankUnits':
			CharacterTemplate.CanFlankUnits = GetConfigBool(Edit.Value, CharacterTemplate.CanFlankUnits);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.CanFlankUnits, ShouldLog, 'RedefineUnits');
			break;

		case 'bAllowRushCam':
			CharacterTemplate.bAllowRushCam = GetConfigBool(Edit.Value, CharacterTemplate.bAllowRushCam);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bAllowRushCam, ShouldLog, 'RedefineUnits');
			break;

		case 'bDisablePodRevealMovementChecks':
			CharacterTemplate.bDisablePodRevealMovementChecks = GetConfigBool(Edit.Value, CharacterTemplate.bDisablePodRevealMovementChecks);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.bDisablePodRevealMovementChecks, ShouldLog, 'RedefineUnits');
			break;

		case 'CharacterGroupName':
			CharacterTemplate.CharacterGroupName = GetConfigName(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.CharacterGroupName, ShouldLog, 'RedefineUnits');
			break;

		case 'DefaultLoadout':
			CharacterTemplate.DefaultLoadout = GetConfigName(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.DefaultLoadout, ShouldLog, 'RedefineUnits');
			break;

		case 'RequiredLoadout':
			CharacterTemplate.RequiredLoadout = GetConfigName(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.RequiredLoadout, ShouldLog, 'RedefineUnits');
			break;

		case 'DefaultSoldierClass':
			CharacterTemplate.DefaultSoldierClass = GetConfigName(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.DefaultSoldierClass, ShouldLog, 'RedefineUnits');
			break;

		case 'PhotoboothPersonality':
			CharacterTemplate.PhotoboothPersonality = GetConfigName(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.PhotoboothPersonality, ShouldLog, 'RedefineUnits');
			break;

		case 'DeathEvent':
			CharacterTemplate.DeathEvent = GetConfigName(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.DeathEvent, ShouldLog, 'RedefineUnits');
			break;

		case 'ReactionFireDeathAnim':
			CharacterTemplate.ReactionFireDeathAnim = GetConfigName(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.ReactionFireDeathAnim, ShouldLog, 'RedefineUnits');
			break;

		case 'AcquiredPhobiaTemplate':
			CharacterTemplate.AcquiredPhobiaTemplate = GetConfigName(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.AcquiredPhobiaTemplate, ShouldLog, 'RedefineUnits');
			break;

		case 'UnitSize':
			CharacterTemplate.UnitSize = GetConfigInt(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.UnitSize, ShouldLog, 'RedefineUnits');
			break;

		case 'UnitHeight':
			CharacterTemplate.UnitHeight = GetConfigInt(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.UnitHeight, ShouldLog, 'RedefineUnits');
			break;

		case 'DirectXpAmount':
			CharacterTemplate.DirectXpAmount = GetConfigInt(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.DirectXpAmount, ShouldLog, 'RedefineUnits');
			break;

		case 'MPPointValue':
			CharacterTemplate.MPPointValue = GetConfigInt(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.MPPointValue, ShouldLog, 'RedefineUnits');
			break;

		case 'MaxCharactersPerGroup':
			CharacterTemplate.MaxCharactersPerGroup = GetConfigInt(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.MaxCharactersPerGroup, ShouldLog, 'RedefineUnits');
			break;

		case 'MaxFlightPitchDegrees':
			CharacterTemplate.MaxFlightPitchDegrees = GetConfigInt(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.MaxFlightPitchDegrees, ShouldLog, 'RedefineUnits');
			break;

		case 'InitiativePriority':
			CharacterTemplate.InitiativePriority = GetConfigInt(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.InitiativePriority, ShouldLog, 'RedefineUnits');
			break;

		case 'ScamperActionPoints':
			CharacterTemplate.ScamperActionPoints = GetConfigInt(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.ScamperActionPoints, ShouldLog, 'RedefineUnits');
			break;

		case 'AIOrderPriority':
			CharacterTemplate.AIOrderPriority = GetConfigInt(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.AIOrderPriority, ShouldLog, 'RedefineUnits');
			break;

		case 'KillContribution':
			CharacterTemplate.KillContribution = GetConfigFloat(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.KillContribution, ShouldLog, 'RedefineUnits');
			break;

		case 'XpKillscore':
			CharacterTemplate.XpKillscore = GetConfigFloat(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.XpKillscore, ShouldLog, 'RedefineUnits');
			break;

		case 'VisionArcDegrees':
			CharacterTemplate.VisionArcDegrees = GetConfigFloat(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.VisionArcDegrees, ShouldLog, 'RedefineUnits');
			break;

		case 'SoloMoveSpeedModifier':
			CharacterTemplate.SoloMoveSpeedModifier = GetConfigFloat(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.SoloMoveSpeedModifier, ShouldLog, 'RedefineUnits');
			break;

		case 'AIMinSpreadDist':
			CharacterTemplate.AIMinSpreadDist = GetConfigFloat(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.AIMinSpreadDist, ShouldLog, 'RedefineUnits');
			break;

		case 'AISpreadMultiplier':
			CharacterTemplate.AISpreadMultiplier = GetConfigFloat(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.AISpreadMultiplier, ShouldLog, 'RedefineUnits');
			break;

		case 'ChallengePowerLevel':
			CharacterTemplate.ChallengePowerLevel = GetConfigFloat(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.ChallengePowerLevel, ShouldLog, 'RedefineUnits');
			break;

		case 'strTargetingMatineePrefix':
			CharacterTemplate.strTargetingMatineePrefix = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.strTargetingMatineePrefix, ShouldLog, 'RedefineUnits');
			break;

		case 'strIntroMatineeSlotPrefix':
			CharacterTemplate.strIntroMatineeSlotPrefix = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.strIntroMatineeSlotPrefix, ShouldLog, 'RedefineUnits');
			break;

		case 'strLoadingMatineeSlotPrefix':
			CharacterTemplate.strLoadingMatineeSlotPrefix = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.strLoadingMatineeSlotPrefix, ShouldLog, 'RedefineUnits');
			break;

		case 'strHackIconImage':
			CharacterTemplate.strHackIconImage = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.strHackIconImage, ShouldLog, 'RedefineUnits');
			break;

		case 'strTargetIconImage':
			CharacterTemplate.strTargetIconImage = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.strTargetIconImage, ShouldLog, 'RedefineUnits');
			break;

		case 'RevealMatineePrefix':
			CharacterTemplate.RevealMatineePrefix = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.RevealMatineePrefix, ShouldLog, 'RedefineUnits');
			break;

		case 'strBehaviorTree':
			CharacterTemplate.strBehaviorTree = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.strBehaviorTree, ShouldLog, 'RedefineUnits');
			break;

		case 'strPanicBT':
			CharacterTemplate.strPanicBT = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.strPanicBT, ShouldLog, 'RedefineUnits');
			break;

		case 'strScamperBT':
			CharacterTemplate.strScamperBT = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.strScamperBT, ShouldLog, 'RedefineUnits');
			break;

		case 'SpeakerPortrait':
			CharacterTemplate.SpeakerPortrait = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.SpeakerPortrait, ShouldLog, 'RedefineUnits');
			break;

		case 'HQIdleAnim':
			CharacterTemplate.HQIdleAnim = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.HQIdleAnim, ShouldLog, 'RedefineUnits');
			break;

		case 'HQOffscreenAnim':
			CharacterTemplate.HQOffscreenAnim = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.HQOffscreenAnim, ShouldLog, 'RedefineUnits');
			break;

		case 'HQOnscreenAnimPrefix':
			CharacterTemplate.HQOnscreenAnimPrefix = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.HQOnscreenAnimPrefix, ShouldLog, 'RedefineUnits');
			break;

		case 'strAutoRunNonAIBT':
			CharacterTemplate.strAutoRunNonAIBT = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.strAutoRunNonAIBT, ShouldLog, 'RedefineUnits');
			break;

		case 'strSkirmishImage':
			CharacterTemplate.strSkirmishImage = GetConfigString(Edit.Value);
			`Log(LogHeader @ "- property was set to" @ CharacterTemplate.strSkirmishImage, ShouldLog, 'RedefineUnits');
			break;

		default:
			`Log(LogHeader @ "- property is unknown", ShouldLog, 'RedefineUnits');
			break;
	}
}

static function ApplyPrimitiveArrayChanges(X2CharacterTemplate CharacterTemplate, PrimitiveArrayRedefinition Edit, bool ShouldLog)
{
	switch (Edit.Property)
	{
		case 'Abilities':
			ArrayNameAddition(CharacterTemplate.Abilities, Edit.Add, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameRemoval(CharacterTemplate.Abilities, Edit.Remove, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameReplacement(CharacterTemplate.Abilities, Edit.Replace, Edit.Property, CharacterTemplate.DataName, ShouldLog);

		case 'HackRewards':
			ArrayNameAddition(CharacterTemplate.HackRewards, Edit.Add, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameRemoval(CharacterTemplate.HackRewards, Edit.Remove, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameReplacement(CharacterTemplate.HackRewards, Edit.Replace, Edit.Property, CharacterTemplate.DataName, ShouldLog);

		case 'SupportedFollowers':
			ArrayNameAddition(CharacterTemplate.SupportedFollowers, Edit.Add, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameRemoval(CharacterTemplate.SupportedFollowers, Edit.Remove, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameReplacement(CharacterTemplate.SupportedFollowers, Edit.Replace, Edit.Property, CharacterTemplate.DataName, ShouldLog);

		case 'AppearInStaffSlots':
			ArrayNameAddition(CharacterTemplate.AppearInStaffSlots, Edit.Add, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameRemoval(CharacterTemplate.AppearInStaffSlots, Edit.Remove, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameReplacement(CharacterTemplate.AppearInStaffSlots, Edit.Replace, Edit.Property, CharacterTemplate.DataName, ShouldLog);

		case 'SightedEvents':
			ArrayNameAddition(CharacterTemplate.SightedEvents, Edit.Add, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameRemoval(CharacterTemplate.SightedEvents, Edit.Remove, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameReplacement(CharacterTemplate.SightedEvents, Edit.Replace, Edit.Property, CharacterTemplate.DataName, ShouldLog);

		case 'ImmuneTypes':
			ArrayNameAddition(CharacterTemplate.ImmuneTypes, Edit.Add, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameRemoval(CharacterTemplate.ImmuneTypes, Edit.Remove, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayNameReplacement(CharacterTemplate.ImmuneTypes, Edit.Replace, Edit.Property, CharacterTemplate.DataName, ShouldLog);

		case 'SkillLevelThresholds':
			ArrayIntAddition(CharacterTemplate.SkillLevelThresholds, Edit.Add, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayIntRemoval(CharacterTemplate.SkillLevelThresholds, Edit.Remove, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayIntReplacement(CharacterTemplate.SkillLevelThresholds, Edit.Replace, Edit.Property, CharacterTemplate.DataName, ShouldLog);

		case 'strPawnArchetypes':
			ArrayStringAddition(CharacterTemplate.strPawnArchetypes, Edit.Add, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayStringRemoval(CharacterTemplate.strPawnArchetypes, Edit.Remove, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayStringReplacement(CharacterTemplate.strPawnArchetypes, Edit.Replace, Edit.Property, CharacterTemplate.DataName, ShouldLog);

		case 'strMatineePackages':
			ArrayStringAddition(CharacterTemplate.strMatineePackages, Edit.Add, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayStringRemoval(CharacterTemplate.strMatineePackages, Edit.Remove, Edit.Property, CharacterTemplate.DataName, ShouldLog);
			ArrayStringReplacement(CharacterTemplate.strMatineePackages, Edit.Replace, Edit.Property, CharacterTemplate.DataName, ShouldLog);

		default:
			`Log("[" $ CharacterTemplate.DataName $ "][" $ Edit.Property $ "]" @ "- property is unknown", ShouldLog, 'RedefineUnits');
			break;
	}
}

static function ApplyStatsOperationChanges(X2CharacterTemplate CharacterTemplate, CharacterDefinition CharacterEdit, int Difficulty, bool ShouldLog)
{
	local StatOperations StatOperation;
	local int OriginalStatValue;
	local int NewStatValue;
	local string StatTypeText;
	local string LogHeader;

	if (CharacterEdit.StatEdition.Length == 0)
	{
		return;
	}

	foreach CharacterEdit.StatEdition(StatOperation)
	{
		StatTypeText = class'X2TacticalGameRulesetDataStructures'.default.m_aCharStatLabels[int(StatOperation.Stat)];
		OriginalStatValue = int(CharacterTemplate.CharacterBaseStats[StatOperation.Stat]);

		LogHeader = "[" $ CharacterTemplate.DataName $ "]" $ GetDifficultyString(Difficulty) $ "[" $ StatTypeText $ "]";

		if (StatOperation.Set != 0)
		{
			NewStatValue = StatOperation.Set;
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = NewStatValue;

			`Log(LogHeader @ "- changed from" @ OriginalStatValue @ "to" @ NewStatValue, ShouldLog, 'RedefineUnits');
		}

		if (StatOperation.Add != 0)
		{
			NewStatValue = OriginalStatValue + StatOperation.Add;
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = NewStatValue;

			`Log(LogHeader @ "- changed from" @ OriginalStatValue @ "to" @ NewStatValue, default.EnableLogs, 'RedefineUnits');
		}

		if (StatOperation.Substract != 0)
		{
			NewStatValue = OriginalStatValue - StatOperation.Substract;
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = NewStatValue;

			`Log(LogHeader @ "- changed from" @ OriginalStatValue @ "to" @ NewStatValue, default.EnableLogs, 'RedefineUnits');
		}

		if (StatOperation.MultiplyBy != 0)
		{
			NewStatValue = Round(OriginalStatValue * StatOperation.MultiplyBy);
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = NewStatValue;

			`Log(LogHeader @ "- changed from" @ OriginalStatValue @ "to" @ NewStatValue, default.EnableLogs, 'RedefineUnits');
		}

		if (StatOperation.DivideBy != 0)
		{
			NewStatValue = Round(OriginalStatValue / StatOperation.DivideBy);
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = NewStatValue;

			`Log(LogHeader @ "- changed from" @ OriginalStatValue @ "to" @ NewStatValue, default.EnableLogs, 'RedefineUnits');
		}

		if (StatOperation.PercentOf.StatRef != eStat_Invalid)
		{
			NewStatValue = Round(OriginalStatValue + CharacterTemplate.CharacterBaseStats[StatOperation.PercentOf.StatRef] * StatOperation.PercentOf.PercentValue);
			CharacterTemplate.CharacterBaseStats[StatOperation.Stat] = NewStatValue;

			`Log(LogHeader @ "- changed from" @ OriginalStatValue @ "to" @ NewStatValue, default.EnableLogs, 'RedefineUnits');
		}
	}
}

static function ApplyRandomizedStatsChanges(X2CharacterTemplate CharacterTemplate, CharacterDefinition CharacterEdit, bool ShouldLog)
{
	local StatRandomizations StatRandomization;
	local SoldierClassStatType SoldierClassRandStat;
	local string StatTypeText;

	if (CharacterEdit.StatRandomizer.Length == 0)
	{
		return;
	}

	foreach CharacterEdit.StatRandomizer(StatRandomization)
	{
		if (StatRandomization.RandAmount == -100 || StatRandomization.Stat == eStat_Invalid || StatRandomization.BaseStat == -100)
		{
			continue;
		}

		StatTypeText = class'X2TacticalGameRulesetDataStructures'.default.m_aCharStatLabels[int(StatRandomization.Stat)];

		SoldierClassRandStat.StatAmount = StatRandomization.BaseStat;
		SoldierClassRandStat.StatType = StatRandomization.Stat;
		SoldierClassRandStat.RandStatAmount = StatRandomization.RandAmount;

		if (StatRandomization.Cap != -100)
		{
			SoldierClassRandStat.CapStatAmount = StatRandomization.Cap;
		}

		CharacterTemplate.RandomizedBaseStats.AddItem(SoldierClassRandStat);

		`Log(CharacterTemplate.DataName $ "- randomized" @ StatTypeText, ShouldLog, 'RedefineUnits');
	}
}

static function ArrayIntAddition(out array<int> ArrayProperty, array<string> Items, name Property, name CharacterName, bool ShouldLog)
{
	local string Item;
	local string AddedItem;
	local string LogHeader;

	LogHeader = "[" $ CharacterName $ "][" $ Property $ "]";

	foreach Items(Item)
	{
		AddedItem @= Item $ ",";
		ArrayProperty.AddItem(GetConfigInt(Item));
	}

	`Log(LogHeader @ "- the following items were added:" @ Left(AddedItem, Len(AddedItem) - 1), ShouldLog, 'RedefineUnits');
}

static function ArrayIntRemoval(out array<int> ArrayProperty, array<string> Items, name Property, name CharacterName, bool ShouldLog)
{
	local string Item;
	local string RemovedItem;
	local string LogHeader;

	LogHeader = "[" $ CharacterName $ "][" $ Property $ "]";

	foreach Items(Item)
	{
		RemovedItem @= Item $ ",";
		ArrayProperty.RemoveItem(GetConfigInt(Item));
	}

	`Log(LogHeader @ "- the following items were removed:" @ Left(RemovedItem, Len(RemovedItem) - 1), ShouldLog, 'RedefineUnits');
}

static function ArrayIntReplacement(out array<int> ArrayProperty, array<string> Items, name Property, name CharacterName, bool ShouldLog)
{
	local string Item;
	local string AddedItem;
	local string LogHeader;

	LogHeader = "[" $ CharacterName $ "][" $ Property $ "]";

	ArrayProperty.Length = 0;

	foreach Items(Item)
	{
		AddedItem @= Item $ ",";
		ArrayProperty.AddItem(GetConfigInt(Item));
	}

	`Log(LogHeader @ "- replaced previous items by the following ones:" @ Left(AddedItem, Len(AddedItem) - 1), ShouldLog, 'RedefineUnits');
}

static function ArrayNameAddition(out array<name> ArrayProperty, array<string> Items, name Property, name CharacterName, bool ShouldLog)
{
	local string Item;
	local string AddedItem;
	local string LogHeader;

	LogHeader = "[" $ CharacterName $ "][" $ Property $ "]";

	foreach Items(Item)
	{
		AddedItem @= Item $ ",";
		ArrayProperty.AddItem(GetConfigName(Item));
	}

	`Log(LogHeader @ "- the following items were added:" @ Left(AddedItem, Len(AddedItem) - 1), ShouldLog, 'RedefineUnits');
}

static function ArrayNameRemoval(out array<name> ArrayProperty, array<string> Items, name Property, name CharacterName, bool ShouldLog)
{
	local string Item;
	local string RemovedItem;
	local string LogHeader;

	LogHeader = "[" $ CharacterName $ "][" $ Property $ "]";

	foreach Items(Item)
	{
		RemovedItem @= Item $ ",";
		ArrayProperty.RemoveItem(GetConfigName(Item));
	}

	`Log(LogHeader @ "- the following items were removed:" @ Left(RemovedItem, Len(RemovedItem) - 1), ShouldLog, 'RedefineUnits');
}

static function ArrayNameReplacement(out array<name> ArrayProperty, array<string> Items, name Property, name CharacterName, bool ShouldLog)
{
	local string Item;
	local string AddedItem;
	local string LogHeader;

	LogHeader = "[" $ CharacterName $ "][" $ Property $ "]";

	ArrayProperty.Length = 0;

	foreach Items(Item)
	{
		AddedItem @= Item $ ",";
		ArrayProperty.AddItem(GetConfigName(Item));
	}

	`Log(LogHeader @ "- replaced previous items by the following ones:" @ Left(AddedItem, Len(AddedItem) - 1), ShouldLog, 'RedefineUnits');
}

static function ArrayStringAddition(out array<string> ArrayProperty, array<string> Items, name Property, name CharacterName, bool ShouldLog)
{
	local string Item;
	local string AddedItem;
	local string LogHeader;

	LogHeader = "[" $ CharacterName $ "][" $ Property $ "]";

	foreach Items(Item)
	{
		AddedItem @= Item $ ",";
		ArrayProperty.AddItem(Item);
	}

	`Log(LogHeader @ "- the following items were added:" @ Left(AddedItem, Len(AddedItem) - 1), ShouldLog, 'RedefineUnits');
}

static function ArrayStringRemoval(out array<string> ArrayProperty, array<string> Items, name Property, name CharacterName, bool ShouldLog)
{
	local string Item;
	local string RemovedItem;
	local string LogHeader;

	LogHeader = "[" $ CharacterName $ "][" $ Property $ "]";

	foreach Items(Item)
	{
		RemovedItem @= Item $ ",";
		ArrayProperty.RemoveItem(Item);
	}

	`Log(LogHeader @ "- the following items were removed:" @ Left(RemovedItem, Len(RemovedItem) - 1), ShouldLog, 'RedefineUnits');
}

static function ArrayStringReplacement(out array<string> ArrayProperty, array<string> Items, name Property, name CharacterName, bool ShouldLog)
{
	local string Item;
	local string AddedItem;
	local string LogHeader;

	LogHeader = "[" $ CharacterName $ "][" $ Property $ "]";

	ArrayProperty.Length = 0;

	foreach Items(Item)
	{
		AddedItem @= Item $ ",";
		ArrayProperty.AddItem(Item);
	}

	`Log(LogHeader @ "- replaced previous items by the following ones:" @ Left(AddedItem, Len(AddedItem) - 1), ShouldLog, 'RedefineUnits');
}

static function bool GetConfigBool(string ConfigValue, bool OriginalValue)
{
	if (Caps(ConfigValue) == "TRUE")
	{
		return true;
	}

	if (Caps(ConfigValue) == "FALSE")
	{
		return false;
	}

	return OriginalValue;
}

static function int GetConfigInt(string ConfigValue)
{
	return int(ConfigValue);
}

static function float GetConfigFloat(string ConfigValue)
{
	return float(ConfigValue);
}

static function name GetConfigName(string ConfigValue)
{
	return name(ConfigValue);
}

static function string GetConfigString(string ConfigValue)
{
	return ConfigValue;
}

static function string GetDifficultyString(int Difficulty)
{
	if (Difficulty == 4)
	{
		return "";
	}

	return "[" $ class'UIShellDifficulty'.default.m_arrDifficultyTypeStrings[Difficulty] $ "]";
}
