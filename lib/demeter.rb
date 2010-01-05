module Demeter
  def self.extended(base)
    base.class_eval do
      include InstanceMethods
      extend ClassMethods
    end
  end

  module InstanceMethods
    def method_missing(method_name, *attrs, &block)
      object_method_name = method_name.to_s
      object_name = self.class.demeter_names.find {|name| object_method_name =~ /^#{name}_/ }

      return super unless object_name

      object_method_name.gsub!(/^#{object_name}_/, "")

      instance_eval <<-TXT
        def #{method_name}                                          # def address_street
          #{object_name}.#{object_method_name} if #{object_name}    #   address.street
        end                                                         # end
      TXT

      send(method_name)
    end
  end

  module ClassMethods
    def demeter(*attr_names)
      @@demeter_names ||= []
      @@demeter_names += attr_names
    end

    def demeter_names
      @@demeter_names
    end

    def demeter_names=(names)
      @@demeter_names = names
    end
  end
end

# ActiveRecord support
require "demeter/active_record"