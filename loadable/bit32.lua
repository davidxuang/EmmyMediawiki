---@meta

---This emulation of the Lua 5.2 bit32 library may be loaded using:
---```lua
---    local bit32 = require( 'bit32' )
---```
---
---The bit32 library provides bitwise operations on unsigned 32-bit integers. Input numbers are truncated to integers (in an unspecified manner) and reduced modulo $2^{32}$ so the value is in the range 0 to $2^{32}-1$; return values are also in this range.
---
---When bits are numbered (as in `bit32.extract()`), 0 is the least-significant bit (the one with value $2^0$) and 31 is the most-significant (the one with value $2^{31}$).
local bit32 = {
    ---@param ... number If not given, the result has all bits set.
    ---@return integer bits The [bitwise AND](https://en.wikipedia.org/wiki/Bitwise_operation#AND) of its arguments: the result has a bit set only if that bit is set in all of the arguments.
    band = function ( ... ) end,

    ---@param x number
    ---@return integer bits The [bitwise complement](https://en.wikipedia.org/wiki/Bitwise_operation#NOT) of `x`.
    bnot = function ( x ) end,

    ---@param ... number If not given, the result has all bits clear.
    ---@return integer bits The [bitwise OR](https://en.wikipedia.org/wiki/Bitwise_operation#OR) of its arguments: the result has a bit set if that bit is set in any of the arguments.
    bor = function ( ... ) end,

    ---@param ... number,
    ---@return boolean
    ---Equivalent to `bit32.band( ... ) ~= 0`.
    btest = function ( ... ) end,

    ---@param ... number If not given, the result has all bits clear.
    ---@return integer bits The [bitwise XOR](https://en.wikipedia.org/wiki/Bitwise_operation#XOR) of its arguments: the result has a bit set if that bit is set in an odd number of the arguments.
    bxor = function ( ... ) end,

    ---Extracts `width` bits from `n`, starting with bit `field`. Accessing bits outside of the range 0 to 31 is an error.
    ---@param n number
    ---@param field number
    ---@param width number? The default is 1.
    ---@return integer bits
    extract = function ( n, field, width ) end,

    ---Replaces `width` bits in `n`, starting with bit `field`, with the low `width` bits from `v`. Accessing bits outside of the range 0 to 31 is an error.
    ---@param n number
    ---@param v number
    ---@param field number
    ---@param width number? The default is 1.
    ---@return integer bits
    replace = function ( n, v, field, width ) end,

    ---This is a [logical shift](https://en.wikipedia.org/wiki/Logical_shift): inserted bits are 0. This is generally equivalent to multiplying by $2^{disp}$.
    ---@param n number
    ---@param disp number Value over 31 will result in 0.
    ---@return integer bits The number `n` shifted `disp` bits to the left.
    lshift = function ( n, disp ) end,

    ---This is a [logical shift](https://en.wikipedia.org/wiki/Logical_shift): inserted bits are 0. This is generally equivalent to dividing by $2^{disp}$.
    ---@param n number
    ---@param disp number Value over 31 will result in 0.
    ---@return integer bits The number `n` shifted `disp` bits to the right.
    rshift = function ( n, disp ) end,

    ---This is an [arithmetic shift](https://en.wikipedia.org/wiki/Arithmetic_shift): if `disp` is positive, the inserted bits will be the same as bit 31 in the original number.
    ---@param n number
    ---@param disp number Value over 31 will result in 0 or 4294967295.
    ---@return integer bits The number `n` shifted `disp` bits to the right.
    arshift = function ( n, disp ) end,

    ---Note that rotations are equivalent modulo 32: a rotation of 32 is the same as a rotation of 0, 33 is the same as 1, and so on.
    ---@param n number
    ---@param disp number
    ---@return integer bits The number `n` [rotated](https://en.wikipedia.org/wiki/Bitwise_operation#Rotate_no_carry) `disp` bits to the left.
    lrotate = function ( n, disp ) end,

    ---Note that rotations are equivalent modulo 32: a rotation of 32 is the same as a rotation of 0, 33 is the same as 1, and so on.
    ---@param n number
    ---@param disp number
    ---@return integer bits The number `n` [rotated](https://en.wikipedia.org/wiki/Bitwise_operation#Rotate_no_carry) `disp` bits to the right.
    rrotate = function ( n, disp ) end,
}

return bit32
