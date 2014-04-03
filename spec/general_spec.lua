require("busted")

describe("Sunclass unit tests", function()

    local sunclass

    it("should be loaded", function()
        sunclass = require("sunclass")
        assert.is_not_nil(sunclass)
    end)

    local TestClass
    local ChildClass
    local MixinClass
    local fn_initialize = spy.new(function() end)
    local fn_fn1 = spy.new(function() end)

    -- generic class
    it("should make a simple class", function()
        TestClass = sunclass("TestClass")
        assert.is_not_nil(TestClass)

        function TestClass:initialize()
            fn_initialize()
        end

        function TestClass:fn1()
            fn_fn1()
        end

    end)

    it("should initialize an object", function()
        local test = TestClass:new()
        assert.is_not_nil(test)
        assert.spy(fn_initialize).was.called(1)

        it("should call a class method", function()
           test:fn1()
           assert.spy(fn_fn1).was.called(1)
        end)

        it("should return correct instanceOf", function()
           assert.is_true(test:instanceOf(TestClass))
        end)
    end)

    local fn_fn2 = spy.new(function() end)
    local fn_fn3 = spy.new(function() end)

    -- inheritance
    it("should support inheritance", function()
        ChildClass = sunclass("ChildClass", TestClass)
        assert.is_not.equal(TestClass, ChildClass)

        function ChildClass:fn1()
            self.super:fn1()
            fn_fn3()
        end

        function ChildClass:fn2()
            fn_fn2()
        end
    end)

    it("should initialize child object", function()
        local test = ChildClass:new()
        assert.is_not_nil(test)
        assert.spy(fn_initialize).was.called(2)

        it("should call an inherited class method", function()
           test:fn2()
           assert.spy(fn_fn2).was.called(1)
        end)

        it("should call a superclass method", function()
           test:fn1()
           assert.spy(fn_fn1).was.called(2)
           assert.spy(fn_fn3).was.called(1)
        end)

        it("should return correct instanceOf", function()
           assert.is_true(test:instanceOf(ChildClass))
           assert.is_true(test:instanceOf(TestClass))
        end)
    end)

    local fn_mixin = spy.new(function() end)

    -- mixins
    it("should support mixins", function()
        MixinClass = sunclass("MixinClass", TestClass)

        function MixinClass:mixin()
            fn_mixin()
        end

        MixedClass = sunclass("MixedClass", TestClass, MixinClass)
        assert.is_not.equal(MixedClass, TestClass)
        assert.is_not.equal(MixedClass, MixinClass)
    end)

    it("should initialize mixin object", function()
        local test = MixedClass:new()
        assert.is_not_nil(test)
        assert.spy(fn_initialize).was.called(3)

        it("should call a mixin method", function()
           test:mixin()
           assert.spy(fn_mixin).was.called(1)
        end)

        it("should call a non-mixin method", function()
           test:fn1()
           assert.spy(fn_fn1).was.called(3)
        end)

        it("should return correct instanceOf", function()
           assert.is_true(test:instanceOf(MixinClass))
           assert.is_true(test:instanceOf(TestClass))
           assert.is_false(test:instanceOf(ChildClass))
        end)
    end)

end)