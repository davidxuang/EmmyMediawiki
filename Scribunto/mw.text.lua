---@meta

---@enum jsonDecodeFlags
local json_decode_flags = {
    none = 0,
    ---Normally JSON's zero-based arrays are renumbered to Lua one-based sequence tables; to prevent this, pass `mw.text.JSON_PRESERVE_KEYS`.
    jsonPreserveKeys = 1,
    ---To relax certain requirements in JSON, such as no terminal comma in arrays or objects, pass `mw.text.JSON_TRY_FIXING`. This is not recommended.
    jsonTryFixing = 2,
    jsonPreserveKeysAndTryFixing = 3,
}

---@enum jsonEncodeFlags
local json_encode_flags = {
    none = 0,
    ---Normally Lua one-based sequence tables are encoded as JSON zero-based arrays; when `mw.text.JSON_PRESERVE_KEYS` is set, zero-based sequence tables are encoded as JSON arrays.
    jsonPreserveKeys = 1,
    jsonPretty = 4,
    jsonPreserveKeysAndPretty = 5,
}

---The text library provides some common text processing functions missing from the String library and the Ustring library. These functions are safe for use with UTF-8 strings
mw.text = {
    JSON_PRESERVE_KEYS = json_decode_flags.jsonPreserveKeys,
    JSON_TRY_FIXING = json_decode_flags.jsonTryFixing,
    JSON_PRETTY = json_encode_flags.jsonPretty,

    ---Replaces [HTML entities](https://en.wikipedia.org/wiki/HTML_entities) in the string with the corresponding characters.
    ---@param s string
    ---@param decodeNamedEntities boolean? If omitted or false, the only named entities recognized are '\&lt;', '\&gt;', '\&amp;', '\&quot;', and '\&nbsp;'. Otherwise, the list of HTML5 named entities to recognize is loaded from PHP's [get_html_translation_table](https://php.net/get_html_translation_table) function.
    ---@return string
    decode = function ( s, decodeNamedEntities ) end,

    ---Replaces characters in a string with [HTML entities](https://en.wikipedia.org/wiki/HTML_entities). Characters '<', '>', '&', '"', and the non-breaking space are replaced with the appropriate named entities; all others are replaced with numeric entities.
    ---@param s string
    ---@param charset string? Should be a string as appropriate to go inside brackets in a Ustring pattern, i.e. the "set" in `[set]`. The default charset is '<>&"\\' ' (the space at the end is the non-breaking space, U+00A0).
    ---@return string
    encode = function ( s, charset ) end,

    ---Decodes a JSON string. `flags` is 0 or a combination (use `+`) of the flags `mw.text.JSON_PRESERVE_KEYS` and `mw.text.JSON_TRY_FIXING`.
    ---
    ---Limitations:
    ---* Decoded JSON arrays may not be Lua sequences if the array contains null values.
    ---* JSON objects will drop keys having null values.
    ---* It is not possible to directly tell whether the input was a JSON array or a JSON object with sequential integer keys.
    ---* A JSON object having sequential integer keys beginning with 1 will decode to the same table structure as a JSON array with the same values, despite these not being at all equivalent, unless `mw.text.JSON_PRESERVE_KEYS` is used.
    ---@param s string
    ---@param flags jsonDecodeFlags?
    ---@return string
    jsonDecode = function ( s, flags ) end,

    ---Encode a JSON string. Errors are raised if the passed value cannot be encoded in JSON. `flags` is 0 or a combination (use `+`) of the flags `mw.text.JSON_PRESERVE_KEYS` and `mw.text.JSON_PRETTY`.
    ---
    ---Limitations:
    ---* Empty tables are always encoded as empty arrays (`[]`), not empty objects (`{ }`).
    ---* Sequence tables cannot be encoded as JSON objects without adding a "dummy" element.
    ---* To produce objects or arrays with nil values, a tricky implementation of the `__pairs` metamethod is required.
    ---* A Lua table having sequential integer keys beginning with 0 will encode as a JSON array, the same as a Lua table having integer keys beginning with 1, unless `mw.text.JSON_PRESERVE_KEYS` is used.
    ---* When both a number and the string representation of that number are used as keys in the same table, behavior is unspecified.
    ---@param value string
    ---@param flags jsonEncodeFlags?
    ---@return string
    jsonEncode = function ( value, flags ) end,

    ---Removes all MediaWiki [strip markers](https://www.mediawiki.org/wiki/Strip_marker) from a string.
    ---@param s string
    ---@return string
    killMarkers = function ( s ) end,

    ---Joins a list, prose-style. In other words, it's like `table.concat()` but with a different separator before the final item.
    ---
    ---The default separator is taken from [MediaWiki:comma-separator](https://www.mediawiki.org/wiki/MediaWiki:Comma-separator) in the wiki's content language, and the default conjunction is [MediaWiki:and](https://www.mediawiki.org/wiki/MediaWiki:And) concatenated with [MediaWiki:word-separator](https://www.mediawiki.org/wiki/MediaWiki:Word-separator).
    ---
    ---Examples, using the default values for the messages:
    ---```lua
    ---   -- Returns the empty string
    ---    mw.text.listToText( { } )
    ---
    ---   -- Returns "1"
    ---   mw.text.listToText( { 1 } )
    ---
    ---   -- Returns "1 and 2"
    ---   mw.text.listToText( { 1, 2 } )
    ---
    ---   -- Returns "1, 2, 3, 4 and 5"
    ---   mw.text.listToText( { 1, 2, 3, 4, 5 } )
    ---
    ---   -- Returns "1; 2; 3; 4 or 5"
    ---   mw.text.listToText( { 1, 2, 3, 4, 5 }, '; ', ' or ' )
    ---```
    ---@param list any[]
    ---@param separator string?
    ---@param conjunction string?
    ---@return string
    listToText = function ( list, separator, conjunction ) end,

    ---Replaces various characters in the string with [HTML entities](https://en.wikipedia.org/wiki/HTML_entities) to prevent their interpretation as wikitext. This includes:
    ---* The following characters: `"`, `&`, `'`, `<`, `=`, `>`, `[`, `]`, `{`, `|`, `}`
    ---* The following characters at the start of the string or immediately after a newline: `#`, `*`, `:`, `;`, space, tab (`\t`)
    ---* Blank lines will have one of the associated newline or carriage return characters escaped
    ---* `----` at the start of the string or immediately after a newline will have the first `-` escaped
    ---* `__` will have one underscore escaped
    ---* `://` will have the colon escaped
    ---* A whitespace character following `ISBN`, `RFC`, or `PMID` will be escaped
    ---@param s string
    ---@return string
    nowiki = function ( s ) end,

    ---Splits the string into substrings at boundaries matching the Ustring pattern pattern.
    ---@param s string
    ---@param pattern string? If matches the empty string, `s` will be split into individual characters.
    ---@param plain boolean? If specified and true, `pattern` will be interpreted as a literal string rather than as a Lua pattern (just as with the parameter of the same name for `mw.ustring.find()`). For example, `mw.text.split( 'a b\tc\nd', '%s' )` would return a table `{ 'a', 'b', 'c', 'd' }`.
    ---@return string[] list table containing the substrings.
    split = function ( s, pattern, plain ) end,

    ---@return fun(): string iterator An iterator function that will iterate over the substrings that would be returned by the equivalent call to `mw.text.split()`.
    gsplit = function ( s, pattern, plain ) end,

    ---Generates an HTML-style tag for `name`.
    ---
    ---For properly returning extension tags such as `<ref>`, use `frame:extensionTag()` instead.
    ---@param name string
    ---@param attrs { [string]: string|number|boolean }? String and number values are used as the value of the attribute; boolean true results in the key being output as an HTML5 valueless parameter; boolean false skips the key entirely; and anything else is an error.
    ---@param content (string|number|false)? If not given (or is nil), only the opening tag is returned. If boolean false, a self-closed tag is returned. Otherwise must be a string or number, in which case that content is enclosed in the constructed opening and closing tag. Note the content is not automatically HTML-encoded; use `mw.text.encode()` if needed.
    ---@return string
    ---@overload fun(_: { name: string, attrs: { [string]: string|number|boolean }, content: string|number|false }): string
    tag = function ( name, attrs, content ) end,

    ---Remove whitespace or other characters from the beginning and end of a string.
    ---@param s string
    ---@param charset string? If supplied, it should be a string as appropriate to go inside brackets in a Ustring pattern, i.e. the "set" in `[set]`. The default charset is ASCII whitespace, "\t\r\n\f ".
    ---@return string
    trim = function ( s, charset ) end,

    ---Truncates text to the specified length in code points, adding `ellipsis` if truncation was performed.
    ---
    ---Examples, using the default "..." ellipsis:
    ---```lua
    ---    -- Returns "foobarbaz"
    ---    mw.text.truncate( "foobarbaz", 9 )
    ---
    ---    -- Returns "fooba..."
    ---    mw.text.truncate( "foobarbaz", 5 )
    ---
    ---    -- Returns "...arbaz"
    ---    mw.text.truncate( "foobarbaz", -5 )
    ---
    ---    -- Returns "foo..."
    ---    mw.text.truncate( "foobarbaz", 6, nil, true )
    ---
    ---    -- Returns "foobarbaz", because that's shorter than "foobarba..."
    ---    mw.text.truncate( "foobarbaz", 8 )
    ---```
    ---@param text string
    ---@param length integer If positive, the end of the string will be truncated; if negative, the beginning will be removed.
    ---@param ellipsis string? Default value is taken from [MediaWiki:ellipsis](https://www.mediawiki.org/wiki/MediaWiki:Ellipsis) in the wiki's content language.
    ---@param adjustLength boolean? If given and true, the resulting string including ellipsis will not be longer than the specified length.
    ---@return string
    truncate = function ( text, length, ellipsis, adjustLength ) end,

    ---Replaces MediaWiki <nowiki> [strip markers](https://www.mediawiki.org/wiki/Strip_marker) with the corresponding text. Other types of strip markers are not changed.
    ---@param s string
    ---@return string
    unstripNoWiki = function ( s ) end,

    ---Equivalent to `mw.text.killMarkers( mw.text.unstripNoWiki( s ) )`.
    ---
    ---This no longer reveals the HTML behind special page transclusion, <ref> tags, and so on as it did in earlier versions of Scribunto.
    ---@param s string
    ---@return string
    unstrip = function ( s ) end,
}
