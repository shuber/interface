module Interface
  # When extended, this abstract interface will re-define an object's methods to raise <tt>NotImplementedError</tt> when called (unless handled by <tt>method_missing</tt>)
  module Abstract
    def self.extended(base) # :nodoc:
      base.class_eval do
        instance_methods(false).each do |method|
          define_method(method) do |*args, &block|
            begin
              method_missing(method.to_sym, *args, &block)
            rescue NoMethodError
              raise NotImplementedError.new("#{self.class} needs to implement '#{method}' for interface #{base}")
            end
          end
        end
      end
    end
  end
end