Sunclass
========

[![Build Status](https://travis-ci.org/qwook/sunclass.png?branch=master)](https://travis-ci.org/qwook/sunclass)

A simple OOP library for Lua, based on the Sunscript implementation of classes.

* Mixins / Multiple Inheritance
* Invoking superclass methods
* Operator overloading / Metamethods
* Simple, intuitive, easy to use and install

# Installation
Drag and drop sunclass.lua into your project directory,
then add this line to your code:

	local class = require("sunclass")

Unit Tests
==========

Unit tests are stored in the `spec` folder.

Perform unit tests with [Busted](http://olivinelabs.com/busted/):
`busted`

Documentation
=============

## Simple class

	local SimpleClass = class("SimpleClass")
	
	-- constructor, automatically called
	function SimpleClass:initialize()
	end
	
	-- definition of a class method
	function SimpleClass:classMethod()
	end
	
	-- class instancing and method calling
	local instance = SimpleClass:new()
	instance:classMethod()
	
## Class inheritance and invoking super methods.

	-- definition of a super class
	local SuperClass = class("SimpleClass")
	
	function SuperClass:classMethod()
	end

	-- definition of a derived class
	local SimpleClass = class("SimpleClass", SuperClass)
	
	function SimpleClass:classMethod()
		self.super:classMethod()
	end

## Mixins / Multiple inheritance
You can actually have an unlimited number of inheritances

	-- definition of a mixin class
	local Mixin = class("Mixin")
	
	function Mixin:randomFunction()
	end

	-- definition of a class that derives off of two other classes.
	local SimpleClass = class("SimpleClass", SuperClass, Mixin)
	
	function SimpleClass:classMethod()
		self.super:classMethod()
	end

License
=======

Sunclass is licensed under the MIT license.
