---@meta

mw.message = {
    ---Creates a new message object for the given message `key`. The remaining parameters are passed to the new object's `params()` method.
    ---@param key string
    ---@param ... string
    ---@return msg
    new = function ( key, ... ) end,

    ---Creates a new message object for the given messages (the first one that exists will be used).
    ---@param ... string
    ---@return msg
    newFallbackSequence = function ( ... ) end,

    ---Creates a new message object, using the given text directly rather than looking up an internationalized message. The remaining parameters are passed to the new object's `params()` method.
    ---@param msg string
    ---@param ... string
    ---@return msg
    newRawMessage = function ( msg, ... ) end,

    ---@alias rawParam { raw: string }
    ---@alias numParam { num: string }

    ---Wraps the value so that it will not be parsed as wikitext by `msg:parse()`.
    ---@param value string
    ---@return rawParam
    rawParam = function ( value ) end,

    ---Wraps the value so that it will automatically be formatted as by `lang:formatNum()`. Note this does not depend on the Language library actually being available.
    ---@param value number
    ---@return numParam
    numParam = function ( value ) end,

    ---Returns a Language object for the default language.
    ---@return lang
    getDefaultLanguage = function () end,
}

---@class msg
local message

---Add parameters to the message, which may be passed as individual arguments or as a sequence table.
---@param params (string|number|numParam|rawParam)[] If a sequence table is used, parameters must be directly present in the table; references using the [__index metamethod](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Metatables) will not work.
---@return msg self Allow for call chaining.
---@overload fun(msg: msg, ...: string|number|numParam|rawParam)
function message:params ( params ) end

---Like `:params()`, but has the effect of passing all the parameters through `mw.message.rawParam()` first.
---@param params string[]
---@return msg self Allow for call chaining.
---@overload fun(msg: msg, ...: string)
function message:rawParams ( params ) end

---Like `:params()`, but has the effect of passing all the parameters through `mw.message.numParam()` first.
---@param params number[]
---@return msg self Allow for call chaining.
---@overload fun(msg: msg, ...: number)
function message:numParams ( params ) end

---Specifies the language to use when processing the message.
---@param lang string|lang The default is the one returned by `mw.message.getDefaultLanguage()`.
---@return msg self Allow for call chaining.
function message:inLanguage ( lang ) end

---Specifies whether to look up messages in the MediaWiki: namespace (i.e. look in the database), or just use the default messages distributed with MediaWiki.
---@param bool boolean The default is true.
---@return msg self Allow for call chaining.
function message:useDatabase ( bool ) end

---Substitutes the parameters and returns the message wikitext as-is. Template calls and parser functions are intact.
---@return string
function message:plain () end

---@return boolean exists Whether the message key exists.
function message:exists () end

---@return boolean isBlank Whether the message key has content. True if the message key does not exist or the message is the empty string.
function message:isBlank () end

---@return boolean isDisabled Whether the message key is disabled. True if the message key does not exist or if the message is the empty string or the string "-".
function message:isDisabled () end
