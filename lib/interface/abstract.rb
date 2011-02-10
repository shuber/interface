module Interface
  # When extended, this module will re-define an interface's methods to raise <tt>NotImplementedError</tt> when called (unless handled by <tt>method_missing</tt>)
  module Abstract
    def self.extended(interface) # :nodoc:
      interface.class_eval do
        instance_methods(false).each do |method|
          define_method(method) do |*args, &block|
            methods = [:super, :method_missing]
            begin
              send(methods.shift, *args, &block)
            rescue NoMethodError
              if methods.empty?
                raise NotImplementedError.new("#{self.class} needs to implement '#{method}' for interface #{interface}")
              else
                args.unshift(method.to_sym)
                retry
              end
            end
          end
        end
      end
    end
  end
end