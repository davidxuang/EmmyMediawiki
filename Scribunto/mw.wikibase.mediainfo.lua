---@meta

---[WikibaseMediaInfo](https://www.mediawiki.org/wiki/Special:MyLanguage/Extension:WikibaseMediaInfo) provides access to Wikibase MediaInfo entities. This is supported by [Structured Data on Commons](https://commons.wikimedia.org/wiki/Special:MyLanguage/Commons:Structured_data).
mw.wikibase.mediainfo = {
    ---@param id string?
    ---@return WikibaseMediaInfoEntity? entity
    getEntity = function ( id ) end,

    ---@return string? entityId
    getEntityIdForCurrentPage = function () end,

    ---@param pageTitle string
    ---@return string? entityId
    getEntityIdForTitle = function ( pageTitle ) end,

    ---@param id string?
    ---@return string? url
    getEntityUrl = function ( id ) end,

    ---@param id string?
    ---@return string? label
    getLabel = function ( id ) end,

    ---@param id string?
    ---@return string? label
    ---@return string? languageCode
    getLabelWithLang = function ( id ) end,

    ---@param id string
    ---@param languageCode string
    ---@return string? label
    getLabelByLang = function ( id, languageCode ) end,

    ---@param id string
    ---@param languageCode string
    ---@return string? description
    getDescriptionByLang = function ( id, languageCode ) end,

    ---@param id string?
    ---@return string? description
    getDescription = function ( id ) end,

    ---@param id string?
    ---@return string? description
    ---@return string? languageCode
    getDescriptionWithLang = function ( id ) end,

    ---@param entityIdSerialization string
    ---@return boolean
    isValidEntityId = function ( entityIdSerialization ) end,

    ---@param id string
    ---@return boolean
    entityExists = function ( id ) end,

    ---@param snakSerialization _WikibaseSnak
    ---@return string wikitext
    renderSnak = function ( snakSerialization ) end,

    ---@param snakSerialization _WikibaseSnak
    ---@return string wikitext
    formatValue = function ( snakSerialization ) end,

    ---@param snaksSerialization wikibaseSnaks
    ---@return string wikitext
    renderSnaks = function ( snaksSerialization ) end,

    ---@param snaksSerialization wikibaseSnaks
    ---@return string wikitext
    formatValues = function ( snaksSerialization ) end,

    ---@param propertyLabelOrId string
    ---@return string? propertyId
    resolvePropertyId = function ( propertyLabelOrId ) end,

    ---@return { [string]: integer? }? propertyOrder
    getPropertyOrder = function () end,

    ---@param tableOfPropertyIds string[]
    ---@return string[] propertyIds
    orderProperties = function ( tableOfPropertyIds ) end,

    ---@param entityId string
    ---@param propertyId string
    ---@return _WikibaseStatement[] statements
    getBestStatements = function ( entityId, propertyId ) end,

    ---@param entityId string
    ---@param propertyId string
    ---@return _WikibaseStatement[] statements
    getAllStatements = function ( entityId, propertyId ) end,

    ---@param fromEntityId string
    ---@param propertyId string
    ---@param toIds string[]
    ---@return string|false|nil entityId
    getReferencedEntityId = function ( fromEntityId, propertyId, toIds ) end,

    ---@return string globalSiteId
    getGlobalSiteId = function () end,
}

---@class WikibaseMediaInfoEntity
---@field id string
---@field type string
---@field schemaVersion integer
---@field labels { [string]: _WikibaseTerm? }
---@field descriptions { [string]: _WikibaseTerm? }
---@field aliases { [string]: _WikibaseTerm[]? }
---@field claims { [string]: _WikibaseStatement[]? }
local mediainfo_entity = {}

---@return string id
function mediainfo_entity:getId () end

---@param langCode string?
---@return string? label
function mediainfo_entity:getLabel ( langCode ) end

mediainfo_entity.getCaption = mediainfo_entity.getLabel

---@param langCode string?
---@return string? description
function mediainfo_entity:getDescription ( langCode ) end

---@param langCode string?
---@return string? label
---@return string? languageCode
function mediainfo_entity:getLabelWithLang ( langCode ) end

mediainfo_entity.getCaptionWithLang = mediainfo_entity.getLabelWithLang

---@param langCode string?
---@return string? description
---@return string? languageCode
function mediainfo_entity:getDescriptionWithLang ( langCode ) end

---@return string[] propertyIds
function mediainfo_entity:getProperties () end

---@param propertyIdOrLabel string
---@return _WikibaseStatement[] statements
function mediainfo_entity:getBestStatements ( propertyIdOrLabel ) end

---@param propertyIdOrLabel string
---@return _WikibaseStatement[] statements
function mediainfo_entity:getAllStatements ( propertyIdOrLabel ) end

---@param propertyLabelOrId string
---@param acceptableRanks WikibaseClaimRank[]|WikibaseClaimRank|nil
---@return _WikibaseFormattedStatements result
function mediainfo_entity:formatPropertyValues ( propertyLabelOrId, acceptableRanks ) end

---@param propertyLabelOrId string
---@param acceptableRanks WikibaseClaimRank[]|WikibaseClaimRank|nil
---@return _WikibaseFormattedStatements result
function mediainfo_entity:formatStatements ( propertyLabelOrId, acceptableRanks ) end

mw.wikibase.mediainfo.getCaption = mw.wikibase.mediainfo.getLabel
mw.wikibase.mediainfo.getCaptionWithLang = mw.wikibase.mediainfo.getLabelWithLang
mw.wikibase.mediainfo.getCaptionByLang = mw.wikibase.mediainfo.getLabelByLang
