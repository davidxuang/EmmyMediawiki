---@meta

---@class WikibaseLexemeEntity: WikibaseEntity
local lexeme_entity = {}

---@class WikibaseFormEntity: WikibaseEntity
local form_entity = {}

---@class WikibaseSenseEntity: WikibaseEntity
local sense_entity = {}

---[WikibaseLexeme](https://www.mediawiki.org/wiki/Special:MyLanguage/Extension:WikibaseLexeme) provides access to Wikibase Lexeme entities. This is supported by [Wikidata:Lexicographical](https://www.wikidata.org/wiki/Special:MyLanguage/Wikidata:Lexicographical_data) data.
mw.wikibase.lexeme = {
    entity = {
        lexeme = lexeme_entity,
        form = form_entity,
        sense = sense_entity,
    },

    ---Splits a Lexeme, Form, or Sense ID into its Lexeme ID and optional subentity ID.
    ---@param id string
    ---@return string? lexemeId
    ---@return string? subentityId
    splitLexemeId = function ( id ) end,
}

---@alias _WikibaseLexemeText { [1]: string, [2]: string }

---@return _WikibaseLexemeText[] lemmas
function lexeme_entity:getLemmas () end

---@param languageCode string?
---@return string? lemma
---@return string? languageCode
function lexeme_entity:getLemma ( languageCode ) end

---@return string itemId
function lexeme_entity:getLanguage () end

---@return string itemId
function lexeme_entity:getLexicalCategory () end

---@return WikibaseFormEntity[] forms
function lexeme_entity:getForms () end

---@return WikibaseSenseEntity[] senses
function lexeme_entity:getSenses () end

---@return _WikibaseLexemeText[] representations
function form_entity:getRepresentations () end

---@param languageCode string?
---@return string? representation
---@return string? languageCode
function form_entity:getRepresentation ( languageCode ) end

---@return string[] itemIds
function form_entity:getGrammaticalFeatures () end

---@param itemId string
---@return boolean
function form_entity:hasGrammaticalFeature ( itemId ) end

---@return _WikibaseLexemeText[] glosses
function sense_entity:getGlosses () end

---@param languageCode string?
---@return string? gloss
---@return string? languageCode
function sense_entity:getGloss ( languageCode ) end
