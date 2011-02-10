require 'test_helper'

module MockModule end
module MockInterface end

module Remote
  def on
  end

  def off
  end
end

class BrokenDevice
  implements Remote, MockInterface
end

class Device < BrokenDevice
  include MockModule

  def on
    @power = true
  end

  def method_missing(method, *args)
    method == :off ? @power = false : super
  end

  def respond_to_missing?(method, include_private)
    method == :off || super
  end
end

class InterfaceTest < Test::Unit::TestCase

  def test_should_include_interface
    assert BrokenDevice.included_modules.include?(Remote)
  end

  def test_interface_should_include_abstract
    assert Remote.is_a?(Interface::Abstract)
  end

  def test_should_raise_not_implemented_error
    assert_raises(NotImplementedError) { BrokenDevice.new.on }
  end

  def test_should_not_raise_not_implemented_error_if_method_is_defined
    assert Device.new.on
  end

  def test_should_not_raise_not_implemented_error_if_method_is_defined_by_method_missing
    assert !Device.new.off
  end

  def test_should_return_interfaces
    assert_all_equal [Remote, MockInterface], Device.interfaces, Device.new.interfaces
  end

  def test_should_return_unimplemented_methods_for_interface
    assert_equal ['off', 'on'], BrokenDevice.new.unimplemented_methods_for(Remote)
  end

  def test_should_return_empty_array_when_all_implemented
    assert_equal [], Device.new.unimplemented_methods_for(Remote)
  end

  def test_should_return_hash_of_unimplemented_methods_with_interfaces
    assert_equal({ Remote => ['off', 'on'] }, BrokenDevice.new.unimplemented_methods)
  end

  def test_should_return_empty_hash_when_all_interfaces_implemented
    assert_equal Hash.new, Device.new.unimplemented_methods
  end

  def test_should_pass_assertion
    assert_implements_interfaces Device.new
    assert_implements_interface BrokenDevice.new, MockInterface
  end

  def test_should_fail_assertion
    assert_raises(Test::Unit::AssertionFailedError) { assert_implements_interfaces BrokenDevice.new }
    assert_raises(Test::Unit::AssertionFailedError) { assert_implements_interface BrokenDevice.new, Remote }
  end

  def test_should_respond_to_respond_to_missing
    assert respond_to?(:respond_to_missing?)
  end

end