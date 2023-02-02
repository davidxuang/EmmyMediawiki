---@meta

mw.uri = {
    ---Percent-encodes the string. The default type, `"QUERY"`, encodes spaces using '+' for use in query strings; `"PATH"` encodes spaces as %20; and `"WIKI"` encodes spaces as '_'.
    ---
    ---Note that the "WIKI" format is not entirely reversible, as both spaces and underscores are encoded as '_'.
    ---@param s string
    ---@param enctype ('QUERY'|'PATH'|'WIKI')?
    ---@return string
    encode = function ( s, enctype ) end,

    ---Percent-decodes the string. The default type, `"QUERY"`, decodes '+' to space; `"PATH"` does not perform any extra decoding; and `"WIKI"` decodes '_' to space.
    ---@param s string
    ---@param enctype ('QUERY'|'PATH'|'WIKI')?
    ---@return string
    decode = function ( s, enctype ) end,

    ---Encodes a string for use in a MediaWiki URI fragment.
    ---@param s string
    ---@return string
    anchorEncode = function ( s ) end,

    ---@alias queryTable { [string]: string|number|(string|number|false)[]|false }

    ---Encodes a table as a URI query string. Keys should be strings; values may be strings or numbers, sequence tables, or boolean false.
    ---@param table queryTable
    ---@return string
    buildQueryString = function ( table ) end,

    ---Decodes the query string s to a table. Keys in the string without values will have a value of false; keys repeated multiple times will have sequence tables as values; and others will have strings as values.
    ---
    ---The optional numerical arguments `i` and `j` can be used to specify a substring of `s` to be parsed, rather than the entire string. `i` is the position of the first character of the substring, and defaults to 1. `j` is the position of the last character of the substring, and defaults to the length of the string. Both `i` and `j` can be negative, as in `string.sub`.
    ---@param s string
    ---@param i integer
    ---@param j integer
    parseQueryString = function ( s, i, j ) end,

    ---@param page string
    ---@param query (string|queryTable)?
    ---@return uri uri A URI object for the [canonical URL](https://www.mediawiki.org/wiki/Help:Magic_words#URL_data) for a page
    canonicalUrl = function ( page, query ) end,

    ---@param page string
    ---@param query (string|queryTable)?
    ---@return uri uri A URI object for the [full URL](https://www.mediawiki.org/wiki/Help:Magic_words#URL_data) for a page
    fullUrl = function ( page, query ) end,

    ---@param page string
    ---@param query (string|queryTable)?
    ---@return uri uri A URI object for the [local URL](https://www.mediawiki.org/wiki/Help:Magic_words#URL_data) for a page
    localUrl = function ( page, query ) end,

    ---@alias uriOptions { protocol: string?, user: string?, password: string?, host: string?, port: integer?, path: string?, query: queryTable?, fragment: string?, userInfo: string?, hostPort: string?, authority: string?, queryString: string?, relativePath: string? }

    ---Constructs a new URI object for the passed string or table. See the description of URI objects for the possible fields for the table.
    ---@param s string|uriOptions
    ---@return uri
    new = function ( s ) end,

    ---Validates the passed table (or URI object).
    ---@param table queryTable|uri
    ---@return boolean isValid Whether the table was valid, and on failure a string explaining what problems were found.
    validate = function ( table ) end,
}

---@class uri
---@field protocol string? Protocol/scheme
---@field user string? User
---@field password string? Password
---@field host string? Host name
---@field port integer? Port
---@field path string? Path
---@field query queryTable? As from `mw.uri.parseQueryString`
---@field fragment string? Fragment.
---@field userInfo string User and password
---@field hostPort string Host and port
---@field authority string User, password, host, and port
---@field queryString string Version of the query table
---@field relativePath string Path, query string, and fragment
local uri = {}

---Parses a string into the current URI object. Any fields specified in the string will be replaced in the current object; fields not specified will keep their old values.
---@param s string
---@return uri self
function uri:parse ( s ) end

---Makes a copy of the URI object.
---@return uri self
function uri:clone () end

---Merges the parameters table into the object's query table.
---@param parameters queryTable
---@return uri self
function uri:extend ( parameters ) end
