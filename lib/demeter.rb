module Demeter
  def self.demeter_objects
    @@demeter_objects
  end
  
  def self.extended(base)    
    @@demeter_objects = @@demeter_objects ||= Hash.new
    @@demeter_objects[base.to_s.to_sym] = Array.new
    base.send(:alias_method, :old_method_missing, :method_missing)
    base.send(:include, DemeterMethods)
    base.send(:alias_method, :method_missing, :demeter_method_missing)
  end
  
  def demeter(*symbols)
    symbols.each do |symbol|
      @@demeter_objects[self.to_s.to_sym] << symbol
    end
  end

  module DemeterMethods
    def demeter_method_missing(method, *args, &block)
      message_split = method.to_s.split("_")
      if Demeter.demeter_objects[self.class.to_s.to_sym].select { |object| message_split.first.to_sym == object }.length == 0
        old_method_missing(method, *args, &block)
      else
        object = self.send(message_split.first)
        message_split.delete message_split.first
        object ? object.send(message_split.join("_")) : nil
      end
    end
  end
end
