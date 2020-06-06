class X2DownloadableContentInfo_WOTC_AHW_Visual_Upgrades extends X2DownloadableContentInfo config(AHWUpgrades);

var config bool CONFIGURE_UPGRADE_SLOTS;

var config int CONVENTIONAL_UPGRADE_SLOTS;

var config int MAGNETIC_UPGRADE_SLOTS;

var config int BEAM_UPGRADE_SLOTS;


struct BoltCasterWeaponAttachment {
	var string Type;
	var name AttachSocket;
	var name UIArmoryCameraPointTag;
	var string MeshName;
	var string ProjectileName;
	var name MatchWeaponTemplate;
	var bool AttachToPawn;
	var string IconName;
	var string InventoryIconName;
	var string InventoryCategoryIcon;
	var name AttachmentFn;
};

struct ShadowKeeperWeaponAttachment {
	var string Type;
	var name AttachSocket;
	var name UIArmoryCameraPointTag;
	var string MeshName;
	var string ProjectileName;
	var name MatchWeaponTemplate;
	var bool AttachToPawn;
	var string IconName;
	var string InventoryIconName;
	var string InventoryCategoryIcon;
	var name AttachmentFn;
};

var config array<BoltCasterWeaponAttachment> BoltCasterAttachment;
var config array<ShadowKeeperWeaponAttachment> ShadowKeeperAttachment;

