---@meta

---@class Site
---@field currentVersion string Holding the current version of MediaWiki.
---@field scriptPath string The value of [`$wgScriptPath`](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgScriptPath).
---@field server string The value of [`$wgServer`](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgServer).
---@field siteName string The value of [`$wgSitename`](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgSitename).
---@field stylePath string The value of [`$wgStylePath`](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgStylePath).
---@field wikiId string A string containing the [wiki ID](https://www.mediawiki.org/wiki/Manual:Wiki_ID).
---@field namespaces _Namespaces Table holding data for all namespaces, indexed by number.
---@field contentNamespaces _ContentNamespaces Table holding just the content namespaces, indexed by number.
---@field subjectNamespaces _SubjectNamespaces Table holding just the subject namespaces, indexed by number.
---@field talkNamespaces _TalkNamespaces Table holding just the talk namespaces, indexed by number.
---@field stats _Stats Table holding site statistics.
mw.site = {}

---@class _SubjectNamespace
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
---@field talk _TalkNamespace Reference to the corresponding talk namespace's data.
---@field associated _TalkNamespace Reference to the associated namespace's data.
local subject_namespace = {}

---@class _TalkNamespace
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
---@field subject _SubjectNamespace Reference to the corresponding subject namespace's data.
---@field associated _SubjectNamespace Reference to the associated namespace's data.
local talk_namespace = {}

---@class _VirtualNamespace
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

---@class _Namespaces: { [string|integer]: _SubjectNamespace|_TalkNamespace|_VirtualNamespace|nil }
---@field [-2] _VirtualNamespace Special
---@field [-1] _VirtualNamespace Media
---@field [0] _SubjectNamespace Main
---@field [1] _TalkNamespace Talk
---@field Talk _TalkNamespace Talk
---@field [2] _SubjectNamespace User
---@field User _SubjectNamespace User
---@field [3] _TalkNamespace User Talk
---@field ['User Talk'] _TalkNamespace User Talk
---@field [4] _SubjectNamespace Project
---@field Project _SubjectNamespace Project
---@field [5] _TalkNamespace Project Talk
---@field ['Project Talk'] _TalkNamespace Project Talk
---@field [6] _SubjectNamespace File
---@field File _SubjectNamespace File
---@field [7] _TalkNamespace File Talk
---@field ['File Talk'] _TalkNamespace File Talk
---@field [8] _SubjectNamespace MediaWiki
---@field MediaWiki _SubjectNamespace MediaWiki
---@field [9] _TalkNamespace MediaWiki Talk
---@field ['MediaWiki Talk'] _TalkNamespace MediaWiki Talk
---@field [10] _SubjectNamespace Template
---@field Template _SubjectNamespace Template
---@field [11] _TalkNamespace Template Talk
---@field ['Template Talk'] _TalkNamespace Template Talk
---@field [12] _SubjectNamespace Help
---@field Help _SubjectNamespace Help
---@field [13] _TalkNamespace Help Talk
---@field ['Help Talk'] _TalkNamespace Help Talk
---@field [14] _SubjectNamespace Category
---@field Category _SubjectNamespace Category
---@field [15] _TalkNamespace Category Talk
---@field ['Category Talk'] _TalkNamespace Category Talk
---@field [828] _SubjectNamespace Module
---@field Module _SubjectNamespace Module
---@field [829] _TalkNamespace Module Talk
---@field ['Module Talk'] _TalkNamespace Module Talk
local namespaces = {}

---Index should be even positive number.
---@class _ContentNamespaces: { [integer]: _SubjectNamespace? }
---@field [0] _SubjectNamespace Main
local content_namespaces = {}

---Index should be even positive number.
---@class _SubjectNamespaces: { [integer]: _SubjectNamespace? }
---@field [0] _SubjectNamespace Main
---@field [2] _SubjectNamespace User
---@field [4] _SubjectNamespace Project
---@field [6] _SubjectNamespace File
---@field [8] _SubjectNamespace MediaWiki
---@field [10] _SubjectNamespace Template
---@field [12] _SubjectNamespace Help
---@field [14] _SubjectNamespace Category
---@field [828] _SubjectNamespace Module
local subject_namespaces = {}

---Index should be odd positive number.
---@class _TalkNamespaces: { [integer]: _TalkNamespace? }
---@field [1] _TalkNamespace Talk
---@field [3] _TalkNamespace User Talk
---@field [5] _TalkNamespace Project Talk
---@field [7] _TalkNamespace File Talk
---@field [9] _TalkNamespace MediaWiki Talk
---@field [11] _TalkNamespace Template Talk
---@field [13] _TalkNamespace Help Talk
---@field [15] _TalkNamespace Category Talk
---@field [829] _TalkNamespace Module Talk
local talk_namespaces = {}

---@class _PagesStats
---@field all integer Total pages, files, and subcategories.
---@field subcats integer Number of subcategories.
---@field files integer Number of files.
---@field pages integer Number of pages.
local pages_stats = {}

---@class _InterwikiStats
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

---@class _Stats
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
    ---@return _PagesStats pagesStats Statistics about the category.
    ---@overload fun(category: string, which: 'all'|'subcats'|'files'|'pages'): integer
    pagesInCategory = function ( category, which ) end,

    ---@param ns integer
    ---@return integer value The number of pages in the given namespace (specify by number).
    pagesInNamespace = function ( ns ) end,

    ---@param group string
    ---@return integer value The number of users in the given group.
    usersInGroup = function ( group ) end,
}

---@param filter 'local'|'!local'|nil
---@return { [string]: _InterwikiStats? } interwikiStats A table holding data about available interwiki prefixes.
mw.site.interwikiMap = function ( filter ) end
