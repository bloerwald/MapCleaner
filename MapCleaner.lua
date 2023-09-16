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
local COMMAND_LISTFILTERED = 'listfiltered'
local COMMAND_LISTVISIBLE = 'listvisible'

local L = {
  ['enUS'] = {
    ['ADDED_POI'] = ADDON_NAME .. ': Added POI %s (%d) to filter list.',
    ['ADDED_VIGNETTE'] = ADDON_NAME .. ': Added vignette %s (%d) to filter list.',
    ['ADDED_QUEST'] = ADDON_NAME .. ': Added quest %s (%d) to filter list.',
    ['REMOVED_POI'] = ADDON_NAME .. ': Removed POI %s (%d) from filter list.',
    ['REMOVED_VIGNETTE'] = ADDON_NAME .. ': Removed vignette %s (%d) from filter list.',
    ['REMOVED_QUEST'] = ADDON_NAME .. ': Removed quest %s (%d) from filter list.',
    ['LIST_ITEM_NAME_ID_PAIR'] = '- %s (%d)',
    ['LIST_FILTERED_EMPTY'] = ADDON_NAME .. ': No filters at all.',
    ['LIST_FILTERED_VIGNETTES'] = ADDON_NAME .. ': Filtered vignettes:',
    ['LIST_FILTERED_POIS'] = ADDON_NAME .. ': Filtered area POIs:',
    ['LIST_FILTERED_QUESTS'] = ADDON_NAME .. ': Filtered area quests:',
    ['LIST_VISIBLE_EMPTY'] = ADDON_NAME .. ': No visible vignettes, POIs or quests at all.',
    ['LIST_VISIBLE_VIGNETTES'] = ADDON_NAME .. ': Visible vignettes:',
    ['LIST_VISIBLE_POIS'] = ADDON_NAME .. ': Visible area POIs:',
    ['LIST_VISIBLE_QUESTS'] = ADDON_NAME .. ': Visible area quests:',
    ['HELP_LINE_FILTERPOI'] = '- add a filter for an area POI: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERPOI .. ' id',
    ['HELP_LINE_FILTERVIGNETTE'] = '- add a filter for a vignette: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERVIGNETTE .. ' id',
    ['HELP_LINE_FILTERQUEST'] = '- add a filter for a quest: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERQUEST .. ' id',
    ['HELP_LINE_UNFILTERPOI'] = '- remove a filter for an area POI: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERPOI .. ' id',
    ['HELP_LINE_UNFILTERVIGNETTE'] = '- remove a filter for a vignette: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERVIGNETTE .. ' id',
    ['HELP_LINE_UNFILTERQUEST'] = '- remove a filter for a quest: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERQUEST .. ' id',
    ['HELP_LINE_LISTVISIBLE'] = '- show all currently visible items: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_LISTVISIBLE .. ' -- it is strongly recommended to use an Addon like idTip instead!',
    ['HELP_LINE_LISTFILTERED'] = '- show all current filters: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_LISTFILTERED,
    ['HELP_LINE_SHORTCUT'] = 'You can use either ' .. SLASH_MAPCLEANER1 .. ' or ' .. SLASH_MAPCLEANER2 .. '.',
    ['ERROR_NO_SUCH_FILTERED_POI_ID'] = ADDON_NAME .. ': No filtered area POI with id %d ("%s").',
    ['ERROR_NO_SUCH_FILTERED_VIGNETTE_ID'] = ADDON_NAME .. ': No filtered vignette with id %d ("%s").',
    ['ERROR_NO_SUCH_FILTERED_QUEST_ID'] = ADDON_NAME .. ': No filtered quest with id %d ("%s").',
  },
  ['deDE'] = {
    ['ADDED_POI'] = ADDON_NAME .. ': POI %s (%d) zur Filterliste hinzugefügt.',
    ['ADDED_VIGNETTE'] = ADDON_NAME .. ': Vignette %s (%d) zur Filterliste hinzugefügt.',
    ['ADDED_QUEST'] = ADDON_NAME .. ': Quest %s (%d) zur Filterliste hinzugefügt.',
    ['REMOVED_POI'] = ADDON_NAME .. ': POI %s (%d) aus Filterliste gelöscht.',
    ['REMOVED_VIGNETTE'] = ADDON_NAME .. ': Vignette %s (%d) aus Filterliste gelöscht.',
    ['REMOVED_QUEST'] = ADDON_NAME .. ': Quest %s (%d) aus Filterliste gelöscht.',
    ['LIST_ITEM_NAME_ID_PAIR'] = '- %s (%d)',
    ['LIST_FILTERED_EMPTY'] = ADDON_NAME .. ': Kein einziger Filter.',
    ['LIST_FILTERED_VIGNETTES'] = ADDON_NAME .. ': Gefilterte Vignetten:',
    ['LIST_FILTERED_POIS'] = ADDON_NAME .. ': Gefilterte Gebiets-POIs:',
    ['LIST_FILTERED_QUESTS'] = ADDON_NAME .. ': Gefilterte Quests:',
    ['LIST_VISIBLE_EMPTY'] = ADDON_NAME .. ': Kein einziger sichtbarer Gebiets-POI, Vignette oder Quest.',
    ['LIST_VISIBLE_VIGNETTES'] = ADDON_NAME .. ': Sichtbare Vignetten:',
    ['LIST_VISIBLE_POIS'] = ADDON_NAME .. ': Sichtbare Gebiets-POIs:',
    ['LIST_VISIBLE_QUESTS'] = ADDON_NAME .. ': Sichtbare Quests:',
    ['HELP_LINE_FILTERPOI'] = '- Füge einen Filter für einen Gebiets POI hinzu: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERPOI .. ' id',
    ['HELP_LINE_FILTERVIGNETTE'] = '- Füge einen Filter für eine Vignette hinzu: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERVIGNETTE .. ' id',
    ['HELP_LINE_FILTERQUEST'] = '- Füge einen Filter für eine Quest hinzu: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_FILTERQUEST .. ' id',
    ['HELP_LINE_UNFILTERPOI'] = '- Entferne einen Filter für einen Gebiets POI: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERPOI .. ' id',
    ['HELP_LINE_UNFILTERVIGNETTE'] = '- Entferne einen Filter für eine Vignette: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERVIGNETTE .. ' id',
    ['HELP_LINE_UNFILTERQUEST'] = '- Entferne einen Filter für eine Quest: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_UNFILTERQUEST .. ' id',
    ['HELP_LINE_LISTVISIBLE'] = '- Zeige alle derzeit sichtbaren Dinge: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_LISTVISIBLE .. ' -- Die alternative Nutzung von einem Addon wie idTip ist sehr stark empfohlen!',
    ['HELP_LINE_LISTFILTERED'] = '- Zeige die aktuell eingestellten Filter: ' .. SLASH_MAPCLEANER1 .. ' ' .. COMMAND_LISTFILTERED,
    ['HELP_LINE_SHORTCUT'] = 'Du kannst entweder ' .. SLASH_MAPCLEANER1 .. ' oder ' .. SLASH_MAPCLEANER2 .. ' nutzen.',
    ['ERROR_NO_SUCH_FILTERED_POI_ID'] = ADDON_NAME .. ': Kein gefilteter Gebiets-POI mit ID %d ("%s").',
    ['ERROR_NO_SUCH_FILTERED_VIGNETTE_ID'] = ADDON_NAME .. ': Keine gefilterte Vignette mit ID %d ("%s").',
    ['ERROR_NO_SUCH_FILTERED_QUEST_ID'] = ADDON_NAME .. ': Keine gefilterte Quest mit ID %d ("%s").',
  },
}
local currentLocale = GetLocale()
L.__meta = {}
L.__meta.__index = function(tab, key)
  local l = currentLocale
  if tab[l][key] == nil then
    l = 'enUS'
  end
  return tab[l][key] or key
