---@meta

---@class _site
---@field currentVersion string Holding the current version of MediaWiki.
---@field scriptPath string The value of [`$wgScriptPath`](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgScriptPath).
---@field server string The value of [`$wgServer`](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgServer).
---@field siteName string The value of [`$wgSitename`].
---@field stylePath string The value of [`$wgStylePath`].
---@field namespaces namespaces Table holding data for all namespaces, indexed by number.
---@field contentNamespaces contentNamespaces Table holding just the content namespaces, indexed by number.
---@field subjectNamespaces subjectNamespaces Table holding just the subject namespaces, indexed by number.
---@field talkNamespaces talkNamespaces Table holding just the talk namespaces, indexed by number.
---@field stats stats Table holding site statistics.
mw.site = {}

---@class subjectNamespace
---@field id integer Namespace number.
---@field name string Local namespace name.
---@field canonicalName string Canonical namespace name.
---@field displayName string Set on namespace 0, the name to be used for display (since the name is often the empty string).
---@field hasSubpages boolean Whether subpages are enabled for the namespace.
---@field hasGenderDistinction boolean Whether the namespace has different aliases for different genders.
---@field isCapitalized boolean Whether the first letter of pages in the namespace is capitalized.
---@field isContent boolean Whether this is a content namespace.
---@field isIncludable boolean Whether pages in the namespace can be transcluded.
---@field isMovable boolean Whether pages in the namespace can be moved.
---@field isSubject boolean Whether this is a subject namespace.
---@field isTalk boolean Whether this is a talk namespace.
---@field defaultContentModel string The default content model for the namespace.
---@field aliases string[] List of aliases for the namespace.
---@field talk talkNamespace Reference to the corresponding talk namespace's data.
---@field associated talkNamespace Reference to the associated namespace's data.
local subject_namespace = {}

---@class talkNamespace
---@field id integer Namespace number.
---@field name string Local namespace name.
---@field canonicalName string Canonical namespace name.
---@field displayName string Set on namespace 0, the name to be used for display (since the name is often the empty string).
---@field hasSubpages boolean Whether subpages are enabled for the namespace.
---@field hasGenderDistinction boolean Whether the namespace has different aliases for different genders.
---@field isCapitalized boolean Whether the first letter of pages in the namespace is capitalized.
---@field isContent boolean Whether this is a content namespace.
---@field isIncludable boolean Whether pages in the namespace can be transcluded.
---@field isMovable boolean Whether pages in the namespace can be moved.
---@field isSubject boolean Whether this is a subject namespace.
---@field isTalk boolean Whether this is a talk namespace.
---@field defaultContentModel string The default content model for the namespace.
---@field aliases string[] List of aliases for the namespace.
---@field subject subjectNamespace Reference to the corresponding subject namespace's data.
---@field associated subjectNamespace Reference to the associated namespace's data.
local talk_namespace = {}

---@class virtualNamespace
---@field id integer Namespace number.
---@field name string Local namespace name.
---@field canonicalName string Canonical namespace name.
---@field displayName string Set on namespace 0, the name to be used for display (since the name is often the empty string).
---@field hasSubpages boolean Whether subpages are enabled for the namespace.
---@field hasGenderDistinction boolean Whether the namespace has different aliases for different genders.
---@field isCapitalized boolean Whether the first letter of pages in the namespace is capitalized.
---@field isContent boolean Whether this is a content namespace.
---@field isIncludable boolean Whether pages in the namespace can be transcluded.
---@field isMovable boolean Whether pages in the namespace can be moved.
---@field isSubject boolean Whether this is a subject namespace.
---@field isTalk boolean Whether this is a talk namespace.
---@field defaultContentModel string The default content model for the namespace.
---@field aliases string[] List of aliases for the namespace.
local virtual_namespace = {}

---@class namespaces: { [integer|string]: subjectNamespace|talkNamespace|virtualNamespace }
---@field [-2] virtualNamespace Special
---@field [-1] virtualNamespace Media
---@field [0] subjectNamespace Main
---@field [1] talkNamespace Talk
---@field Talk talkNamespace Talk
---@field [2] subjectNamespace User
---@field User subjectNamespace User
---@field [3] talkNamespace User Talk
---@field ['User Talk'] talkNamespace User Talk
---@field [4] subjectNamespace Project
---@field Project subjectNamespace Project
---@field [5] talkNamespace Project Talk
---@field ['Project Talk'] talkNamespace Project Talk
---@field [6] subjectNamespace File
---@field File subjectNamespace File
---@field [7] talkNamespace File Talk
---@field ['File Talk'] talkNamespace File Talk
---@field [8] subjectNamespace MediaWiki
---@field MediaWiki subjectNamespace MediaWiki
---@field [9] talkNamespace MediaWiki Talk
---@field ['MediaWiki Talk'] talkNamespace MediaWiki Talk
---@field [10] subjectNamespace Template
---@field Template subjectNamespace Template
---@field [11] talkNamespace Template Talk
---@field ['Template Talk'] talkNamespace Template Talk
---@field [12] subjectNamespace Help
---@field Help subjectNamespace Help
---@field [13] talkNamespace Help Talk
---@field ['Help Talk'] talkNamespace Help Talk
---@field [14] subjectNamespace Category
---@field Category subjectNamespace Category
---@field [15] talkNamespace Category Talk
---@field ['Category Talk'] talkNamespace Category Talk
---@field [828] subjectNamespace Module
---@field Module subjectNamespace Module
---@field [829] talkNamespace Module Talk
---@field ['Module Talk'] talkNamespace Module Talk
local namespaces = {}

