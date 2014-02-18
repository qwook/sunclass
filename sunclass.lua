
--------------------------------------------------------------------------------
-- The MIT License (MIT)

-- Copyright (c) 2014 Henry Quoc Tran

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.

--------------------------------------------------------------------------------

_R = {}
function class(name, ...)

    if _R[name] then
        return _R[name]
    end

    local class = {} -- put functions here

    class.__index = function(s, k)
        if (k) == "super" then return setmetatable({},
        { __index =
            function(fake, k)
                local sp_array = class.__super
                for _, _sp in pairs(sp_array) do
                    local sp = _sp
                    while (sp[k] == nil and sp.__super) do
                        sp = sp.__super
                    end
                    if type(sp[k]) == "function" then
                        return function(fake, ...)
                            return sp[k](s, ...)
                        end
                    end
                end
            end
        })
    end

    if class[k] == nil then
        local sp_array = class.__super
        for _, sp in pairs(sp_array) do
            local ret = sp.__index(s, k)
            if ret ~= nil then
                return ret
            end
        end
    end
    return class[k] end
    class.new = function(s, ...) local n = {} local o = setmetatable(n, s) o:initialize(...) return o end
    class.__classname = name
    class.__super = {...} -- put other super classes here

    _R[name] = class

    return class

end

return class
