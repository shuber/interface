module Interface
  # Contains interface testing methods to include in your test framework
  module TestHelper
    # Raises AssertionFailedError if <tt>object</tt> does not implement all methods from <tt>interfaces</tt>
    #
    # <tt>interfaces</tt> defaults to <tt>object.interfaces</tt> if none are specified
    #
    # Aliased as <tt>assert_implements_interface</tt>
    #
    # Example
    #
    #   module Remote
    #     def on
    #     end
    #
    #     def off
    #     end
    #   end
    #
    #   module MockInterface
    #   end
    #
    #   class BrokenDevice
    #     implements Remote, MockInterface
    #   end
    #
    #   class BrokenDeviceTest < Test::Unit::TestCase
    #     def test_should_implement_interfaces
    #       assert_implements_interfaces BrokenDevice.new # Failure: unimplemented interface methods for BrokenDevice: {Remote=>["off", "on"]}
    #
    #       # you can also explicitly pass interfaces to test
    #       assert_implements_interface BrokenDevice.new, MockInterface # passes
    #     end
    #   end
    def assert_implements_interfaces(object, *interfaces)
      interfaces = interfaces.empty? ? object.interfaces : interfaces.flatten
      unimplemented_methods = object.unimplemented_methods.reject { |interface, methods| !interfaces.include?(interface) }
      assert_block("unimplemented interface methods for #{object.class}: #{unimplemented_methods.inspect}") { unimplemented_methods.empty? }
    end
    alias_method :assert_implements_interface, :assert_implements_interfaces
  end
end