end
setmetatable(L, L.__meta)

function MapCleaner:Startup()
  MAPCLEANER_FILTERED_VIGNETTES = MAPCLEANER_FILTERED_VIGNETTES or {}
  MAPCLEANER_FILTERED_POIS = MAPCLEANER_FILTERED_POIS or {}
  MAPCLEANER_FILTERED_QUESTS = MAPCLEANER_FILTERED_QUESTS or {}

  local orig_VignetteDataProviderMixin_ShouldShowVignette = nil
  local orig_AreaPOIDataProviderMixin_RefreshAllData = nil
  local orig_MapUtil_ShouldShowTask = nil

  function VignetteDataProviderMixin_ShouldShowVignette(self, vignetteInfo)
     return orig_VignetteDataProviderMixin_ShouldShowVignette(self, vignetteInfo) and
            MAPCLEANER_FILTERED_VIGNETTES[vignetteInfo.vignetteID] == nil
  end

  function AreaPOIDataProviderMixin_RefreshAllData(self, fromOnShow)
    -- Data provider has no "shouldShow()" or alike. RefreshAllData() has a tight
    -- loop without condition. This is a copy with a condition inserted.

    self:RemoveAllData();

    local mapID = self:GetMap():GetMapID();
    local areaPOIs = GetAreaPOIsForPlayerByMapIDCached(mapID);
    for i, areaPoiID in ipairs(areaPOIs) do
      local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapID, areaPoiID);
      if poiInfo then
         if MAPCLEANER_FILTERED_POIS[poiInfo.areaPoiID] == nil then
            poiInfo.dataProvider = self;
            self:GetMap():AcquirePin(self:GetPinTemplate(), poiInfo);
         end
      end
    end
  end

  function MapUtil_ShouldShowTask(mapID, info)
    return orig_MapUtil_ShouldShowTask(mapID, info) and
           MAPCLEANER_FILTERED_QUESTS[info.questId] == nil
  end

  for dp,_ in pairs(WorldMapFrame.dataProviders) do
     if dp.ShouldShowVignette then
        orig_VignetteDataProviderMixin_ShouldShowVignette = dp.ShouldShowVignette
        dp.ShouldShowVignette = VignetteDataProviderMixin_ShouldShowVignette
        self.refreshVignettes = function() dp:RefreshAllData(false) end -- todo: does not work
     end
     if dp.RemoveAllData and dp.RemoveAllData == AreaPOIDataProviderMixin.RemoveAllData then
        orig_AreaPOIDataProviderMixin_RefreshAllData = dp.RefreshAllData
        dp.RefreshAllData = AreaPOIDataProviderMixin_RefreshAllData
        self.refreshPOIs = function() dp:RefreshAllData(false) end
     end
     if dp.RefreshAllData and dp.RefreshAllData == BonusObjectiveDataProviderMixin.RefreshAllData then
        orig_MapUtil_ShouldShowTask = MapUtil.ShouldShowTask
        MapUtil.ShouldShowTask = MapUtil_ShouldShowTask
        self.refreshQuests = function() dp:RefreshAllData(false) end
     end
  end
