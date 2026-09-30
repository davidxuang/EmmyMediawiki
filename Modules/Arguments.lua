---@meta Module:Arguments

local p = {}

---@param frame Frame
---@param args { trim: boolean, removeBlanks: boolean, valueFunc: fun(key: any, value: any): any, frameOnly: boolean, parentOnly: boolean, parentFirst: boolean, wrappers: string|string[], readOnly: boolean, noOverwrite: boolean }?
---@return table
function p.getArgs ( frame, args ) end

return p
