---@meta

mw.title = {
    ---Test for whether two titles are equal. Note that fragments are ignored in the comparison.
    ---@param a title
    ---@param b title
    ---@return boolean
    equals = function ( a, b ) end,

    ---This compares titles by interwiki prefix (if any) as strings, then by namespace number, then by the unprefixed title text as a string. These string comparisons use Lua's standard `< `operator.
    ---@param a title
    ---@param b title
    ---@return -1|0|1 value Indicates whether the title `a` is less than (-1), equal to (0), or greater than (1) title `b`.
    compare = function ( a, b ) end,

    ---@return title title The title object for the current page.
    getCurrentTitle = function () end,

    ---Creates a new title object.
    ---
    ---If a number `id` is given, an object is created for the title with that page_id. The title referenced will be counted as linked from the current page. If the page_id does not exist, returns nil. The expensive function count will be incremented if the title object created is not for a title that has already been loaded. **This function is [expensive](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExpensiveParserFunctionLimit) when called with an ID.**
    ---
    ---If a string `text` is given instead, an object is created for that title (even if the page does not exist). If the text string does not specify a namespace, `namespace` (which may be any key found in` mw.site.namespaces`) will be used. If the text is not a valid title, nil is returned.
    ---@param text string?
    ---@param namespace string?
    ---@return title title Creates a new title object.
    ---@overload fun(id: integer): title?
    new = function ( text, namespace ) end,

    ---Creates a title object with title `title` in namespace `namespace`, optionally with the specified `fragment` and `interwiki` prefix. `namespace` may be any key found in `mw.site.namespaces`. If the resulting title is not valid, returns nil.
    ---
    ---Note that, unlike `mw.title.new()`, this method will always apply the specified namespace. For example, `mw.title.makeTitle( 'Template', 'Module:Foo' )` will create an object for the page Template:Module:Foo, while `mw.title.new( 'Module:Foo', 'Template' )` will create an object for the page Module:Foo.
    ---@param namespace integer|string
    ---@param title string
    ---@param fragment string?
    ---@param interwiki string?
    ---@return title?
    makeTitle = function ( namespace, title, fragment, interwiki ) end,
}

