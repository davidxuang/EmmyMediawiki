---@meta Module:TableTools

local p = {}

---@param t table
---@param prefix string?
---@param suffix string?
---@return number[]
function p.affixNums ( t, prefix, suffix ) end

---@param t table
---@return table
function p.compressSparseArray ( t ) end

---@param orig table
---@param noMetatable boolean?
---@param alreadySeen table?
---@return table
function p.deepCopy ( orig, noMetatable, alreadySeen ) end

---@param arr1 table
---@param arr2 table
function p.extend ( arr1, arr2 ) end

---@param array any[]
---@param searchElement any
---@param fromIndex integer?
---@return boolean
function p.inArray ( array, searchElement, fromIndex ) end

---@param t table
---@return table
function p.invert ( t ) end

---@param value any
---@return boolean
function p.isArray ( value ) end

---@param value any
---@return boolean
function p.isArrayLike ( value ) end

---@param value any
---@return boolean
function p.isNan ( value ) end

---@param value any
---@return boolean
function p.isPositiveInteger ( value ) end

---@param t table
---@param prefix string?
---@return integer
function p.length ( t, prefix ) end

---@generic any
---@param arr any[]
---@return { [any]: true? }
function p.listToSet ( arr ) end

---@param ... table
---@return table
function p.merge ( ... ) end

---@param t table
---@param compress boolean?
---@return integer
function p.numData ( t, compress ) end

---@param t table
---@return integer[]
function p.numKeys ( t ) end

---@param t table
---@return table
function p.removeDuplicates ( t ) end

---@param t table
---@return table
function p.shallowClone ( t ) end

---@param t table
---@return integer
function p.size ( t ) end

---@generic T: table, K, V
---@param t T
---@param keySort? boolean|nil|fun(a: K, b: K): boolean
---@return fun(table: table<K, V>, index?: K): K, V
---@return T
function p.sortedPairs ( t, keySort ) end

---@param t table
---@param sep string?
---@param i integer?
---@param j integer?
---@return string
function p.sparseConcat ( t, sep, i, j ) end

---@generic T: table, V
---@param t T
---@return fun(table: V[], i?: integer): integer, V
---@return T
---@return integer i
function p.sparseIpairs ( t ) end

return p