static function bool DLCLoaded(name DLCName)
{
    local XComOnlineEventMgr    EventManager;
    local int                    Index;

    EventManager = `ONLINEEVENTMGR;

    for(Index = EventManager.GetNumDLC() - 1; Index >= 0; Index--)    
    {
        if(EventManager.GetDLCNames(Index) == DLCName)    
        {
            return true;
        }
    }
    return false;
}

static event OnPostTemplatesCreated()
{
	local X2ItemTemplateManager		ItemMgr;
	local X2WeaponTemplate			Template;
	local X2ItemTemplateManager		ItemManager;
    local array<name>				TemplateNames;
    local name						TemplateName;
	local array<X2DataTemplate>		TemplateAllDifficulties;
    local X2DataTemplate			DataTemplate;
	local X2WeaponUpgradeTemplate	UpgradeTemplate;
	local X2AbilityTemplateManager  AbilityManager;
	local X2AbilityTemplate         AbilityTemplate;
	local X2AbilityTemplate         STemplate;

	ItemMgr = class'X2ItemTemplateManager'.static.GetItemTemplateManager();


	//##########################################
	//#######		 SHADOWKEEPER 		########
	//########################################## 

	//#######		 CONVENTIONAL 		########
	Template = X2WeaponTemplate(ItemMgr.FindItemTemplate('AlienHunterPistol_CV'));
	Template.GameArchetype = "CS_AlienHunter_Weapons_Visual.Archetypes.WP_HunterPistol_CV_CS";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Stock', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Stock", , "");
	Template.AddDefaultAttachment('UI_Trigger', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Trigger", , "");
	if (default.CONFIGURE_UPGRADE_SLOTS) Template.NumUpgradeSlots = default.CONVENTIONAL_UPGRADE_SLOTS;

	if (DLCLoaded('PrimarySecondaries'))
	{
		Template = X2WeaponTemplate(ItemMgr.FindItemTemplate('AlienHunterPistol_CV_Primary'));
		Template.GameArchetype = "CS_AlienHunter_Weapons_Visual.Archetypes.WP_HunterPistol_CV_CS";
		Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
		Template.AddDefaultAttachment('Stock', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Stock", , "");
		Template.AddDefaultAttachment('UI_Trigger', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Trigger", , "");
		if (default.CONFIGURE_UPGRADE_SLOTS) Template.NumUpgradeSlots = default.CONVENTIONAL_UPGRADE_SLOTS;
	}

	//#######		 MAGNETIC 		########
	Template = X2WeaponTemplate(ItemMgr.FindItemTemplate('AlienHunterPistol_MG'));
	Template.GameArchetype = "CS_AlienHunter_Weapons_Visual.Archetypes.WP_HunterPistol_MG_CS";
	if (default.CONFIGURE_UPGRADE_SLOTS) Template.NumUpgradeSlots = default.MAGNETIC_UPGRADE_SLOTS;
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Stock', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Stock", , "");
	Template.AddDefaultAttachment('UI_Trigger', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Trigger", , "");
	if(DLCLoaded('PrimarySecondaries'))
	{
		Template = X2WeaponTemplate(ItemMgr.FindItemTemplate('AlienHunterPistol_MG_Primary'));
		Template.GameArchetype = "CS_AlienHunter_Weapons_Visual.Archetypes.WP_HunterPistol_MG_CS";
		Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
		Template.AddDefaultAttachment('Stock', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Stock", , "");
		Template.AddDefaultAttachment('UI_Trigger', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Trigger", , "");
		if (default.CONFIGURE_UPGRADE_SLOTS) Template.NumUpgradeSlots = default.MAGNETIC_UPGRADE_SLOTS;
	}

	//#######		 BEAM 		########
	Template = X2WeaponTemplate(ItemMgr.FindItemTemplate('AlienHunterPistol_BM'));
	Template.GameArchetype = "CS_AlienHunter_Weapons_Visual.Archetypes.WP_HunterPistol_BM_CS";
	if (default.CONFIGURE_UPGRADE_SLOTS) Template.NumUpgradeSlots = default.BEAM_UPGRADE_SLOTS;
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Stock', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Stock", , "");
	Template.AddDefaultAttachment('UI_Trigger', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Trigger", , "");
	Template.AddDefaultAttachment('Optic', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Beam.SM_BeamHunterPistol_ScopeA", , "");
	if(DLCLoaded('PrimarySecondaries'))
	{
		Template = X2WeaponTemplate(ItemMgr.FindItemTemplate('AlienHunterPistol_BM_Primary'));
		Template.GameArchetype = "CS_AlienHunter_Weapons_Visual.Archetypes.WP_HunterPistol_BM_CS";
		Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
		Template.AddDefaultAttachment('Stock', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Stock", , "");
		Template.AddDefaultAttachment('UI_Trigger', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Base.SM_HunterPistol_Trigger", , "");
		Template.AddDefaultAttachment('Optic', "CS_AlienHunter_Weapons_Visual.Shadowkeeper.Meshes.Beam.SM_BeamHunterPistol_ScopeA", , "");
		if (default.CONFIGURE_UPGRADE_SLOTS) Template.NumUpgradeSlots = default.BEAM_UPGRADE_SLOTS;
	}

	//##########################################
	//#######		 BOLTCASTER 		########
	//########################################## 

	//#######		 CONVENTIONAL 		########
	Template = X2WeaponTemplate(ItemMgr.FindItemTemplate('AlienHunterRifle_CV'));
	Template.GameArchetype = "CS_AlienHunter_Weapons_Visual.Archetypes.WP_BoltCaster_CV_CS";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Stock', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.Base.SM_BoltCasterStockA", , "");
	Template.AddDefaultAttachment('UI_Trigger', "ConvSniper.Meshes.SM_ConvSniper_TriggerA", , "");
	Template.AddDefaultAttachment('Reargrip', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.Base.SM_BoltCaster_RearGripA", , "");
	Template.AddDefaultAttachment('Bolt', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.conventional.SM_ConvBoltCaster_Bolt", , "" );
	Template.AddDefaultAttachment('BoltHolder', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.conventional.SM_ConvBoltCaster_BoltHolder", , "" );
	if (default.CONFIGURE_UPGRADE_SLOTS) Template.NumUpgradeSlots = default.CONVENTIONAL_UPGRADE_SLOTS;

	//#######		  MAGNETIC 		    ########
	Template = X2WeaponTemplate(ItemMgr.FindItemTemplate('AlienHunterRifle_MG'));
	Template.GameArchetype = "CS_AlienHunter_Weapons_Visual.WP_BoltCaster_MG_CS";
	Template.UIArmoryCameraPointTag = 'UIPawnLocation_WeaponUpgrade_AssaultRifle';
	Template.AddDefaultAttachment('Stock', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.Base.SM_BoltCasterStockA", , "");
	Template.AddDefaultAttachment('UI_Trigger', "ConvSniper.Meshes.SM_ConvSniper_TriggerA", , "");
	Template.AddDefaultAttachment('Reargrip', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.Base.SM_BoltCaster_RearGripA", , "");
	Template.AddDefaultAttachment('Bolt', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.magnetic.SM_MagBoltCaster_Bolt", , "" );
	Template.AddDefaultAttachment('BoltHolder', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.magnetic.SM_MagBoltCaster_BoltHolder", , "" );
	if (default.CONFIGURE_UPGRADE_SLOTS) Template.NumUpgradeSlots = default.CONVENTIONAL_UPGRADE_SLOTS;

	//#######	 	   BEAM     		########
	Template = X2WeaponTemplate(ItemMgr.FindItemTemplate('AlienHunterRifle_BM'));
	Template.GameArchetype = "Alien_Hunter_Weapons_Upgrades.WP_BoltCaster_BM_CS";
	Template.AddDefaultAttachment('Stock', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.Base.SM_BoltCasterStockA", , "");
	Template.AddDefaultAttachment('UI_Trigger', "ConvSniper.Meshes.SM_ConvSniper_TriggerA", , "");
	Template.AddDefaultAttachment('Reargrip', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.Base.SM_BoltCaster_RearGripA", , "");
	Template.AddDefaultAttachment('Bolt', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.Beam.SM_BeamBoltCaster_Bolt", , "" );
	Template.AddDefaultAttachment('BoltHolder', "CS_AlienHunter_Weapons_Visual.BoltCaster.Meshes.Beam.SM_BeamBoltCaster_BoltHolder", , "" );
	if (default.CONFIGURE_UPGRADE_SLOTS) Template.NumUpgradeSlots = default.CONVENTIONAL_UPGRADE_SLOTS;

	UpdateMods();
}

static function UpdateMods() {
local X2ItemTemplateManager ItemTemplateManager;

ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
//get access to item template manager to update existing upgrades
	if (ItemTemplateManager == none) {
		`Log("failed to retrieve ItemTemplateManager to configure upgrades");
	} else {
		AddCritUpgrade(ItemTemplateManager, 'CritUpgrade_Bsc');
		AddCritUpgrade(ItemTemplateManager, 'CritUpgrade_Adv');
		AddCritUpgrade(ItemTemplateManager, 'CritUpgrade_Sup');
		
		AddAimBonusUpgrade(ItemTemplateManager, 'AimUpgrade_Bsc');
		AddAimBonusUpgrade(ItemTemplateManager, 'AimUpgrade_Adv');
		AddAimBonusUpgrade(ItemTemplateManager, 'AimUpgrade_Sup');

		//AddFreeFireBonusUpgrade(ItemTemplateManager, 'FreeFireUpgrade_Bsc');
		//AddFreeFireBonusUpgrade(ItemTemplateManager, 'FreeFireUpgrade_Adv');
		//AddFreeFireBonusUpgrade(ItemTemplateManager, 'FreeFireUpgrade_Sup');
//
		//AddFreeKillUpgrade(ItemTemplateManager, 'FreeKillUpgrade_Bsc');
		//AddFreeKillUpgrade(ItemTemplateManager, 'FreeKillUpgrade_Adv');
		//AddFreeKillUpgrade(ItemTemplateManager, 'FreeKillUpgrade_Sup');
//
		//AddMissDamageUpgrade(ItemTemplateManager, 'MissDamageUpgrade_Bsc');
		//AddMissDamageUpgrade(ItemTemplateManager, 'MissDamageUpgrade_Adv');
		//AddMissDamageUpgrade(ItemTemplateManager, 'MissDamageUpgrade_Sup');
//
		//AddClipSizeBonusUpgrade(ItemTemplateManager, 'ClipSizeUpgrade_Bsc');
		//AddClipSizeBonusUpgrade(ItemTemplateManager, 'ClipSizeUpgrade_Adv');
		//AddClipSizeBonusUpgrade(ItemTemplateManager, 'ClipSizeUpgrade_Sup');
//
		//AddReloadUpgrade(ItemTemplateManager, 'ReloadUpgrade_Bsc');
		//AddReloadUpgrade(ItemTemplateManager, 'ReloadUpgrade_Adv');
		//AddReloadUpgrade(ItemTemplateManager, 'ReloadUpgrade_Sup');
	}
}