---A title object has a number of properties and methods. Most of the properties are read-only.
---
---Title objects may be compared using [relational operators](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Relational_operators). `tostring( title )` will return `title.prefixedText`.
---
---Since people find the fact surprising, note that accessing any [expensive](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExpensiveParserFunctionLimit) field on a title object records a "link" to the page (as shown on [Special:WhatLinksHere](https://www.mediawiki.org/wiki/Special:WhatLinksHere), for example). Using the title object's `getContent()` method or accessing the `redirectTarget` field records it as a "transclusion", and accessing the title object's `file` or `fileExists` fields records it as a "file link".
---@class title
---@field id integer The `page_id`. 0 if the page does not exist. **This may be [expensive](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExpensiveParserFunctionLimit).**
---@field interwiki string The interwiki prefix, or the empty string if none.
---@field namespace integer The namespace number.
---@field fragment string The fragment (aka section/anchor linking), or the empty string. May be assigned.
---@field nsText string The text of the namespace for the page.
---@field subjectNsText string The text of the subject namespace for the page.
---@field text string The title of the page, without the namespace or interwiki prefixes.
---@field prefixedText string The title of the page, with the namespace and interwiki prefixes.
---@field fullText string The title of the page, with the namespace and interwiki prefixes and the fragment. Interwiki is not returned if equal to the current.
---@field rootText string If this is a subpage, the title of the root page without prefixes. Otherwise, the same as `title.text`.
---@field baseText string If this is a subpage, the title of the page it is a subpage of without prefixes. Otherwise, the same as `title.text`.
---@field subpageText string If this is a subpage, just the subpage name. Otherwise, the same as `title.text`.
---@field canTalk boolean Whether the page for this title could have a talk page.
---@field exists boolean Whether the page exists. Alias for file.exists for Media-namespace titles. For File-namespace titles this checks the existence of the file description page, not the file itself. **This may be [expensive](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExpensiveParserFunctionLimit).**
---@field file fileMeta
---@field fileExists boolean
---@field isContentPage boolean Whether this title is in a content namespace.
---@field isExternal boolean Whether this title has an interwiki prefix.
---@field isLocal boolean Whether this title is in this project. For example, on the English Wikipedia, any other Wikipedia is considered "local" while Wiktionary and such are not.
---@field isRedirect boolean Whether this is the title for a page that is a redirect. **This may be [expensive](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExpensiveParserFunctionLimit).**
---@field isSpecialPage boolean Whether this is the title for a possible special page (i.e. a page in the Special: namespace).
---@field isSubpage boolean Whether this title is a subpage of some other title.
---@field isTalkPage boolean Whether this is a title for a talk page.
---@field contentModel string The content model for this title, as a string. **This may be [expensive](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExpensiveParserFunctionLimit).**
---@field basePageTitle title The same as `mw.title.makeTitle( title.namespace, title.baseText )`.
---@field rootPageTitle title The same as `mw.title.makeTitle( title.namespace, title.rootText )`.
---@field talkPageTitle title? The same as `mw.title.makeTitle( mw.site.namespaces[title.namespace].talk.id, title.text )`, or nil if this title cannot have a talk page.
---@field subjectPageTitle title The same as `mw.title.makeTitle( mw.site.namespaces[title.namespace].subject.id, title.text )`.
---@field redirectTarget title|false Returns a title object of the target of the redirect page if the page is a redirect and the page exists, returns false otherwise.
---@field protectionLevels { ['string']: string[] }? The page's protection levels. This is a table with keys corresponding to each action (e.g., "edit" and "move"). The table values are arrays, the first item of which is a string containing the protection level. If the page is unprotected, either the table values or the array items will be nil. **This is [expensive](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExpensiveParserFunctionLimit).**
---@field cascadingProtection { restrictions: { ['string']: string[] }, sources: string[] } The cascading protections applicable to the page. This is a table with keys "restrictions" (itself a table with keys like protectionLevels has) and "sources" (an array listing titles where the protections cascade from). If no protections cascade to the page, "restrictions" and "sources" will be empty. **This is [expensive](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExpensiveParserFunctionLimit).**
local title = {
    ---@param title2 string
    ---@return boolean isSubpage Whether this title is a subpage of the given title.
    isSubpageOf = function ( title2 ) end,

    ---@param ns integer|string May be specified by anything that is a key found in `mw.site.namespaces`.
    ---@return boolean inNamespace Whether this title is a subpage of the given title.
    inNamespace = function ( ns ) end,

    ---@param ... integer|string May be specified by anything that is a key found in `mw.site.namespaces`.
    ---@return boolean inNamespaces Whether This title is in any of the given namespaces.
    inNamespaces = function ( ... ) end,

    ---@param ns integer|string May be specified by anything that is a key found in `mw.site.namespaces`.
    ---@return boolean hasNamespace Whether this title's subject namespace is in the given namespace.
    hasSubjectNamespace = function ( ns ) end,

    ---@param text string
    ---@return string title The same as mw.`title.makeTitle( title.namespace, title.text .. '/' .. text )`.
    subPageTitle = function ( text ) end,

    ---@return `title.text` encoded as it would be in a URL.
    partialUrl = function () end,

    ---@param query (string|queryTable)?
    ---@param proto ('http'|'https'|'relative'|'canonical')? May be specified to control the scheme of the resulting url. The default is "relative".
    ---@return string url The full URL for this title.
    fullUrl = function ( query, proto ) end,

    ---@param query (string|queryTable)?
    ---@return string url The local URL for this title.
    localUrl = function ( query ) end,

    ---@param query (string|queryTable)?
    ---@return string url The canonical URL for this title.
    canonicalUrl = function ( query ) end,

    ---@return string content The (unparsed) content of the page, or nil if there is no page. The page will be recorded as a transclusion.
    getContent = function () end,
}

---Title objects representing a page in the File or Media namespace will have a property called `file`. **This is [expensive](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExpensiveParserFunctionLimit).**
---@class fileMeta
---@field exists boolean Whether the file exists. It will be recorded as an image usage. The `fileExists` property on a Title object exists for backwards compatibility reasons and is an alias for this property. If this is `false`, all other file properties will be `nil`.
---@field width integer? The width of the file. If the file contains multiple pages, this is the width of the first page.
---@field height integer? The height of the file. If the file contains multiple pages, this is the height of the first page.
---@field pages { width: integer, height: integer }[]? If the file format supports multiple pages, this is a table containing tables for each page of the file; otherwise, it is `nil`. The [# operator](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Length_operator) can be used to get the number of pages in the file. Each individual page table contains a width and height property.
---@field size integer? The size of the file in bytes.
---@field mimeType string? The [MIME type](https://en.wikipedia.org/wiki/MIME_type) of the file.
---@field length number? The length (duration) of the media file in seconds. Zero for media types which do not support length.
local file_meta = {}
