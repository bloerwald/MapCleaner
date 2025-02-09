local ADDON_NAME, Addon = ...
Addon.MapCleaner = {}
local MapCleaner = Addon.MapCleaner

local SENTINEL_UNKNOWN_NAME = '<<unknown name>>'

SLASH_MAPCLEANER1 = '/mapcleaner'
SLASH_MAPCLEANER2 = '/mc'

local COMMAND_FILTERPOI = 'filterpoi'
local COMMAND_UNFILTERPOI = 'unfilterpoi'
local COMMAND_FILTERVIGNETTE = 'filtervignette'
local COMMAND_UNFILTERVIGNETTE = 'unfiltervignette'
local COMMAND_FILTERQUEST = 'filterquest'
local COMMAND_UNFILTERQUEST = 'unfilterquest'
local COMMAND_FILTERBOUNTYBOARD = 'filterbountyboard'
local COMMAND_UNFILTERBOUNTYBOARD = 'unfilterbountyboard'
local COMMAND_LISTFILTERED = 'listfiltered'
local COMMAND_LISTVISIBLE = 'listvisible'
local COMMAND_LISTVISIBLEALL = 'listvisibleall'

local L = {
  ['enUS'] = {
    ['ADDED_POI'] = ADDON_NAME .. ': Added POI %s (%d) to filter list.',
    ['ADDED_VIGNETTE'] = ADDON_NAME .. ': Added vignette %s (%d) to filter list.',
    ['ADDED_QUEST'] = ADDON_NAME .. ': Added quest %s (%d) to filter list.',
    ['ADDED_BOUNTYBOARD'] = ADDON_NAME .. ': Added map %s (%d) to filter list for bounty boards.',
    ['ADDED_BOUNTYBOARD_WARN_NO_SUCH'] = ADDON_NAME .. ': Added map %s (%d) to filter list for bounty boards. Note that there currently was no bounty visible there.',
    ['REMOVED_POI'] = ADDON_NAME .. ': Removed POI %s (%d) from filter list.',
    ['REMOVED_VIGNETTE'] = ADDON_NAME .. ': Removed vignette %s (%d) from filter list.',
    ['REMOVED_QUEST'] = ADDON_NAME .. ': Removed quest %s (%d) from filter list.',
    ['REMOVED_BOUNTYBOARD'] = ADDON_NAME .. ': Removed map %s (%d) from filter list for bounty boards.',
    ['LIST_ITEM_NAME_ID_PAIR'] = '- %s (%d)',
    ['LIST_FILTERED_EMPTY'] = ADDON_NAME .. ': No filters at all.',
    ['LIST_FILTERED_VIGNETTES'] = ADDON_NAME .. ': Filtered vignettes:',
    ['LIST_FILTERED_POIS'] = ADDON_NAME .. ': Filtered area POIs:',
    ['LIST_FILTERED_QUESTS'] = ADDON_NAME .. ': Filtered area quests:',
    ['LIST_FILTERED_BOUNTYBOARDS'] = ADDON_NAME .. ': Filtered bounty boards:',
    ['LIST_VISIBLE_EMPTY'] = ADDON_NAME .. ': No visible vignettes, POIs or quests at all.',
    ['LIST_VISIBLE_VIGNETTES'] = ADDON_NAME .. ': Visible vignettes:',
    ['LIST_VISIBLE_POIS'] = ADDON_NAME .. ': Visible area POIs:',
    ['LIST_VISIBLE_QUESTS'] = ADDON_NAME .. ': Visible area quests:',
    ['LIST_VISIBLE_BOUNTYBOARDS'] = ADDON_NAME .. ': Maps with currently visible bounty boards:',
    ['HELP_LINE_FILTERPOI'] = '- add a filter for an area POI: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERPOI .. ' id',
    ['HELP_LINE_FILTERVIGNETTE'] = '- add a filter for a vignette: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERVIGNETTE .. ' id',
    ['HELP_LINE_FILTERQUEST'] = '- add a filter for a quest: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERQUEST .. ' id',
    ['HELP_LINE_FILTERBOUNTYBOARD'] = '- add a filter for a bounty board: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERBOUNTYBOARD .. ' id. Use id "current" for the currently shown one.',
    ['HELP_LINE_UNFILTERPOI'] = '- remove a filter for an area POI: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERPOI .. ' id',
    ['HELP_LINE_UNFILTERVIGNETTE'] = '- remove a filter for a vignette: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERVIGNETTE .. ' id',
    ['HELP_LINE_UNFILTERQUEST'] = '- remove a filter for a quest: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERQUEST .. ' id',
    ['HELP_LINE_UNFILTERBOUNTYBOARD'] = '- remove a filter for a bounty boad: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERBOUNTYBOARD .. ' id',
    ['HELP_LINE_LISTVISIBLE'] = '- show currently visible items: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_LISTVISIBLE .. ' -- Note that "currently visible" is badly defined and may include extra items.',
    ['HELP_LINE_LISTVISIBLEALL'] = '- show pretty much all items: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_LISTVISIBLEALL .. ' -- it is strongly recommended to use an Addon like idTip instead!',
    ['HELP_LINE_LISTFILTERED'] = '- show all current filters: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_LISTFILTERED,
    ['HELP_LINE_SHORTCUT'] = 'You can use either ' .. SLASH_MAPCLEANER1 .. ' or ' .. SLASH_MAPCLEANER2 .. '.',
    ['ERROR_NO_SUCH_FILTERED_POI_ID'] = ADDON_NAME .. ': No filtered area POI with id %d ("%s").',
    ['ERROR_NO_SUCH_FILTERED_VIGNETTE_ID'] = ADDON_NAME .. ': No filtered vignette with id %d ("%s").',
    ['ERROR_NO_SUCH_FILTERED_QUEST_ID'] = ADDON_NAME .. ': No filtered quest with id %d ("%s").',
    ['ERROR_NO_SUCH_FILTERED_BOUNTYBOARD_MAPID'] = ADDON_NAME .. ': No filtered bounty board for map %d ("%s").',
  },
  ['deDE'] = {
    ['ADDED_POI'] = ADDON_NAME .. ': POI %s (%d) zur Filterliste hinzugefügt.',
    ['ADDED_VIGNETTE'] = ADDON_NAME .. ': Vignette %s (%d) zur Filterliste hinzugefügt.',
    ['ADDED_QUEST'] = ADDON_NAME .. ': Quest %s (%d) zur Filterliste hinzugefügt.',
    ['ADDED_BOUNTYBOARD'] = ADDON_NAME .. ': Karte %s (%d) zur Filterliste für Weltquestbonusanzeige hinzugefügt.',
    ['ADDED_BOUNTYBOARD_WARN_NO_SUCH'] = ADDON_NAME .. ': Karte %s (%d) zur Filterliste für Weltquestbonusanzeige hinzugefügt. Achtung: Dort war gerade gar keine Anzeige.',
    ['REMOVED_POI'] = ADDON_NAME .. ': POI %s (%d) aus Filterliste gelöscht.',
    ['REMOVED_VIGNETTE'] = ADDON_NAME .. ': Vignette %s (%d) aus Filterliste gelöscht.',
    ['REMOVED_QUEST'] = ADDON_NAME .. ': Quest %s (%d) aus Filterliste gelöscht.',
    ['REMOVED_BOUNTYBOARD'] = ADDON_NAME .. ': Karte %s (%d) aus Filterliste für Weltquestbonusanzeige gelöscht.',
    ['LIST_ITEM_NAME_ID_PAIR'] = '- %s (%d)',
    ['LIST_FILTERED_EMPTY'] = ADDON_NAME .. ': Kein einziger Filter.',
    ['LIST_FILTERED_VIGNETTES'] = ADDON_NAME .. ': Gefilterte Vignetten:',
    ['LIST_FILTERED_POIS'] = ADDON_NAME .. ': Gefilterte Gebiets-POIs:',
    ['LIST_FILTERED_QUESTS'] = ADDON_NAME .. ': Gefilterte Quests:',
    ['LIST_FILTERED_BOUNTYBOARDS'] = ADDON_NAME .. ': Gefilterte Weltquestbonusanzeigen:',
    ['LIST_VISIBLE_EMPTY'] = ADDON_NAME .. ': Kein einziger sichtbarer Gebiets-POI, Vignette oder Quest.',
    ['LIST_VISIBLE_VIGNETTES'] = ADDON_NAME .. ': Sichtbare Vignetten:',
    ['LIST_VISIBLE_POIS'] = ADDON_NAME .. ': Sichtbare Gebiets-POIs:',
    ['LIST_VISIBLE_QUESTS'] = ADDON_NAME .. ': Sichtbare Quests:',
    ['LIST_VISIBLE_BOUNTYBOARDS'] = ADDON_NAME .. ': Karten mit zur Zeit sichtbaren Weltquestbonusanzeigen:',
    ['HELP_LINE_FILTERPOI'] = '- Füge einen Filter für einen Gebiets POI hinzu: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERPOI .. ' id',
    ['HELP_LINE_FILTERVIGNETTE'] = '- Füge einen Filter für eine Vignette hinzu: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERVIGNETTE .. ' id',
    ['HELP_LINE_FILTERQUEST'] = '- Füge einen Filter für eine Quest hinzu: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERQUEST .. ' id',
    ['HELP_LINE_FILTERBOUNTYBOARD'] = '- Füge einen Filter für die Weltquestbonusanzeige einer Weltkarte hinzu: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERBOUNTYBOARD .. ' id. Nutze die ID "current" für die aktuell offene.',
    ['HELP_LINE_UNFILTERPOI'] = '- Entferne einen Filter für einen Gebiets POI: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERPOI .. ' id',
    ['HELP_LINE_UNFILTERVIGNETTE'] = '- Entferne einen Filter für eine Vignette: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERVIGNETTE .. ' id',
    ['HELP_LINE_UNFILTERQUEST'] = '- Entferne einen Filter für eine Quest: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERQUEST .. ' id',
    ['HELP_LINE_UNFILTERBOUNTYBOARD'] = '- Entferne einen Filter für eine Weltquestbonusanzeige: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERBOUNTYBOARD .. ' id',
    ['HELP_LINE_LISTVISIBLE'] = '- Zeige derzeit sichtbare Dinge: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_LISTVISIBLE .. ' -- Beachte, dass "derzeit sichtbar" unklar definiert ist und zusätzliche Dinge gelistet werden können.',
    ['HELP_LINE_LISTVISIBLEALL'] = '- Zeige ziemlich alle Dinge: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_LISTVISIBLEALL .. ' -- Die alternative Nutzung von einem Addon wie idTip ist sehr stark empfohlen!',
    ['HELP_LINE_LISTFILTERED'] = '- Zeige die aktuell eingestellten Filter: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_LISTFILTERED,
    ['HELP_LINE_SHORTCUT'] = 'Du kannst entweder ' .. SLASH_MAPCLEANER1 .. ' oder ' .. SLASH_MAPCLEANER2 .. ' nutzen.',
    ['ERROR_NO_SUCH_FILTERED_POI_ID'] = ADDON_NAME .. ': Kein gefilteter Gebiets-POI mit ID %d ("%s").',
    ['ERROR_NO_SUCH_FILTERED_VIGNETTE_ID'] = ADDON_NAME .. ': Keine gefilterte Vignette mit ID %d ("%s").',
    ['ERROR_NO_SUCH_FILTERED_QUEST_ID'] = ADDON_NAME .. ': Keine gefilterte Quest mit ID %d ("%s").',
    ['ERROR_NO_SUCH_FILTERED_BOUNTYBOARD_MAPID'] = ADDON_NAME .. ': Keine gefilterte Weltquestbonusanzeige für Karte %d ("%s").',
  },
}
local currentLocale = GetLocale()
L.__meta = {}
L.__meta.__index = function(tab, key)
  local sub = rawget(tab, currentLocale) or rawget(tab, 'enUS')
  return rawget(sub, key) or key
