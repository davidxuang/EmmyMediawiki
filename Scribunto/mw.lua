---@meta

---[Documentaion](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Scribunto_libraries)
mw = { getContentLanguage = mw.language.getContentLanguage,
    getLanguage = mw.language.new,

    ---Adds a warning which is displayed above the preview when previewing an edit. `text` is parsed as wikitext.
    ---@param text string
    addWarning = function ( text ) end,

    ---Calls tostring() on all arguments, then concatenates them with tabs as separators.
    ---@return string
    allToString = function ( ... ) end,

    ---Creates a deep copy of a value. All tables (and their metatables) are reconstructed from scratch. Functions are still shared, however.
    ---@generic T
    ---@param value T
    ---@return T
    clone = function ( value ) end,

    ---Returns the current frame object, typically the frame object from the most recent `#invoke`.
    ---@return frame
    getCurrentFrame = function () end,

    ---Adds one to the "expensive parser function" count, and throws an exception if it exceeds the limit (see [`$wgExpensiveParserFunctionLimit`](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:$wgExpensiveParserFunctionLimit)).
    incrementExpensiveFunctionCount = function () end,

    ---@return boolean isSubsting Whether the current `#invoke` is being [substed](https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Substitution), false otherwise. See [Returning text](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Returning_text) above for discussion on differences when substing versus not substing.
    isSubsting = function () end,

    ---Sometimes a module needs large tables of data; for example, a general-purpose module to convert units of measure might need a large table of recognized units and their conversion factors. And sometimes these modules will be used many times in one page. Parsing the large data table for every `{{#invoke:}}` can use a significant amount of time. To avoid this issue, `mw.loadData()` is provided.
    ---
    ---`mw.loadData` works like `require()`, with the following differences:
    ---
    ---* The loaded module is evaluated only once per page, rather than once per `{{#invoke:}}` call.
    ---* The loaded module is not recorded in [`package.loaded`](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#package.loaded).
    ---* The value returned from the loaded module must be a table. Other data types are not supported.
    ---* The returned table (and all subtables) may contain only booleans, numbers, strings, and other tables. Other data types, particularly functions, are not allowed.
    ---* The returned table (and all subtables) may not have a [metatable](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Metatables).
    ---* All table keys must be booleans, numbers, or strings.
    ---* The table actually returned by `mw.loadData()` has metamethods that provide read-only access to the table returned by the module. Since it does not contain the data directly, `pairs()` and `ipairs()` will work but other methods, including `#value`, `next()`, and the functions in the Table library, will not work correctly.
    ---
    ---The hypothetical unit-conversion module mentioned above might store its code in "Module:Convert" and its data in "Module:Convert/data", and "Module:Convert" would use `local data = mw.loadData( 'Module:Convert/data' )` to efficiently load the data.
    ---@param module string
    ---@return any
    loadData = function ( module ) end,

    ---Serializes `object` to a human-readable representation, then returns the resulting string.
    ---@param object any
    ---@return string
    dumpObject = function ( object ) end,

    ---Passes the arguments to `mw.allToString()`, then appends the resulting string to the log buffer.
    ---
    ---In the debug console, the function `print()` is an alias for this function.
    log = function ( ... ) end,

    ---Calls `mw.dumpObject()` and appends the resulting string to the log buffer. If `prefix` is given, it will be added to the log buffer followed by an equals sign before the serialized string is appended (i.e. the logged text will be "prefix = object-string").
    ---@param object any
    ---@param prefix string?
    logObject = function ( object, prefix ) end,
}

---@class frame
local frame = {
    ---A table for accessing the arguments passed to the frame. For example, if a module is called from wikitext with
    ---
    ---```wikitext
    ---{{#invoke:module|function|arg1|arg2|name=arg3}}
    ---```
    ---
    ---then `frame.args[1]` will return `"arg1"`, `frame.args[2]` will return `"arg2"`, and `frame.args['name']` (or `frame.args.name`) will return `"arg3"`. It is also possible to iterate over arguments using `pairs( frame.args )` or `ipairs( frame.args )`. However, due to how Lua implements table iterators, iterating over arguments will return them in an unspecified order, and there's no way to know the original order as they appear in wikitext.
    ---
    ---Note that values in this table are always strings; `tonumber()` may be used to convert them to numbers, if necessary. Keys, however, are numbers even if explicitly supplied in the invocation: `{{#invoke:module|function|1|2=2}}` gives string values `"1"` and `"2"` indexed by numeric keys `1` and `2`.
    ---
    ---As in MediaWiki template invocations, named arguments will have leading and trailing whitespace removed from both the name and the value before they are passed to Lua, whereas unnamed arguments will not have whitespace stripped.
    ---
    ---For performance reasons, frame.args uses a metatable, rather than directly containing the arguments. Argument values are requested from MediaWiki on demand. This means that most other table methods will not work correctly, including `#frame.args`, `next( frame.args )`, and the functions in the Table library.
    ---
    ---If preprocessor syntax such as template invocations and triple-brace arguments are included within an argument to #invoke, they will not be expanded, after being passed to Lua, until their values are being requested in Lua. If certain special tags written in XML notation, such as `<pre>`, `<nowiki>`, `<gallery>` and `<ref>`, are included as arguments to #invoke, then these tags will be converted to "[strip markers](https://www.mediawiki.org/wiki/Strip_marker)" — special strings which begin with a delete character (ASCII 127), to be replaced with HTML after they are returned from #invoke.
    ---@type { [integer|string]: string }
    args = {}
}

---Call a parser function, returning an appropriate string. This is preferable to `frame:preprocess`, but whenever possible, native Lua functions or Scribunto library functions should be preferred to this interface.
---
---The following calls are approximately equivalent to the indicated wikitext:
---```lua
---    -- {{ns:0}}
---    frame:callParserFunction{ name = 'ns', args = 0 }
---
---    -- {{#tag:nowiki|some text}}
---    frame:callParserFunction{ name = '#tag', args = { 'nowiki', 'some text' } }
---    frame:callParserFunction( '#tag', { 'nowiki', 'some text' } )
---    frame:callParserFunction( '#tag', 'nowiki', 'some text' )
---    frame:callParserFunction( '#tag:nowiki', 'some text' )
---
---    -- {{#tag:ref|some text|name=foo|group=bar}}
---    frame:callParserFunction{ name = '#tag:ref', args = {
---            'some text', name = 'foo', group = 'bar'
---    } }
---```
---
---Note that, as with `frame:expandTemplate()`, the function name and arguments are not preprocessed before being passed to the parser function.
---@param name string
---@param args table?
---@return string
---@overload fun(frame: frame, name: string, ...: string): string
---@overload fun(frame: frame, _: { name: string, args: table }): string
function frame:callParserFunction ( name, args ) end

---This is transclusion. The call
---```lua
---    frame:expandTemplate{ title = 'template', args = { 'arg1', 'arg2', name = 'arg3' } }
---```
---does roughly the same thing from Lua that `{{template|arg1|arg2|name=arg3}}` does in wikitext. As in transclusion, if the passed title does not contain a namespace prefix it will be assumed to be in the Template: namespace.
---
---Note that the title and arguments are not preprocessed before being passed into the template:
---```lua
---    -- This is roughly equivalent to wikitext like {{template|{{!}}}}
---    frame:expandTemplate{ title = 'template', args = { '|' } }
---
---    -- This is roughly equivalent to wikitext like {{template|{{((}}!{{))}}}}
---    frame:expandTemplate{ title = 'template', args = { '{{!}}' } }
---```
---@param _ { title: string, args: table }
---@return string
function frame:expandTemplate ( _ ) end

--- This is equivalent to a call to `frame:callParserFunction()` with function name `'#tag:' .. name` and with `content` prepended to `args`.
---```lua
---    -- These are equivalent
---    frame:extensionTag{ name = 'ref', content = 'some text', args = { name = 'foo', group = 'bar' } }
---    frame:extensionTag( 'ref', 'some text', { name = 'foo', group = 'bar' } )
---
---    frame:callParserFunction{ name = '#tag:ref', args = {
---        'some text', name = 'foo', group = 'bar'
---    } }
---
---    -- These are equivalent
---    frame:extensionTag{ name = 'ref', content = 'some text', args = 'some other text' }
---    frame:callParserFunction{ name = '#tag:ref', args = {
---        'some text', 'some other text'
---    } }
---```
---@param name string
---@param content string
---@param args table
---@return string
---@overload fun(frame: frame, _:{ name: string, content: string, args: table }): string
function frame:extensionTag ( name, content, args ) end

---Called on the frame created by `{{#invoke:}}`, returns the frame for the page that called `{{#invoke:}}`. Called on that frame, returns nil.
---
---For instance, if the template `{{Example}}` contains the code `{{#invoke:ModuleName|FunctionName|A|B}}`, and a page transcludes that template with the code `{{Example|C|D}}`, then in Module:ModuleName, calling `frame.args[1]` and `frame.args[2]` returns `"A"` and `"B"`, and calling `frame:getParent().args[1]` and `frame:getParent().args[2]` returns `"C"` and `"D"`, with frame being the first argument in the function call.
---@return frame
function frame:getParent () end

---@return string title The title associated with the frame as a string. For the frame created by `{{#invoke:}}`, this is the title of the module invoked.
function frame:getTitle () end

---Create a new Frame object that is a child of the current frame, with optional arguments and title.
---
---This is mainly intended for use in the debug console for testing functions that would normally be called by `{{#invoke:}}`. The number of frames that may be created at any one time is limited.
---@param _ { title: string, args: table }
---@return frame
function frame:newChild ( _ ) end

---This expands wikitext in the context of the frame, i.e. templates, parser functions, and parameters such as `{{{1}}}` are expanded. Certain special tags written in XML-style notation, such as `<pre>`, `<nowiki>`, `<gallery>` and `<ref>`, will be replaced with "[strip markers](https://www.mediawiki.org/wiki/Special:MyLanguage/strip_marker)" — special strings which begin with a delete character (ASCII 127), to be replaced with HTML after they are returned from `#invoke`.
---
---If you are expanding a single template, use `frame:expandTemplate` instead of trying to construct a wikitext string to pass to this method. It's faster and less prone to error if the arguments contain pipe characters or other wikimarkup.
---
---If you are expanding a single parser function, use `frame:callParserFunction` for the same reasons.
---@param text string
---@return string
---@overload fun(frame: frame, _: { text: string }): string
function frame:preprocess ( text ) end

---@class expand
local expand = {}

---@return string
function expand:expand () end

---@param name string
---@return expand? object An object for the specified argument, or nil if the argument is not provided. The object has one method, `object:expand()`, that returns the expanded wikitext for the argument.
function frame:getArgument ( name ) end

---@param text string
---@return expand object An object with one method, `object:expand()`, that returns the result of `frame:preprocess( text )`.
function frame:newParserValue ( text ) end

---@param _ { title: string, args: table }
---@return expand object An object with one method, `object:expand()`, that returns the result of `frame:expandTemplate` called with the given arguments.
function frame:newTemplateParserValue ( _ ) end

---Same as pairs( frame.args ). Included for backwards compatibility.
function frame:argumentPairs ()
    return pairs ( frame.args )
end
