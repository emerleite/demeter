module Demeter
  def self.extended(base)
    base.class_eval do
      include InstanceMethods
      extend ClassMethods

      class << self
        attr_accessor :demeter_names
      end

      base.demeter_names = []
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

    def respond_to?(method_name, include_private = false)
      object_method_name = method_name.to_s
      object_name = self.class.demeter_names.find {|name| object_method_name =~ /^#{name}_/ }

      if object_name && (object = send(object_name))
        object.respond_to?(object_method_name.gsub(/^#{Regexp.escape(object_name.to_s)}_/, ""))
      else
        super
      end
    end
  end

  module ClassMethods
    def demeter(*attr_names)
      self.demeter_names = attr_names
    end
  end
end

# ActiveRecord support
require "demeter/active_record"
