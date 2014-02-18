


class = require("sunclass")

local SuperClass = class("SuperClass")

function SuperClass:print()
    print("Called a super class")
end

---------------------------------------

local Mixin = class("Mixin")

function Mixin:print()
    print("This will never be called")
end
function Mixin:print2()
    print("Called a mixin")
end

---------------------------------------

local BaseClass = class("BaseClass", SuperClass, Mixin)

function BaseClass:initialize()
    print("Object created")
end

function BaseClass:print()
    self.super:print()
    print("Called a base class")
end

---------------------------------------

local instance = BaseClass:new()
instance:print()
instance:print2()

