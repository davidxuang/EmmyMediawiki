---@meta

mw.hash = {
    ---Hashes a string value with the specified algorithm. Valid algorithms may be fetched using `mw.hash.listAlgorithms()`.
    ---@param algo string
    ---@param value string
    ---@return string
    hashValue = function ( algo, value ) end,

    ---@return string[] list A list of supported hashing algorithms, for use in `mw.hash.hashValue()`.
    listAlgorithms = function () end,
}
