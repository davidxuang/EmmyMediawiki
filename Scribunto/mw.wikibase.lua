---@meta

---[Wikibase Client](https://www.mediawiki.org/wiki/Special:MyLanguage/Extension:Wikibase_Client) provides access to localizable structured data, most notably [Wikidata](https://www.wikidata.org/wiki/Special:MyLanguage/Wikidata:Main_Page).
mw.wikibase = {
    entity = {
        ---@enum WikibaseClaimRank
        claimRanks = {
            RANK_DEPRECATED = 0,
            RANK_NORMAL = 1,
            RANK_PREFERRED = 2,
            RANK_TRUTH = 3,
        },

        ---Creates a Wikibase entity object from an entity serialization.
        ---@param data table
        ---@return WikibaseEntity
        create = function ( data ) end,
    },

    ---@param id string?
    ---@return WikibaseEntity? entity
    getEntity = function ( id ) end,

    ---@return string? entityId
    getEntityIdForCurrentPage = function () end,

    ---@param pageTitle string
    ---@param globalSiteId string?
    ---@return string? entityId
    getEntityIdForTitle = function ( pageTitle, globalSiteId ) end,

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

    ---@param itemId string
    ---@param globalSiteId string?
    ---@return string? pageTitle
    getSitelink = function ( itemId, globalSiteId ) end,

    ---@param itemId string
    ---@param globalSiteId string?
    ---@return string[] badges
    getBadges = function ( itemId, globalSiteId ) end,

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

---@class _WikibaseTerm
---@field language string
---@field value string

---@class _WikibaseSitelink
---@field badges string[]
---@field site string
---@field title string

---@class _WikibaseDataValue
---@field type string
---@field value any

---@class _WikibaseSnak
---@field datatype string?
---@field datavalue _WikibaseDataValue?
---@field hash string?
---@field property string
---@field snaktype 'value'|'somevalue'|'novalue'

---@alias wikibaseSnaks { [string]: _WikibaseSnak[]? }

---@class _WikibaseReference
---@field hash string
---@field snaks wikibaseSnaks
---@field ['snaks-order'] string[]

---@class _WikibaseStatement
---@field id string
---@field mainsnak _WikibaseSnak
---@field qualifiers wikibaseSnaks?
---@field ['qualifiers-order'] string[]?
---@field rank 'preferred'|'normal'|'deprecated'
---@field references _WikibaseReference[]?
---@field type 'statement'

---@class _WikibaseFormattedStatements
---@field value string?
---@field label string?

---@class WikibaseEntity
---@field id string
---@field type string
---@field schemaVersion integer
---@field labels { [string]: _WikibaseTerm? }
---@field descriptions { [string]: _WikibaseTerm? }
---@field aliases { [string]: _WikibaseTerm[]? }
---@field sitelinks { [string]: _WikibaseSitelink? }
---@field claims { [string]: _WikibaseStatement[]? }
local wikibase_entity = {}

---@return string id
function wikibase_entity:getId () end

---@param langCode string?
---@return string? label
function wikibase_entity:getLabel ( langCode ) end

---@param langCode string?
---@return string? description
function wikibase_entity:getDescription ( langCode ) end

---@param langCode string?
---@return string? label
---@return string? languageCode
function wikibase_entity:getLabelWithLang ( langCode ) end

---@param langCode string?
---@return string? description
---@return string? languageCode
function wikibase_entity:getDescriptionWithLang ( langCode ) end

---@param globalSiteId string?
---@return string? pageTitle
function wikibase_entity:getSitelink ( globalSiteId ) end

---@return string[] propertyIds
function wikibase_entity:getProperties () end

---@param propertyIdOrLabel string
---@return _WikibaseStatement[] statements
function wikibase_entity:getBestStatements ( propertyIdOrLabel ) end

---@param propertyIdOrLabel string
---@return _WikibaseStatement[] statements
function wikibase_entity:getAllStatements ( propertyIdOrLabel ) end

---@param propertyLabelOrId string
---@param acceptableRanks WikibaseClaimRank[]?
---@return _WikibaseFormattedStatements result
function wikibase_entity:formatPropertyValues ( propertyLabelOrId, acceptableRanks ) end

---@param propertyLabelOrId string
---@param acceptableRanks WikibaseClaimRank[]?
---@return _WikibaseFormattedStatements result
function wikibase_entity:formatStatements ( propertyLabelOrId, acceptableRanks ) end

-- Legacy aliases retained for backward compatibility.
mw.wikibase.getEntityObject = mw.wikibase.getEntity
mw.wikibase.label = mw.wikibase.getLabel
mw.wikibase.description = mw.wikibase.getDescription
mw.wikibase.sitelink = mw.wikibase.getSitelink
