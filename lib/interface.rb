# Implementable interfaces in ruby
module Interface
  autoload :Abstract, 'interface/abstract'
  autoload :Version, 'interface/version'

  # Takes a module (or multiple in reverse order), extends it with <tt>Interface::Abstract</tt>, then includes it into the current object
  #
  # Example
  #
  #   module Remote
  #     # turns the device on
  #     def on
  #     end
  #   end
  #
  #   class Device
  #     implements Remote
  #
  #     def on
  #       @power = true
  #     end
  #   end
  def implements(*modules)
    modules.flatten.reverse!.each { |mod| include mod.extend(Abstract) }
  end

  # Conforms with naming conventions for include and extend
  alias_method :implement, :implements

  # Returns an array of interfaces implemented by the current object
  def interfaces
    included_modules.select { |mod| mod.is_a?(Abstract) }
  end
end

Object.send(:include, Interface)