end
setmetatable(L, L.__meta)

local RefreshAllDataPoiMixins = {
  [AreaPOIDataProviderMixin.RefreshAllData] = "AreaPOIPinTemplate",
  [AreaPOIEventDataProviderMixin.RefreshAllData] = "AreaPOIEventPinTemplate",
  [QuestOfferDataProviderMixin.RefreshAllData] = "QuestHubPinTemplate",
}
local RefreshAllDataVignetteMixins = {
  [VignetteDataProviderMixin.RefreshAllData] = "VignettePinTemplate",
}
local RefreshAllQuestMixins = {
  [BonusObjectiveDataProviderMixin.RefreshAllData] = {"BonusObjectivePinTemplate", "ThreatObjectivePinTemplate"},
  [QuestDataProviderMixin.RefreshAllData] = {"QuestPinTemplate"},
  [QuestOfferDataProviderMixin.RefreshAllData] = {"QuestOfferPinTemplate"},
}
local poiSources = {
  GetAreaPOIsForPlayerByMapIDCached,
  C_AreaPoiInfo.GetQuestHubsForMap,
  C_AreaPoiInfo.GetEventsForMap,
}

local function removePin(dp, pin)
  --queue if in combat
  removePinImpl[pin.pinTemplate](dp, pin)
end

