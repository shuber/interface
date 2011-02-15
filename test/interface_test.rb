require 'test_helper'

class InterfaceTest < Test::Unit::TestCase
  def setup
    @mock_module = mock_module = Module.new
    @mock_interface = mock_interface = Module.new
    @remote = remote = Module.new { attr_reader :on, :off; def on?; end }
    @broken_device = Class.new { def on?; !!@power end; implements remote, mock_interface }
    @device = Class.new(@broken_device) do
      include mock_module

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
  end

  def test_should_include_interface
    assert @broken_device.included_modules.include?(@remote)
  end

  def test_interface_should_include_abstract
    assert @remote.is_a?(Interface::Abstract)
  end

  def test_should_raise_not_implemented_error
    assert_raises(NotImplementedError) { @broken_device.new.on }
  end

  def test_should_not_raise_not_implemented_error_if_method_is_defined
    assert @device.new.on
  end

  def test_should_not_raise_not_implemented_error_if_method_is_defined_by_method_missing
    assert !@device.new.off
  end

  def test_should_only_return_interfaces
    assert_all_equal [@remote, @mock_interface], @device.interfaces, @device.new.interfaces
  end

  def test_should_return_unimplemented_methods_for_interface
    assert_equal ['off', 'on'], @broken_device.new.unimplemented_methods_for(@remote)
  end

  def test_should_return_empty_array_when_all_implemented
    assert_equal [], @device.new.unimplemented_methods_for(@remote)
  end

  def test_should_return_hash_of_unimplemented_methods_with_interfaces
    assert_equal({ @remote => ['off', 'on'] }, @broken_device.new.unimplemented_methods)
  end

  def test_should_return_empty_hash_when_all_interfaces_implemented
    assert_equal Hash.new, @device.new.unimplemented_methods
  end

  def test_should_pass_assertion
    assert_implements_interfaces @device.new
    assert_implements_interface @broken_device.new, @mock_interface
  end

  def test_should_fail_assertion
    assert_raises(Test::Unit::AssertionFailedError) { assert_implements_interfaces @broken_device.new }
    assert_raises(Test::Unit::AssertionFailedError) { assert_implements_interface @broken_device.new, @remote }
  end

  def test_should_respond_to_respond_to_missing
    assert respond_to?(:respond_to_missing?)
  end

  def test_should_call_super
    assert !@broken_device.new.on?
    assert !@device.new.on?
  end
end