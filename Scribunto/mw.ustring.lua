---@meta

---@class _ustring
---@field maxPatternLength integer The maximum allowed length of a pattern, in bytes.
---@field maxStringLength integer The maximum allowed length of a string, in bytes.
---[Ustring patterns](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Ustring_patterns)
mw.ustring = {
    byte = string.byte,
    rep = string.rep,
    format = string.format,

    ---@param s string
    ---@param l integer? The default is 1. The character at `l == 1` is the first character starting at or after byte i; the character at `l == 0` is the first character starting at or before byte `i`. Note this may be the same character. Greater or lesser values of `l` are calculated relative to these.
    ---@param i integer? The default is 1. May be negative, in which case it counts from the end of the string.
    ---@return integer offset The byte offset of a character in the string.
    byteoffset = function ( s, l, i ) end,

    ---Much like `string.char()`, except that the integers are Unicode codepoints rather than byte values.
    ---@param ... integer
    ---@return string
    char = function ( ... ) end,

    ---Much like `string.byte()`, except that the return values are codepoints and the offsets are characters rather than bytes.
    ---@param s string
    ---@param i integer?
    ---@param j integer?
    ---@return integer
    codepoint = function ( s, i, j ) end,

    ---Much like `string.find()`, except that the pattern is extended as described in Ustring patterns and the init offset is in characters rather than bytes.
    ---@param s string
    ---@param pattern string
    ---@param init integer?
    ---@param plain boolean?
    ---@return integer start
    ---@return integer end
    find = function ( s, pattern, init, plain ) end,

    ---Returns three values for iterating over the codepoints in the string. i defaults to 1, and j to -1. This is intended for use in the iterator form of for:
    ---@param s string
    ---@param i integer?
    ---@param j integer?
    ---@return fun(): integer
    gcodepoint = function ( s, i, j ) end,

    ---Much like `string.gmatch()`, except that the pattern is extended as described in Ustring patterns.
    ---@param s string
    ---@param pattern string
    ---@return fun(): string
    gmatch = function ( s, pattern ) end,

    ---Much like `string.gsub()`, except that the pattern is extended as described in Ustring patterns.
    ---@param s string
    ---@param pattern string
    ---@param repl string|number|function|table
    ---@param n? integer
    ---@return string
    ---@return integer count
    gsub = function ( s, pattern, repl, n ) end,

    ---@param s string
    ---@return boolean isutf8 Whether the string is valid UTF-8.
    isutf8 = function ( s ) end,

    ---See string.len() for a similar function that uses byte length rather than codepoints.
    ---@param s string
    ---@return integer? length The length of the string in codepoints, or nil if the string is not valid UTF-8.
    len = function ( s ) end,

    ---Much like `string.lower()`, except that all characters with lowercase to uppercase definitions in Unicode are converted.
    ---
    ---If the Language library is also loaded, this will instead call `lc()` on the default language object.
    ---@param s string
    ---@return string
    lower = function ( s ) end,

    ---Much like `string.match()`, except that the pattern is extended as described in Ustring patterns and the init offset is in characters rather than bytes.
    ---@param s string
    ---@param pattern string
    ---@param init integer?
    ---@return string? result Nil if the string is not valid UTF-8.
    match = function ( s, pattern, init ) end,

    ---Much like `string.sub()`, except that the offsets are characters rather than bytes.
    ---@param s string
    ---@param i integer
    ---@param j integer?
    ---@return string
    sub = function ( s, i, j ) end,

    ---Converts the string to [Normalization Form C](https://en.wikipedia.org/wiki/Normalization_Form_C).
    ---@param s string
    ---@return string? result Nil if the string is not valid UTF-8.
    toNFC = function ( s ) end,

    ---Converts the string to [Normalization Form D](https://en.wikipedia.org/wiki/Normalization_Form_D).
    ---@param s string
    ---@return string? result Nil if the string is not valid UTF-8.
    toNFD = function ( s ) end,

    ---Much like `string.upper()`, except that all characters with uppercase to lowercase definitions in Unicode are converted.
    ---
    ---If the Language library is also loaded, this will instead call `uc()` on the default language object.
    ---@param s string
    ---@return string
    upper = function ( s ) end,
}