static function AddCritUpgrade(X2ItemTemplateManager ItemTemplateManager, Name TemplateName)
{
	local X2WeaponUpgradeTemplate Template;

	Template = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(TemplateName));

	Template.AddUpgradeAttachment('LaserOptic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticB", "", 'AlienHunterPistol_CV', , "", "", "");
	Template.AddUpgradeAttachment('LaserOptic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticB", "", 'AlienHunterPistol_MG', , "", "", "");
	Template.AddUpgradeAttachment('LaserOptic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticB", "", 'AlienHunterPistol_BM', , "", "", "");

	Template.AddUpgradeAttachment('LaserOptic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticB", "", 'AlienHunterPistol_CV_Primary', , "", "", "");
	Template.AddUpgradeAttachment('LaserOptic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticB", "", 'AlienHunterPistol_MG_Primary', , "", "", "");
	Template.AddUpgradeAttachment('LaserOptic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticB", "", 'AlienHunterPistol_BM_Primary', , "", "", "");
}

static function AddAimBonusUpgrade(X2ItemTemplateManager ItemTemplateManager, Name TemplateName)
{
	local X2WeaponUpgradeTemplate Template;

	Template = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(TemplateName));

	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticC", "", 'AlienHunterPistol_CV', , "", "", "");
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticC", "", 'AlienHunterPistol_MG', , "", "", "");
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticC", "", 'AlienHunterPistol_BM', , "", "", "");

	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticC", "", 'AlienHunterPistol_CV_Primary', , "", "", "");
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticC", "", 'AlienHunterPistol_MG_Primary', , "", "", "");
	Template.AddUpgradeAttachment('Optic', 'UIPawnLocation_WeaponUpgrade_Shotgun', "MagSniper.Meshes.SM_MagSniper_OpticC", "", 'AlienHunterPistol_BM_Primary', , "", "", "");
	
}


static function AddAttachments()
{
	local array<name> AttachmentTypes;
	local name AttachmentType;
	
	AttachmentTypes.AddItem('CritUpgrade_Bsc');
	AttachmentTypes.AddItem('CritUpgrade_Adv');
	AttachmentTypes.AddItem('CritUpgrade_Sup');
	AttachmentTypes.AddItem('AimUpgrade_Bsc');
	AttachmentTypes.AddItem('AimUpgrade_Adv');
	AttachmentTypes.AddItem('AimUpgrade_Sup');
	AttachmentTypes.AddItem('ClipSizeUpgrade_Bsc');
	AttachmentTypes.AddItem('ClipSizeUpgrade_Adv');
	AttachmentTypes.AddItem('ClipSizeUpgrade_Sup');
	AttachmentTypes.AddItem('FreeFireUpgrade_Bsc');
	AttachmentTypes.AddItem('FreeFireUpgrade_Adv');
	AttachmentTypes.AddItem('FreeFireUpgrade_Sup');
	AttachmentTypes.AddItem('ReloadUpgrade_Bsc');
	AttachmentTypes.AddItem('ReloadUpgrade_Adv');
	AttachmentTypes.AddItem('ReloadUpgrade_Sup');
	AttachmentTypes.AddItem('MissDamageUpgrade_Bsc');
	AttachmentTypes.AddItem('MissDamageUpgrade_Adv');
	AttachmentTypes.AddItem('MissDamageUpgrade_Sup');
	AttachmentTypes.AddItem('FreeKillUpgrade_Bsc');
	AttachmentTypes.AddItem('FreeKillUpgrade_Adv');
	AttachmentTypes.AddItem('FreeKillUpgrade_Sup');

	foreach AttachmentTypes(AttachmentType)
	{
		`LOG("looping through BoltCaster attachments CISCOSTU ----------------BoltCaster ------------------");
		AddBoltCasterAttachment(AttachmentType, default.BoltCasterAttachment);
	}

	foreach AttachmentTypes(AttachmentType)
	{
		`LOG("looping through BoltCaster attachments CISCOSTU ----------------ShadowKeeper ------------------");
		AddShadowKeeperAttachment(AttachmentType, default.ShadowKeeperAttachment);
	}
}

static function AddBoltCasterAttachment(name TemplateName, array<BoltCasterWeaponAttachment> Attachments) 
{

	local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponUpgradeTemplate Template;
	local BoltCasterWeaponAttachment Attachment;
	local delegate<X2TacticalGameRulesetDataStructures.CheckUpgradeStatus> CheckFN;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	Template = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(TemplateName));

	foreach Attachments(Attachment)
	{
		if (InStr(string(TemplateName), Attachment.Type) != INDEX_NONE)
		{
			switch(Attachment.AttachmentFn) 
			{
				case ('NoReloadUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent; 
					break;
				case ('ReloadUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.ReloadUpgradePresent; 
					break;
				case ('NoClipSizeUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent; 
					break;
				case ('ClipSizeUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent; 
					break;
				case ('NoFreeFireUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.NoFreeFireUpgradePresent; 
					break;
				case ('FreeFireUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.FreeFireUpgradePresent; 
					break;
				case ('NoFreeKillUpgradePresent'): 
					CheckFN = NoFreeKillUpgradePresent; 
					break;
				case ('FreeKillUpgradePresent'): 
					CheckFN = FreeKillUpgradePresent; 
					break;
				case ('NoAimUpgradePresent'): 
					CheckFN = NoAimUpgradePresent; 
					break;
				case ('AimUpgradePresent'): 
					CheckFN = AimUpgradePresent; 
					break;
				default:
					CheckFN = none;
					break;
			}
			Template.AddUpgradeAttachment(
				Attachment.AttachSocket,
				Attachment.UIArmoryCameraPointTag,
				Attachment.MeshName,
				Attachment.ProjectileName,
				Attachment.MatchWeaponTemplate,
				Attachment.AttachToPawn,
				Attachment.IconName,
				Attachment.InventoryIconName,
				Attachment.InventoryCategoryIcon,
				CheckFN);
		}
	}
}

static function AddShadowKeeperAttachment(name TemplateName, array<ShadowKeeperWeaponAttachment> Attachments) 
{

	local X2ItemTemplateManager ItemTemplateManager;
	local X2WeaponUpgradeTemplate Template;
	local ShadowKeeperWeaponAttachment Attachment;
	local delegate<X2TacticalGameRulesetDataStructures.CheckUpgradeStatus> CheckFN;

	ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
	Template = X2WeaponUpgradeTemplate(ItemTemplateManager.FindItemTemplate(TemplateName));

	foreach Attachments(Attachment)
	{
		if (InStr(string(TemplateName), Attachment.Type) != INDEX_NONE)
		{
			switch(Attachment.AttachmentFn) 
			{
				case ('NoReloadUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.NoReloadUpgradePresent; 
					break;
				case ('ReloadUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.ReloadUpgradePresent; 
					break;
				case ('NoClipSizeUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.NoClipSizeUpgradePresent; 
					break;
				case ('ClipSizeUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.ClipSizeUpgradePresent; 
					break;
				case ('NoFreeFireUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.NoFreeFireUpgradePresent; 
					break;
				case ('FreeFireUpgradePresent'): 
					CheckFN = class'X2Item_DefaultUpgrades'.static.FreeFireUpgradePresent; 
					break;
				case ('NoFreeKillUpgradePresent'): 
					CheckFN = NoFreeKillUpgradePresent; 
					break;
				case ('FreeKillUpgradePresent'): 
					CheckFN = FreeKillUpgradePresent; 
					break;
				case ('NoAimUpgradePresent'): 
					CheckFN = NoAimUpgradePresent; 
					break;
				case ('AimUpgradePresent'): 
					CheckFN = AimUpgradePresent; 
					break;
				default:
					CheckFN = none;
					break;
			}
			Template.AddUpgradeAttachment(
				Attachment.AttachSocket,
				Attachment.UIArmoryCameraPointTag,
				Attachment.MeshName,
				Attachment.ProjectileName,
				Attachment.MatchWeaponTemplate,
				Attachment.AttachToPawn,
				Attachment.IconName,
				Attachment.InventoryIconName,
				Attachment.InventoryCategoryIcon,
				CheckFN);
		}
	}
}


static function bool NoFreeKillUpgradePresent(array<X2WeaponUpgradeTemplate> AllUpgradeTemplates)
{
	return !FreeKillUpgradePresent(AllUpgradeTemplates);
}

static function bool FreeKillUpgradePresent(array<X2WeaponUpgradeTemplate> AllUpgradeTemplates)
{
	local X2WeaponUpgradeTemplate TestTemplate;

	foreach AllUpgradeTemplates(TestTemplate)
	{
		if (TestTemplate.DataName == 'FreeKillUpgrade' ||
			TestTemplate.DataName == 'FreeKillUpgrade_Bsc' ||
			TestTemplate.DataName == 'FreeKillUpgrade_Adv' ||
			TestTemplate.DataName == 'FreeKillUpgrade_Sup')
		{
			return true;
		}
	}

	return false;
}

static function bool NoAimUpgradePresent(array<X2WeaponUpgradeTemplate> AllUpgradeTemplates)
{
	return !AimUpgradePresent(AllUpgradeTemplates);
}

static function bool AimUpgradePresent(array<X2WeaponUpgradeTemplate> AllUpgradeTemplates)
{
	local X2WeaponUpgradeTemplate TestTemplate;

	foreach AllUpgradeTemplates(TestTemplate)
	{
		if (TestTemplate.DataName == 'CritUpgrade_Bsc' ||
				TestTemplate.DataName == 'CritUpgrade_Adv' ||
				TestTemplate.DataName == 'CritUpgrade_Sup' ||
				TestTemplate.DataName == 'AimUpgrade_Bsc' ||
				TestTemplate.DataName == 'AimUpgrade_Adv' ||
				TestTemplate.DataName == 'AimUpgrade_Sup')
		{
			return true;
		}
	}

	return false;
}