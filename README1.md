# Sunclass
Yet another class library for Lua.

* **Mixins / Multiple Inheritance**
* **Invoking superclass methods**
* **Simple, intuitive, easy to use and install**

### How to install
Drag and drop sunclass.lua into your project directory,
then add this line to your code:

	class = require("sunclass")
	
### Simple class

	local SimpleClass = class("SimpleClass")
	
	-- constructor, automatically called
	function SimpleClass:initialize()
	end
	
	function SimpleClass:classMethod()
	end
	
	local instance = SimpleClass:new()
	instance:classMethod()
	
### Class inheritance
and invoking super methods.

	local SuperClass = class("SimpleClass")
	
	function SuperClass:classMethod()
	end

	local SimpleClass = class("SimpleClass", SuperClass)
	
	function SimpleClass:classMethod()
		self.super:classMethod()
	end

### Mixins / Multiple inheritance
you can actually have an unlimited number of inheritances

	local Mixin = class("Mixin")
	
	function Mixin:randomFunction()
	end

	local SimpleClass = class("SimpleClass", SuperClass, Mixin)
	
	function SimpleClass:classMethod()
		self.super:classMethod()
	end