local function removePinTrivial(pin)
  WorldMapFrame:RemovePin(pin)
end
local function removePinVignetteDataProviderMixin(pin)
--self.vignetteGuidsToPins

    --if pin:IsUnique() then
    --  pin.dataProvider:RemoveUniquePin(pin);
    --end
    --pin:Remove();
    --pin.dataProvider.vignetteGuidsToPins[pin.vignetteGUID] = nil

  --WorldMapFrame.pinPools[pin.pinTemplate]:Release(pin);   --fails with nil somewhere
  pin.dataProvider:RemoveUniquePin(pin)
  pin:Remove()
  --dump(pin)
  --dump(pin.dataProvider.vignetteGuidsToPins)
  pin.dataProvider.vignetteGuidsToPins[pin.vignetteGUID] = nil
  --removePinTrivial(pin)
end

local removePinImpl = {
  AreaPOIEventPinTemplate    = removePinTrivial,
  AreaPOIPinTemplate         = removePinTrivial,
  BonusObjectivePinTemplate  = removePinTrivial,
  QuestHubPinTemplate        = removePinTrivial,
  QuestOfferPinTemplate      = removePinTrivial,
  QuestPinTemplate           = removePinTrivial,
  ThreatObjectivePinTemplate = removePinTrivial,
  VignettePinTemplate        = removePinVignetteDataProviderMixin,
}

function MapCleaner:RemovePin(pinTemplate, pin)
  removePinImpl[pinTemplate](pin)
end

function MapCleaner:FilterTemplateAreaPoi(pinTemplate, pin)
  local areaPoiId = pin.areaPoiID
  return areaPoiId and MAPCLEANER_FILTERED_POIS[areaPoiId] ~= nil
end

function MapCleaner:FilterTemplateQuest(pinTemplate, pin)
  local questId = pin.questId or pin.questID or pin:GetQuestID()
  return questId and MAPCLEANER_FILTERED_QUESTS[questId] ~= nil
end

function MapCleaner:FilterTemplateVignette(pinTemplate, pin)
  local vignetteId = pin:GetVignetteID()
  return vignetteId and MAPCLEANER_FILTERED_VIGNETTES[vignetteId] ~= nil
end

function MapCleaner:FilterTemplateQuestHub(pinTemplate, pin)
  return pin.dataProvider.GetRelatedQuests ~= nil and #pin.dataProvider:GetRelatedQuests() == 0
end

local filterTemplate = {
  AreaPOIEventPinTemplate    = {MapCleaner.FilterTemplateAreaPoi},
  AreaPOIPinTemplate         = {MapCleaner.FilterTemplateAreaPoi},
  BonusObjectivePinTemplate  = {MapCleaner.FilterTemplateQuest},
  QuestHubPinTemplate        = {MapCleaner.FilterTemplateAreaPoi, MapCleaner.FilterTemplateQuestHub},
  QuestOfferPinTemplate      = {MapCleaner.FilterTemplateQuest},
  QuestPinTemplate           = {MapCleaner.FilterTemplateQuest},
  ThreatObjectivePinTemplate = {MapCleaner.FilterTemplateQuest},
  VignettePinTemplate        = {MapCleaner.FilterTemplateVignette},
}

