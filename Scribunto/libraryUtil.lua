---@meta

---This library contains methods useful when implementing Scribunto libraries. It may be loaded using:
---```lua
---    local libraryUtil = require( 'libraryUtil' )
---```
libraryUtil = {
    ---Raises an error if `type( arg )` does not match `expectType`. In addition, no error will be raised if `arg` is nil and `nilOk` is true.
    ---@param name string The name of the calling function. This is used in formatting the error message.
    ---@param argIdx integer The position of the argument in the argument list. This is used in formatting the error message.
    ---@param arg any
    ---@param expectType string
    ---@param nilOk boolean?
    checkType = function ( name, argIdx, arg, expectType, nilOk ) end,

    ---Raises an error if `type( arg )` does not match any of the strings in the array `expectTypes`.
    ---
    ---This is for arguments that have more than one valid type.
    ---@param name string The name of the calling function. This is used in formatting the error message.
    ---@param argIdx integer The position of the argument in the argument list. This is used in formatting the error message.
    ---@param arg any
    ---@param expectTypes string[]
    checkTypeMulti = function ( name, argIdx, arg, expectTypes ) end,

    ---Raises an error if `type( value )` does not match `expectType`.
    ---
    ---This is intended for use in implementing a `__newindex` metamethod.
    ---@param index integer This is used in formatting the error message.
    ---@param value any
    ---@param expectType string
    checkTypeForIndex = function ( index, value, expectType ) end,

    ---Raises an error if `type( arg )` does not match `expectType`. In addition, no error will be raised if `arg` is nil and `nilOk` is true.
    ---
    ---This is intended to be used as an equivalent to `libraryUtil.checkType()` in methods called using Lua's "named argument" syntax, `func{ name = value }`.
    ---@param name string The name of the calling function. This is used in formatting the error message.
    ---@param argName string The name of the argument in the argument list. This is used in formatting the error message.
    ---@param arg any
    ---@param expectType string
    ---@param nilOk boolean?
    checkTypeForNamedArg = function ( name, argName, arg, expectType, nilOk ) end,

    ---This is intended for use in implementing "methods" on object tables that are intended to be called with the `obj:method()` syntax. It returns a function that should be called at the top of these methods with the `self` argument and the method name, which will raise an error if that `self` object is not `selfObj`.
    ---
    ---This function will generally be used in a library's constructor function, something like this:
    ---```lua
    ---    function myLibrary.new()
    ---        local obj = {}
    ---        local checkSelf = libraryUtil.makeCheckSelfFunction( 'myLibrary', 'obj', obj, 'myLibrary object' )
    ---
    ---        function obj:method()
    ---            checkSelf( self, 'method' )
    ---        end
    ---
    ---        function obj:method2()
    ---            checkSelf( self, 'method2' )
    ---        end
    ---
    ---        return obj
    ---    end
    ---```
    ---@param libraryName string
    ---@param varName string
    ---@param selfObj any
    ---@param selfObjDesc string
    makeCheckSelfFunction = function ( libraryName, varName, selfObj, selfObjDesc ) end,
}
