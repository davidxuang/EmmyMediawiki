---@meta

mw.language = {
    ---The full name of the language for the given language code: native name (language autonym) by default, name translated in target language if a value is given for `inLanguage`.
    ---@param code string
    ---@param inLanguage string?
    ---@return string
    fetchLanguageName = function ( code, inLanguage ) end,

    ---Fetch the list of languages known to MediaWiki.
    ---@param inLanguage string? By default the name returned is the language autonym; passing a language code returns all names in that language.
    ---@param include 'all'|'mwfile'|'mw'? By default, only language names known to MediaWiki are returned; passing `'all'` will return all available languages (e.g. from [Extension:CLDR](https://www.mediawiki.org/wiki/Special:MyLanguage/Extension:CLDR)), while passing `'mwfile'` will include only languages having customized messages included with MediaWiki core or enabled extensions. To explicitly select the default, `'mw'` may be passed.
    ---@return { [string]: string } map A table mapping language code to language name.
    fetchLanguageNames = function ( inLanguage, include ) end,

    ---@return lang lang A new language object for the wiki's default content language.
    getContentLanguage = function () end,

    ---@param code string
    ---@return string[] list A list of MediaWiki's fallback language codes for the specified code.
    getFallbacksFor = function ( code ) end,

    ---A language code is "known" if it is a "valid built-in code" (i.e. it returns true for `mw.language.isValidBuiltInCode`) and returns a non-empty string for `mw.language.fetchLanguageName`.
    ---@param code string
    ---@return boolean isKnown A language code is known to MediaWiki.
    isKnownLanguageTag = function ( code ) end,

    ---A language code is "supported" if it is a "valid" code (returns true for `mw.language.isValidCode`), contains no uppercase letters, and has a message file in the currently-running version of MediaWiki.
    ---
    ---It is possible for a language code to be "supported" but not "known" (i.e. returning true for `mw.language.isKnownLanguageTag`). Also note that certain codes are "supported" despite `mw.language.isValidBuiltInCode` returning false.
    ---@param code string
    ---@return boolean isSupported Whether any localisation is available for that language code in MediaWiki.
    isSupportedLanguage = function ( code ) end,

    ---The code may not actually correspond to any known language.
    ---
    ---A language code is a "valid built-in code" if it is a "valid" code (i.e. it returns true for `mw.language.isValidCode`); consists of only ASCII letters, numbers, and hyphens; and is at least two characters long.
    ---
    ---Note that some codes are "supported" (i.e. returning true from `mw.language.isSupportedLanguage`) even though this function returns false.
    ---@param code string
    ---@return boolean isValid Whether a language code is of a valid form for the purposes of internal customisation of MediaWiki.
    isValidBuiltInCode = function ( code ) end,

    ---The code may not actually correspond to any known language.
    ---
    ---A language code is valid if it does not contain certain unsafe characters (colons, single- or double-quotes, slashs, backslashs, angle brackets, ampersands, or ASCII NULs) and is otherwise allowed in a page title.
    ---@param code string
    ---@return boolean isValid Whether a language code string is of a valid form, whether or not it exists. This includes codes which are used solely for customisation via the MediaWiki namespace.
    isValidCode = function ( code ) end,

    ---Creates a new language object. Language objects do not have any publicly accessible properties, but they do have several methods, which are documented below.
    ---
    ---There is a limit on the number of distinct language codes that may be used on a page. Exceeding this limit will result in errors.
    ---@param code string
    ---@return lang
    new = function ( code ) end,
}

---@class lang
local lang

---@return string lang The language code for this language object.
function lang:getCode () end

---@return string[] list A list of MediaWiki's fallback language codes for this language object. Equivalent to `mw.language.getFallbacksFor( lang:getCode()` ).
function lang:getFallbackLanguages () end

---@return boolean isRTL Whether the language is written right-to-left, false if it is written left-to-right.
function lang:isRTL () end

---Converts the string to lowercase, honoring any special rules for the given language.
---
---When the [Ustring library](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Ustring_library) is loaded, the `mw.ustring.lower()` function is implemented as a call to `mw.language.getContentLanguage():lc( s )`.
---@param s string
---@return string
function lang:lc ( s ) end

---Converts the first character of the string to lowercase, as with `lang:lc()`.
---@param s string
---@return string
function lang:lcfirst ( s ) end

---Converts the string to uppercase, honoring any special rules for the given language.
---
---When the [Ustring library](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Ustring_library) is loaded, the `mw.ustring.upper()` function is implemented as a call to `mw.language.getContentLanguage():uc( s )`.
---@param s string
---@return string
function lang:uc ( s ) end

---Converts the first character of the string to uppercase, as with `lang:uc()`.
---@param s string
---@return string
function lang:ucfirst ( s ) end

---Converts the string to a representation appropriate for case-insensitive comparison. Note that the result may not make any sense when displayed.
---@param s string
---@return string
function lang:caseFold ( s ) end

---Formats a number with grouping and decimal separators appropriate for the given language. Given 123456.78, this may produce "123,456.78", "123.456,78", or even something like "١٢٣٬٤٥٦٫٧٨" depending on the language and wiki configuration.
---@param n number
---@param options { noCommafy: boolean }? `noCommafy`: Set true to omit grouping separators and use a dot (`.`) as the decimal separator. Digit transformation may still occur, which may include transforming the decimal separator.
---@return string
function lang:formatNum ( n, options ) end

---Formats a date according to the given format string.
---
---The format string and supported values for timestamp are identical to those for the [#time parser function](https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Extension:ParserFunctions#.23time) from [Extension:ParserFunctions](https://www.mediawiki.org/wiki/Special:MyLanguage/Extension:ParserFunctions). Note however that backslashes may need to be doubled in a Lua string literal, since Lua also uses backslash as an escape character while wikitext does not:
---```lua
---    -- This string literal contains a newline, not the two characters "\n", so it is not equivalent to {{#time:\n}}.
---    lang:formatDate( '\n' )
---
---    -- This is equivalent to {{#time:\n}}, not {{#time:\\n}}.
---    lang:formatDate( '\\n' )
---
---    -- This is equivalent to {{#time:\\n}}, not {{#time:\\\\n}}.
---    lang:formatDate( '\\\\n' )
---```
---@param format string
---@param timestamp string? If omitted, the default is the current time.
---@param localTime boolean? Must be a boolean or nil; if true, the time is formatted in the [wiki's local time](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgLocaltimezone) rather than in UTC.
---@return string
function lang:formatDate ( format, timestamp, localTime ) end

---Breaks a duration in seconds into more human-readable units, e.g. 12345 to 3 hours, 25 minutes and 45 seconds, returning the result as a string.
---@param seconds number
---@param chosenIntervals ('millennia'|'centuries'|'decades'|'years'|'weeks'|'days'|'hours'|'minutes'|'seconds')[]?
---@return string
function lang:formatDuration ( seconds, chosenIntervals ) end

---This takes a number as formatted by `lang:formatNum()` and returns the actual number. In other words, this is basically a language-aware version of `tonumber()`.
---@param s string
---@return number
function lang:parseFormattedNumber ( s ) end

---This chooses the appropriate grammatical form from forms (which must be a sequence table) or `...` based on the number `n`. For example, in English you might use `n .. ' ' .. lang:plural( n, 'sock', 'socks' )` or `n .. ' ' .. lang:plural( n, { 'sock', 'socks' } )` to generate grammatically-correct text whether there is only 1 sock or 200 socks.
---
---The necessary values for the sequence are language-dependent, see [localization of magic words](https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Magic_words#Localization) and [translatewiki's FAQ on PLURAL](https://translatewiki.net/wiki/Special:MyLanguage/FAQ#PLURAL) for some details.
---@param n number
---@param forms string[]
---@return string
---@overload fun(n: number, ...: string)
function lang:convertPlural ( n, forms ) end

lang.plural = lang.convertPlural

---This chooses the appropriate inflected form of `word` for the given inflection code `case`.
---
---The possible values for word and case are language-dependent, see [Special:MyLanguage/Help:Magic words#Localisation](https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Magic_words#Localisation) and [translatewiki:Grammar](https://translatewiki.net/wiki/Special:MyLanguage/Grammar) for some details.
---@param word string
---@param case string
---@return string
function lang:convertGrammar ( word, case ) end

---This chooses the appropriate inflected form of `word` for the given inflection code `case`.
---
---The possible values for word and case are language-dependent, see [Special:MyLanguage/Help:Magic words#Localisation](https://www.mediawiki.org/wiki/Special:MyLanguage/Help:Magic_words#Localisation) and [translatewiki:Grammar](https://translatewiki.net/wiki/Special:MyLanguage/Grammar) for some details.
---@param case string
---@param word string
---@return string
function lang:grammar ( case, word ) end

---Chooses the string corresponding to the gender of `what`, which may be "male", "female", or a registered user name.
---@param what string
---@param masculine string
---@param feminine string
---@param neutral string
---@return string
---@overload fun(what: string, forms: string[])
function lang:gender ( what, masculine, feminine, neutral ) end

---@param direction 'forwards'|'backwards'|'left'|'right'|'up'|'down' \"forwards" and "backwards" returns either "←" or "→" depending on the directionality of the language.
---@return '←'|'→'|'↑'|'↓' char A Unicode arrow character corresponding to `direction`:
function lang:getArrow ( direction ) end

---@return 'ltr'|'rtl' dir Depends on the directionality of the language.
function lang:getDir () end

---@param opposite boolean
---@return string mark A string containing either U+200E (the left-to-right mark) or U+200F (the right-to-left mark), depending on the directionality of the language and whether `opposite` is a true or false value.
function lang:getDirMark ( opposite ) end

---@param opposite boolean
---@return '&lrm;'|'&rlm;' entity \"\&lrm;" or "\&rlm;", depending on the directionality of the language and whether `opposite` is a true or false value.
function lang:getDirMarkEntity ( opposite ) end

---Breaks a duration in seconds into more human-readable units, e.g. 12345 to 3 hours, 25 minutes and 45 seconds, returning the result as a table mapping unit names to numbers.
---@param seconds number
---@param chosenIntervals ('millennia'|'centuries'|'decades'|'years'|'weeks'|'days'|'hours'|'minutes'|'seconds')[]? if given, is a table with values naming the interval units to use in the response. Those unit keywords are also the keys used in the response table. Only units with a non-zero value are set in the response, unless the response would be empty in which case the smallest unit is returned with a value of 0.
---@return string
function lang:getDurationIntervals ( seconds, chosenIntervals ) end