function MapCleaner:DoTemplateUpdates()
  if InCombatLockdown() then
    return self:_DoTemplateUpdatesInNextFrameOrWhenOutOfCombat()
  end
  self.hasDoTemplateUpdatesQueued = false

  for pinTemplate, count in pairs(self.shallDoTemplateUpdate) do
    local filters = filterTemplate[pinTemplate]
   -- print('--',pinTemplate, count)
    if filters then
      for pin in WorldMapFrame:EnumeratePinsByTemplate(pinTemplate) do
        for _, filter in ipairs(filters) do
          -- removes during iteration. bad?
          if filter(self, pinTemplate, pin) then
            self:RemovePin(pinTemplate, pin)
            break
          end
        end
      end
    end
  end
  self.shallDoTemplateUpdate = {}
end

function MapCleaner:_DoTemplateUpdatesInNextFrameOrWhenOutOfCombat()
  self.hasDoTemplateUpdatesQueued = true
  if InCombatLockdown() then
    EventUtil.RegisterOnceFrameEventAndCallback("PLAYER_REGEN_ENABLED", function() self:DoTemplateUpdates() end)
  else
    C_Timer.After(0, function() self:DoTemplateUpdates() end) -- could immediately do stuff here to maybe avoid blinking like in 20y chromie scenario, but come on.
  end
end

function MapCleaner:DoTemplateUpdatesInNextFrameOrWhenOutOfCombat()
  if not self.hasDoTemplateUpdatesQueued then
    self:_DoTemplateUpdatesInNextFrameOrWhenOutOfCombat()
  end
end

function MapCleaner:Startup()
  MAPCLEANER_FILTERED_VIGNETTES = MAPCLEANER_FILTERED_VIGNETTES or {}
  MAPCLEANER_FILTERED_POIS = MAPCLEANER_FILTERED_POIS or {}
  MAPCLEANER_FILTERED_QUESTS = MAPCLEANER_FILTERED_QUESTS or {}
  MAPCLEANER_FILTERS = MAPCLEANER_FILTERS or {}
  MAPCLEANER_FILTERS.bountyBoards = MAPCLEANER_FILTERS.bountyBoards or {}

  self.hasDoTemplateUpdatesQueued = false
  self.shallDoTemplateUpdate = {}

  local pinTemplatesToIgnore = {
    ["HereBeDragonsPinsTemplate"] = true,
    ["HandyNotesWorldMapPinTemplate"] = true,
    ["SilverDragonOverlayWorldMapPinTemplate"] = true,
    ["HandyNotes_WarWithinWorldMapDecorationPinTemplate"] = true,
    ["HandyNotes_WarWithinWorldMapRoutePinTemplate"] = true,
    ["HandyNotes_TheWarWithinWorldMapPinTemplate"] = true,
    ["SilverDragonOverlayRoutePinTemplate"] = true,
    ["PlumberWorldMapPinTemplate"] = true,

    ["AdventureMap_FogPinTemplate"] = true,
    ["AdventureMap_QuestChoicePinTemplate"] = true,
    ["AdventureMap_QuestOfferPinTemplate"] = true,
    ["AdventureMap_ZoneSummaryInsetPinTemplate"] = true,
    ["AdventureMap_ZoneSummaryPinTemplate"] = true,
    ["FlightMap_AreaPOIPinTemplate"] = true,
    ["FlightMap_FlightPointPinTemplate"] = true,
    ["FlightMap_QuestPinTemplate"] = true,
    ["FlightMap_VignettePinTemplate"] = true,
    ["FlightMap_WorldQuestPinTemplate"] = true,
    ["PlunderstormCircleBasePinTemplate"] = true,
    ["PlunderstormInnerCirclePinTemplate"] = true,
    ["PlunderstormOuterCirclePinTemplate"] = true,
    ["WorldMap_DebugObjectPinTemplate"] = true,
    ["WorldMap_DebugPortLocPinTemplate"] = true,

    -- probably
    ["DigSitePinTemplate"] = false,
    ["AreaPOIEventPinTemplate"] = false,
    ["AreaPOIPinTemplate"] = false,
    ["BonusObjectivePinTemplate"] = false,
    ["QuestHubPinTemplate"] = false,
    ["QuestOfferPinTemplate"] = false,
    ["QuestPinTemplate"] = false,

    -- have cvar ignore
    ["DelveEntrancePinTemplate"] = true, -- hide nonbounty?
    ["DragonridingRacePinTemplate"] = true,
    ["FlightPointPinTemplate"] = true,
    ["DungeonEntrancePinTemplate"] = true,
    ["PetTamerPinTemplate"] = true,

    -- essential for gameplay
    ["CorpsePinTemplate"] = true,
    ["BattlefieldFlagPinTemplate"] = true,
    ["DeathReleasePinTemplate"] = true,
    ["GroupMembersPinTemplate"] = true,
    ["SelectableGraveyardPinTemplate"] = true,
    ["WaypointLocationPinTemplate"] = true,
    ["GarrisonPlotPinTemplate"] = true,

    ["FogOfWarPinTemplate"] = false,

    ["AnimaDiversionModelScenePinTemplate"] = false,
    ["AnimaDiversionPinTemplate"] = false,
    ["AnimaDiversion_WorldQuestPinTemplate"] = false,
    ["ContentTrackingPinTemplate"] = false,
    ["ContributionCollectorPinTemplate"] = false,
    ["EncounterJournalPinTemplate"] = false,
    ["EncounterMapTrackingPinTemplate"] = false,
    ["FyrakkFlightVignettePinTemplate"] = false,
    ["GossipPinTemplate"] = false,
    ["InvasionPinTemplate"] = false,
    ["MapExplorationPinTemplate"] = false,
    ["MapHighlightPinTemplate"] = false,
    ["MapLinkPinTemplate"] = false,
    ["QuestBlobPinTemplate"] = false,
    ["ScenarioBlobPinTemplate"] = false,
    ["ScenarioPinTemplate"] = false,
    ["ThreatObjectivePinTemplate"] = false,
    ["VehiclePinTemplate"] = false,
    ["VignettePinTemplate"] = false,
    ["WorldMapInvasionOverlayPinTemplate"] = false,
    ["WorldMapThreatOverlayPinTemplate"] = false,
    ["WorldMap_WorldQuestPinTemplate"] = false,
    ["WorldQuestPinTemplate"] = false,
    ["WorldQuestSpellEffectPinTemplate"] = false,

  }

  hooksecurefunc(WorldMapFrame, "AcquirePin", function(worldMapFrame, pinTemplate, ...)
    if pinTemplatesToIgnore[pinTemplate] then return end
    self.shallDoTemplateUpdate[pinTemplate] = (self.shallDoTemplateUpdate[pinTemplate] or 0) + 1
    self:DoTemplateUpdatesInNextFrameOrWhenOutOfCombat()
  end)

  local orig_MapUtil_ShouldShowTask = nil
  function MapUtil_ShouldShowTask(mapID, info)
    return not (info.isQuestStart and info.inProgress) and
           MAPCLEANER_FILTERED_QUESTS[info.questId or info.questID] == nil
  end

  function post_WorldMapBountyBoardMixin_Refresh(self)
    if MapCleaner:ShouldHideBountyBoardForMap(self:GetMapID()) then
      self:Clear()
    end
  end
  function post_WorldMapActivityTrackerMixin_Refresh(self)
    if MapCleaner:ShouldHideBountyBoardForMap(self:GetMapID()) then
      self:Clear()
    end
  end
  function post_WorldMapThreatFrameMixin_Refresh(self)
    if MapCleaner:ShouldHideBountyBoardForMap(self:GetParent():GetMapID()) then
      self.Background:Hide()
      self.Eye:Hide()
      self.ModelSceneTop:Hide()
      self.ModelSceneBottom:Hide()
    end
  end

  self.refreshPoisDps = {}
  self.refreshVignettesDps = {}
  self.refreshPOIs = function()
    WorldMapFrame:RefreshAll()
  end
  self.refreshVignettes = function()
  -- filtervignette + refresh does not re-add vignettes
    WorldMapFrame:RefreshAll()
  end
  self.refreshQuests = function() WorldMapFrame:RefreshAll() end

  for dp,_ in pairs(WorldMapFrame.dataProviders) do
    -----print('- dp')
    -----dump(dp)
    -----if dp.RefreshAllData then
    -----  local refreshPoiPinTemplate = RefreshAllDataPoiMixins[dp.RefreshAllData]
    -----  if refreshPoiPinTemplate then
    -----   -- print('-- ', refreshPoiPinTemplate)
    -----    hooksecurefunc(dp, "RefreshAllData", makeFilterCallback(dp, refreshPoiPinTemplate, filterByPinAreaPoiID))
    -----    table.insert(self.refreshPoisDps, dp)
    -----  end
