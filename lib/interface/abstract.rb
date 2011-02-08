module Interface
  # When extended, this abstract interface will re-define an object's methods to raise <tt>NotImplementedError</tt> when called
  module Abstract
    def self.extended(base) # :nodoc:
      base.class_eval do
        instance_methods(false).each do |method|
          define_method(method) { |*args| raise NotImplementedError.new("#{self.class} needs to implement '#{method}' for interface #{base}") }
        end
      end
    end
  end
end