---@meta

mw.html = {
    ---Creates a new mw.html object containing a `tagName` html element. You can also pass an empty string or nil as `tagName` in order to create an empty mw.html object.
    ---
    ---`args` can be a table with the following keys:
    ---
    ---* `args.selfClosing`: Force the current tag to be self-closing, even if mw.html doesn't recognize it as self-closing
    ---* `args.parent`: Parent of the current mw.html instance (intended for internal usage)
    ---@param tagName string?
    ---@param args { selfClosing?: boolean, parent?: Html }?
    ---@return Html
    create = function ( tagName, args ) end
}

---@class Html
local html

---Appends a child mw.html (`builder`) node to the current mw.html instance. If a nil parameter is passed, this is a no-op. A (`builder`) node is a string representation of an html element.
---@param builder Html?
---@return Html self
function html:node ( builder ) end

---Appends an undetermined number of wikitext strings to the mw.html object.
---
---Note that this stops at the first *nil* item.
---@param ... string|number|nil
---@return Html self
function html:wikitext ( ... ) end

---Appends a newline to the mw.html object.
---@return Html self
function html:newline () end

---Appends a new child node with the given `tagName` to the builder, and returns a mw.html instance representing that new node. The `args` parameter is identical to that of `mw.html.create`
---
---Note that contrarily to other methods such as `html:node()`, this method doesn't return the current mw.html instance, but the mw.html instance of the newly inserted tag. Make sure to use `html:done()` to go up to the parent mw.html instance, or `html:allDone()` if you have nested tags on several levels.
---@param tagName string
---@param args { selfClosing?: boolean, parent?: Html }?
---@return Html self
function html:tag ( tagName, args ) end

---Set an HTML attribute with the given `name` and `value` on the node. Alternatively a table holding name->value pairs of attributes to set can be passed. In the first form, a value of nil causes any attribute with the given name to be unset if it was previously set.
---@param name string
---@param value string|number|nil
---@return Html self
---@overload fun(html: Html, table: table): Html
function html:attr ( name, value ) end

---Get the value of a html attribute previously set using html:attr() with the given name.
---@param name string
---@return string?
function html:getAttr ( name ) end

---Adds a class name to the node's class attribute. If a nil parameter is passed, this is a no-op.
---@param class string?
---@return Html self
function html:addClass ( class ) end

---Set a CSS property with the given `name` and `value` on the node. Alternatively a table holding name->value pairs of properties to set can be passed. In the first form, a value of nil causes any property with the given name to be unset if it was previously set.
---@param name string
---@param value string?
---@return Html self
---@overload fun(html: Html, table: table): Html
function html:css ( name, value ) end

---Add some raw `css` to the node's style attribute. If a nil parameter is passed, this is a no-op.
---@param css string?
---@return Html self
function html:cssText ( css ) end

---@return Html self The parent node under which the current node was created. Like jQuery.end, this is a convenience function to allow the construction of several child nodes to be chained together into a single statement.
function html:done () end

---Like `html:done()`, but traverses all the way to the root node of the tree and returns it.
---@return Html self
function html:allDone () end