-----
    -----  local refreshVignettePinTemplate = RefreshAllDataVignetteMixins[dp.RefreshAllData]
    -----  if refreshVignettePinTemplate then
    -----   -- print('-- ', refreshVignettePinTemplate)
    -----    hooksecurefunc(dp, "RefreshAllData", makeFilterCallback(dp, refreshVignettePinTemplate, filterVignetteDataProviderMixin))
    -----    table.insert(self.refreshVignettesDps, dp)
    -----  end
-----
    -----  local refreshQuestPinTemplates = RefreshAllQuestMixins[dp.RefreshAllData]
    -----  if refreshQuestPinTemplates then
    -----    print('-- ', 'RefreshAllQuestMixins')
    -----    for _, refreshQuestPinTemplate in ipairs(refreshQuestPinTemplates) do
    -----      print('--- ', refreshQuestPinTemplate)
    -----      hooksecurefunc(dp, "RefreshAllData", function()
    -----          for pin in WorldMapFrame:EnumeratePinsByTemplate(refreshQuestPinTemplate) do
    -----            if MAPCLEANER_FILTERED_QUESTS[pin.questId] ~= nil then
    -----              WorldMapFrame:RemovePin(pin)
    -----            end
    -----          end
    -----        end)
    -----    end
    -----    --self.refreshQuests = function() dp:RefreshAllData(false) end --- does not refresh on unhide
    -----  end
    -----end