---Index should be even positive number.
---@class contentNamespaces: { [integer]: subjectNamespace }
---@field [0] subjectNamespace Main
local content_namespaces = {}

---Index should be even positive number.
---@class subjectNamespaces: { [integer]: subjectNamespace }
---@field [0] subjectNamespace Main
---@field [2] subjectNamespace User
---@field [4] subjectNamespace Project
---@field [6] subjectNamespace File
---@field [8] subjectNamespace MediaWiki
---@field [10] subjectNamespace Template
---@field [12] subjectNamespace Help
---@field [14] subjectNamespace Category
---@field [828] subjectNamespace Module
local subject_namespaces = {}

---Index should be odd positive number.
---@class talkNamespaces: { [integer]: talkNamespace }
---@field [3] talkNamespace User Talk
---@field [5] talkNamespace Project Talk
---@field [7] talkNamespace File Talk
---@field [9] talkNamespace MediaWiki Talk
---@field [11] talkNamespace Template Talk
---@field [13] talkNamespace Help Talk
---@field [15] talkNamespace Category Talk
---@field [829] talkNamespace Module Talk
local talk_namespaces = {}

---@class pagesStats
---@field all integer Total pages, files, and subcategories.
---@field subcats integer Number of subcategories.
---@field files integer Number of files.
---@field pages integer Number of pages.
local pages_stats = {}

---@class interwikiStats
---@field prefix string The interwiki prefix.
---@field url string the URL that the interwiki points to. The page name is represented by the parameter $1.
---@field isProtocolRelative boolean A boolean showing whether the URL is [protocol-relative](https://en.wikipedia.org/wiki/Protocol-relative_URL).
---@field isLocal boolean Whether the URL is for a site in the current project.
---@field isCurrentWiki boolean Whether the URL is for the current wiki.
---@field isTranscludable boolean Whether pages using this interwiki prefix are [transcludable](https://www.mediawiki.org/wiki/Transclusion). This requires [scary transclusion](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgEnableScaryTranscluding), which is disabled on Wikimedia wikis.
---@field isExtraLanguageLink boolean Whether the interwiki is listed in [`$wgExtraInterlanguageLinkPrefixes`](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExtraInterlanguageLinkPrefixes).
---@field displayText string? For links listed in [`$wgExtraInterlanguageLinkPrefixes`](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExtraInterlanguageLinkPrefixes), this is the display text shown for the interlanguage link. Nil if not specified.
---@field tooltip string? For links listed in [`$wgExtraInterlanguageLinkPrefixes`](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExtraInterlanguageLinkPrefixes), this is the tooltip text shown when users hover over the interlanguage link. Nil if not specified.
local interwikiStats = {}

---@class stats
---@field pages integer Number of pages in the wiki.
---@field articles integer Number of articles in the wiki.
---@field files integer Number of files in the wiki.
---@field edits integer Number of edits in the wiki.
---@field users integer Number of users in the wiki.
---@field activeUsers integer Number of active users in the wiki.
---@field admins integer Number of users in group 'sysop' in the wiki.
local stats = {
    ---**This function is [expensive](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExpensiveParserFunctionLimit)**
    ---
    ---Each new category queried will increment the expensive function count.
    ---@param category string
    ---@param which '*'
    ---@return pagesStats pagesStats Statistics about the category.
    ---@overload fun(category: string, which: 'all'|'subcats'|'files'|'files'): integer
    pagesInCategory = function ( category, which ) end,

    ---@param ns string
    ---@return integer value The number of pages in the given namespace (specify by number).
    pagesInNamespace = function ( ns ) end,

    ---@param group string
    ---@return integer value The number of users in the given group.
    usersInGroup = function ( group ) end,

    ---@param filter ('local'|'!local')?
    ---@return { [string]: interwikiStats } interwikiStats A table holding data about available interwiki prefixes.
    interwikiMap = function ( filter ) end,
}