end

local PROBABLY_MORE_THAN_MAP_ID = 4000

function MapCleaner:TryGetPOIName(poiId, mapIdBegin)
  self.cachedPOINames = self.cachedPOINames or {}
  if self.cachedPOINames[poiId] == nil then
    local mapIdEnd = mapIdBegin or PROBABLY_MORE_THAN_MAP_ID
    mapIdBegin = mapIdBegin or 1

    for mapId = mapIdBegin, mapIdEnd do
      for i, pid in ipairs(GetAreaPOIsForPlayerByMapIDCached(mapId)) do
        if poiId == pid then
          local poiInfo = C_AreaPoiInfo.GetAreaPOIInfo(mapId, poiId)
          if poiInfo then
            self.cachedPOINames[poiId] = poiInfo.name
          end
        end
      end
    end
  end
  return self.cachedPOINames[poiId] or SENTINEL_UNKNOWN_NAME
end

function MapCleaner:AllVisiblePOIs()
  local pois = {}
  for mapId = 1, PROBABLY_MORE_THAN_MAP_ID do
    for i, poiId in ipairs(GetAreaPOIsForPlayerByMapIDCached(mapId)) do
      local name = self:TryGetPOIName(poiId, mapId)
      if name ~= nil then
        pois[poiId] = name
      end
    end
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

function MapCleaner:AllVisibleVignettes()
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

function MapCleaner:AllVisibleQuests()
  local quests = {}
  for mapId = 1, PROBABLY_MORE_THAN_MAP_ID do
    local maybeInfos = GetQuestsForPlayerByMapIDCached(mapId)
    if maybeInfos then
      for i, info in ipairs(maybeInfos) do
        local name = self:TryGetQuestName(info.questId, mapId)
        if name ~= nil then
          quests[info.questId] = name
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

function MapCleaner:ListFiltered()
  local hasVignettes = next(MAPCLEANER_FILTERED_VIGNETTES) ~= nil
  local hasPOIs = next(MAPCLEANER_FILTERED_POIS) ~= nil
  local hasQuests = next(MAPCLEANER_FILTERED_QUESTS) ~= nil
  if not hasVignettes and not hasPOIs and not hasQuests then
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
end

function MapCleaner:ListVisible()
  local allVignettes = self:AllVisibleVignettes()
  local allPOIs = self:AllVisiblePOIs()
  local allQuests = self:AllVisibleQuests()
  local hasVignettes = next(allVignettes) ~= nil
  local hasPOIs = next(allPOIs) ~= nil
  local hasQuests = next(allQuests) ~= nil
  if not hasVignettes and not hasPOIs and not hasQuests then
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
end

function MapCleaner:Cli(line)
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
  elseif op == COMMAND_LISTFILTERED then
    MapCleaner:ListFiltered()
  elseif op == COMMAND_LISTVISIBLE then
    MapCleaner:ListVisible()
  else
    print(ADDON_NAME)
    print(format(L.HELP_LINE_FILTERPOI))
    print(format(L.HELP_LINE_FILTERVIGNETTE))
    print(format(L.HELP_LINE_FILTERQUEST))
    print(format(L.HELP_LINE_UNFILTERPOI))
    print(format(L.HELP_LINE_UNFILTERVIGNETTE))
    print(format(L.HELP_LINE_UNFILTERQUEST))
    print(format(L.HELP_LINE_LISTVISIBLE))
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