-----
    -- Flight points are handled by FlightPointDataProviderMixin
    -- Calling quests are handled by BonusObjectiveDataProviderMixin
    -- Campaign (storyline) quests are handled by StorylineQuestDataProviderMixin
    -- World quests are handled by WorldQuestDataProviderMixin
    -- there is Blizzard UI to remove quest objectives, and world quests (albeit by reward)
    -- DO NOT KNOW the following: InvasionDataProviderMixin
    -- TODO: See whether there are other items we can remove from the map - dungeon entrances, treasures, teleportation hubs
    -- DungeonEntranceDataProviderMixin DOES NOT seem to control dungeon entrances

    -----if dp.RefreshAllData and dp.RefreshAllData == BonusObjectiveDataProviderMixin.RefreshAllData then
    -----  orig_MapUtil_ShouldShowTask = MapUtil.ShouldShowTask
    -----  MapUtil.ShouldShowTask = MapUtil_ShouldShowTask
    -----end
  end

  local refreshBountyBoard = function() end
  for _,of in pairs(WorldMapFrame.overlayFrames) do
    if of.Refresh and of.Refresh == WorldMapBountyBoardMixin.Refresh then
      hooksecurefunc(of, "Refresh", post_WorldMapBountyBoardMixin_Refresh)
      local lastRefreshBountyBoard = refreshBountyBoard
      refreshBountyBoard = function() lastRefreshBountyBoard(); of:Refresh() end
    end
    if of.Refresh and of.Refresh == WorldMapThreatFrameMixin.Refresh then
      hooksecurefunc(of, "Refresh", post_WorldMapThreatFrameMixin_Refresh)
      local lastRefreshBountyBoard = refreshBountyBoard
      refreshBountyBoard = function() lastRefreshBountyBoard(); of:Refresh() end
    end
    if of.Refresh and of.Refresh == WorldMapActivityTrackerMixin.Refresh then
      hooksecurefunc(of, "Refresh", post_WorldMapActivityTrackerMixin_Refresh)
      local lastRefreshBountyBoard = refreshBountyBoard
      refreshBountyBoard = function() lastRefreshBountyBoard(); of:Refresh() end
    end
  end
  self.refreshBountyBoard = refreshBountyBoard
end

local PROBABLY_MORE_THAN_MAP_ID = 4000
local function relevantMapIds(reallyAll)
   local best = C_Map.GetBestMapForUnit("player")
   local current = WorldMapFrame and WorldMapFrame:GetMapID()
   current = current ~= best and current or nil

   local all = function(_, lastvalue)
      return lastvalue and lastvalue < PROBABLY_MORE_THAN_MAP_ID and lastvalue + 1 or nil
   end
   local some = function(_, lastvalue)
      return lastvalue == 0 and best or lastvalue == best and current or nil
   end
   return reallyAll and all or some, nil, 0
end

function MapCleaner:TryGetPOIName(poiId, mapIdBegin)
  self.cachedPOINames = self.cachedPOINames or {}
  if self.cachedPOINames[poiId] == nil then
    local mapIdEnd = mapIdBegin or PROBABLY_MORE_THAN_MAP_ID
    mapIdBegin = mapIdBegin or 1

    for mapId = mapIdBegin, mapIdEnd do
      for _, source in pairs(poiSources) do
        for i, pid in ipairs(source(mapId)) do
          if poiId == pid then
            local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapId, poiId)
            if poiInfo then
              self.cachedPOINames[poiId] = poiInfo.name
            end
          end
        end
      end
    end
  end

  return self.cachedPOINames[poiId] or SENTINEL_UNKNOWN_NAME
end

function MapCleaner:AllVisiblePOIs(reallyAll)
  local pois = {}
  for mapId in relevantMapIds(reallyAll) do
    for _, source in pairs(poiSources) do
      for i, poiId in ipairs(source(mapId)) do
        local name = self:TryGetPOIName(poiId, mapId)
        if name ~= nil then
          pois[poiId] = name
        end
      end
    end

    --- C_AreaPoiInfo
  end
  return pois
end

function MapCleaner:AddFilterForPOI(id)
  local name = self:TryGetPOIName(id)

  MAPCLEANER_FILTERED_POIS[id] = name

  self:refreshPOIs()

  print(format(L.ADDED_POI, name, id))
end

function MapCleaner:RemoveFilterForPOI(id)
  if MAPCLEANER_FILTERED_POIS[id] == nil then
    print(format(L.ERROR_NO_SUCH_FILTERED_POI_ID, id, self:TryGetPOIName(id)))
    return
  end

  local name = MAPCLEANER_FILTERED_POIS[id]

  MAPCLEANER_FILTERED_POIS[id] = nil

  self:refreshPOIs()

  print(format(L.REMOVED_POI, name, id))
end

function MapCleaner:TryGetVignetteName(vignetteId)
  self.cachedVignetteNames = self.cachedVignetteNames or {}
  if self.cachedVignetteNames[vignetteId] == nil then
    for i, vignetteGUID in ipairs(C_VignetteInfo.GetVignettes()) do
      local vignetteInfo = C_VignetteInfo.GetVignetteInfo(vignetteGUID)
      if vignetteInfo ~= nil and vignetteInfo.vignetteID == vignetteId then
        self.cachedVignetteNames[vignetteId] = vignetteInfo.name
        break
      end
    end
  end
  return self.cachedVignetteNames[vignetteId] or SENTINEL_UNKNOWN_NAME
end

function MapCleaner:AllVisibleVignettes(reallyAll)
  local vignettes = {}
  -- yes, this is bad complexity, but it ensures cache is populated.
  for _, vignetteGUID in ipairs(C_VignetteInfo.GetVignettes()) do
    local vignetteInfo = C_VignetteInfo.GetVignetteInfo(vignetteGUID)
    if vignetteInfo then
      vignettes[vignetteInfo.vignetteID] = self:TryGetVignetteName(vignetteInfo.vignetteID)
    end
  end
  return vignettes
end

function MapCleaner:AddFilterForVignette(id)
  local name = self:TryGetVignetteName(id)

  MAPCLEANER_FILTERED_VIGNETTES[id] = name

  self:refreshVignettes()

  print(format(L.ADDED_VIGNETTE, name, id))
end

function MapCleaner:RemoveFilterForVignette(id)
  if MAPCLEANER_FILTERED_VIGNETTES[id] == nil then
    print(format(L.ERROR_NO_SUCH_FILTERED_VIGNETTE_ID, id, self:TryGetVignetteName(id)))
    return
  end

  local name = MAPCLEANER_FILTERED_VIGNETTES[id]

  MAPCLEANER_FILTERED_VIGNETTES[id] = nil

  self:refreshVignettes()

  print(format(L.REMOVED_VIGNETTE, name, id))
end

function MapCleaner:TryGetQuestName(questId)
  self.cachedQuestNames = self.cachedQuestNames or {}
  if self.cachedQuestNames[questId] == nil then
    local name = QuestUtils_GetQuestName(questId)
    if name ~= "" then
      self.cachedQuestNames[questId] = name
    end
  end
  return self.cachedQuestNames[questId] or SENTINEL_UNKNOWN_NAME
end

local GetQuestsOnMap = GetQuestsForPlayerByMapIDCached or GetQuestsOnMapCached -- WOW-56487patch11.0.5_XPTR

function MapCleaner:AllVisibleQuests(reallyAll)
  local quests = {}
  for mapId in relevantMapIds(reallyAll) do
    local maybeInfos = GetQuestsOnMap(mapId)
    if maybeInfos then
      for i, info in ipairs(maybeInfos) do
        local questID = info.questId or info.questID
        local name = self:TryGetQuestName(questID, mapId)
        if name ~= nil then
          quests[questID] = name
        end
      end
    end
  end
  return quests
end

function MapCleaner:AddFilterForQuest(id)
  local name = self:TryGetQuestName(id)

  MAPCLEANER_FILTERED_QUESTS[id] = name

  self:refreshQuests()

  print(format(L.ADDED_QUEST, name, id))
end

function MapCleaner:RemoveFilterForQuest(id)
  if MAPCLEANER_FILTERED_QUESTS[id] == nil then
    print(format(L.ERROR_NO_SUCH_FILTERED_QUEST_ID, id, self:TryGetQuestName(id)))
    return
  end

  local name = MAPCLEANER_FILTERED_QUESTS[id]

  MAPCLEANER_FILTERED_QUESTS[id] = nil

  self:refreshQuests()

  print(format(L.REMOVED_QUEST, name, id))
end


function MapCleaner:GetMapName(mapId)
  self.cachedMapNames = self.cachedMapNames or {}
  if self.cachedMapNames[mapId] == nil then
    local name = C_Map.GetMapInfo(mapId).name
    if name ~= "" then
      self.cachedMapNames[mapId] = name
    end
  end
  return self.cachedMapNames[mapId] or SENTINEL_UNKNOWN_NAME
end

function MapCleaner:AllVisibleBountyBoards(reallyAll)
  local mapsWithBountyBoard = {}
  for mapId in relevantMapIds(reallyAll) do
    if MapUtil.MapHasEmissaries(mapId) then
      mapsWithBountyBoard[mapId] = self:GetMapName(mapId)
    end
  end
  return mapsWithBountyBoard
end

function MapCleaner:AddFilterForBountyBoard(mapId)
  local mapName = self:GetMapName(mapId)

  MAPCLEANER_FILTERS.bountyBoards[mapId] = mapName

  self:refreshBountyBoard()

  if MapUtil.MapHasEmissaries(mapId) then
    print(format(L.ADDED_BOUNTYBOARD, mapName, mapId))
  else
    print(format(L.ADDED_BOUNTYBOARD_WARN_NO_SUCH, mapName, mapId))
  end
end

function MapCleaner:RemoveFilterForBountyBoard(mapId)
  if MAPCLEANER_FILTERS.bountyBoards[mapId] == nil then
    print(format(L.ERROR_NO_SUCH_FILTERED_BOUNTYBOARD_MAPID, mapId, self:GetMapName(id)))
    return
  end

  local mapName = MAPCLEANER_FILTERS.bountyBoards[mapId]

  MAPCLEANER_FILTERS.bountyBoards[mapId] = nil

  self:refreshBountyBoard()

  print(format(L.REMOVED_BOUNTYBOARD, mapName, mapId))
end

function MapCleaner:ShouldHideBountyBoardForMap(mapId)
  while mapId ~= nil and mapId ~= 0 do
    if MAPCLEANER_FILTERS.bountyBoards[mapId] then
      return true
    end

    mapId = C_Map.GetMapInfo(mapId).parentMapID
  end

  return false
end

function MapCleaner:ListFiltered()
  local hasVignettes = next(MAPCLEANER_FILTERED_VIGNETTES) ~= nil
  local hasPOIs = next(MAPCLEANER_FILTERED_POIS) ~= nil
  local hasQuests = next(MAPCLEANER_FILTERED_QUESTS) ~= nil
  local hasBountyBoards = next(MAPCLEANER_FILTERS.bountyBoards) ~= nil
  if not hasVignettes and not hasPOIs and not hasQuests and not hasBountyBoards then
    print(format(L.LIST_FILTERED_EMPTY))
  end
  if hasVignettes then
    print(format(L.LIST_FILTERED_VIGNETTES))
    for id, name in pairs(MAPCLEANER_FILTERED_VIGNETTES) do
      if name == SENTINEL_UNKNOWN_NAME then
        name = self:TryGetVignetteName(id)
        MAPCLEANER_FILTERED_VIGNETTES[id] = name
      end
      print(format(L.LIST_ITEM_NAME_ID_PAIR, name, id))
    end
  end
  if hasPOIs then
    print(format(L.LIST_FILTERED_POIS))
    for id, name in pairs(MAPCLEANER_FILTERED_POIS) do
      if name == SENTINEL_UNKNOWN_NAME then
        name = self:TryGetPOIName(id)
        MAPCLEANER_FILTERED_POIS[id] = name
      end
      print(format(L.LIST_ITEM_NAME_ID_PAIR, name, id))
    end
  end
  if hasQuests then
    print(format(L.LIST_FILTERED_QUESTS))
    for id, name in pairs(MAPCLEANER_FILTERED_QUESTS) do
      if name == SENTINEL_UNKNOWN_NAME then
        name = self:TryGetQuestName(id)
        MAPCLEANER_FILTERED_QUESTS[id] = name
      end
      print(format(L.LIST_ITEM_NAME_ID_PAIR, name, id))
    end
  end
  if hasBountyBoards then
    print(format(L.LIST_FILTERED_BOUNTYBOARDS))
    for mapId, mapName in pairs(MAPCLEANER_FILTERS.bountyBoards) do
      if mapName == SENTINEL_UNKNOWN_NAME then
        mapName = self:GetMapName(mapId)
        MAPCLEANER_FILTERS.bountyBoards[mapId] = mapName
      end
      print(format(L.LIST_ITEM_NAME_ID_PAIR, mapName, mapId))
    end
  end
end

function MapCleaner:ListVisible(reallyAll)
  local allVignettes = self:AllVisibleVignettes(reallyAll)
  local allPOIs = self:AllVisiblePOIs(reallyAll)
  local allQuests = self:AllVisibleQuests(reallyAll)
  local allBountyBoards = self:AllVisibleBountyBoards(reallyAll)
  local hasVignettes = next(allVignettes) ~= nil
  local hasPOIs = next(allPOIs) ~= nil
  local hasQuests = next(allQuests) ~= nil
  local hasBountyBoards = next(allQuests) ~= nil
  if not hasVignettes and not hasPOIs and not hasQuests and not hasBountyBoards then
    print(format(L.LIST_VISIBLE_EMPTY))
  end
  if hasVignettes then
    print(format(L.LIST_VISIBLE_VIGNETTES))
    for id, name in pairs(allVignettes) do
      print(format(L.LIST_ITEM_NAME_ID_PAIR, name, id))
    end
  end
  if hasPOIs then
    print(format(L.LIST_VISIBLE_POIS))
    for id, name in pairs(allPOIs) do
      print(format(L.LIST_ITEM_NAME_ID_PAIR, name, id))
    end
  end
  if hasQuests then
    print(format(L.LIST_VISIBLE_QUESTS))
    for id, name in pairs(allQuests) do
      print(format(L.LIST_ITEM_NAME_ID_PAIR, name, id))
    end
  end
  if hasBountyBoards then
    print(format(L.LIST_VISIBLE_BOUNTYBOARDS))
    for id, name in pairs(allBountyBoards) do
      print(format(L.LIST_ITEM_NAME_ID_PAIR, name, id))
    end
  end
end

function MapCleaner:Cli(line)
  line = line:lower()
  local op, rest = line:match("^(%S*)%s*(.-)$")
  if op == COMMAND_FILTERPOI then
    local id = tonumber(rest)
    MapCleaner:AddFilterForPOI(id)
  elseif op == COMMAND_FILTERVIGNETTE then
    local id = tonumber(rest)
    MapCleaner:AddFilterForVignette(id)
  elseif op == COMMAND_UNFILTERPOI then
    local id = tonumber(rest)
    MapCleaner:RemoveFilterForPOI(id)
  elseif op == COMMAND_UNFILTERVIGNETTE then
    local id = tonumber(rest)
    MapCleaner:RemoveFilterForVignette(id)
  elseif op == COMMAND_FILTERQUEST then
    local id = tonumber(rest)
    MapCleaner:AddFilterForQuest(id)
  elseif op == COMMAND_UNFILTERQUEST then
    local id = tonumber(rest)
    MapCleaner:RemoveFilterForQuest(id)
  elseif op == COMMAND_FILTERBOUNTYBOARD then
    local id = rest == 'current' and WorldMapFrame:GetMapID() or tonumber(rest)
    MapCleaner:AddFilterForBountyBoard(id)
  elseif op == COMMAND_UNFILTERBOUNTYBOARD then
    local id = rest == 'current' and WorldMapFrame:GetMapID() or tonumber(rest)
    MapCleaner:RemoveFilterForBountyBoard(id)
  elseif op == COMMAND_LISTFILTERED then
    MapCleaner:ListFiltered()
  elseif op == COMMAND_LISTVISIBLEALL then
    MapCleaner:ListVisible(true)
  elseif op == COMMAND_LISTVISIBLE then
    MapCleaner:ListVisible(false)
  else
    print(ADDON_NAME)
    print(format(L.HELP_LINE_FILTERPOI))
    print(format(L.HELP_LINE_FILTERVIGNETTE))
    print(format(L.HELP_LINE_FILTERQUEST))
    print(format(L.HELP_LINE_FILTERBOUNTYBOARD))
    print(format(L.HELP_LINE_UNFILTERPOI))
    print(format(L.HELP_LINE_UNFILTERVIGNETTE))
    print(format(L.HELP_LINE_UNFILTERQUEST))
    print(format(L.HELP_LINE_UNFILTERBOUNTYBOARD))
    print(format(L.HELP_LINE_LISTVISIBLE))
    print(format(L.HELP_LINE_LISTVISIBLEALL))
    print(format(L.HELP_LINE_LISTFILTERED))
    print(format(L.HELP_LINE_SHORTCUT))
  end
end

SlashCmdList.MAPCLEANER = function(line)
  MapCleaner:Cli(line)
end

EventUtil.ContinueOnAddOnLoaded(ADDON_NAME, function()
  EventUtil.ContinueOnVariablesLoaded(function()
    MapCleaner:Startup()
  end)
end)
