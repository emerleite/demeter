module DemeterLaw
  def self.demeter_objects
    @@demeter_objects
  end
  
  def self.extended(base)    
    @@demeter_objects = @@demeter_objects ||= Hash.new
    @@demeter_objects[base.to_s.to_sym] = Array.new
    base.send(:include, DemeterMethods)
  end
  
  def demeter(symbol)
    @@demeter_objects[self.to_s.to_sym] << symbol
#     @@demeter_objects.keys.each do |key|
#       puts "#{key}:#{@@demeter_objects[key]}"
#     end
    
#     define_method :method_missing do |method, *args|
#       message_split = method.to_s.split("_")
      
#       raise NoMethodError if message_split.first.to_sym != symbol
#       object = self.send(message_split.first)
#       message_split.delete message_split.first
#       object.send(message_split.join("_"))
#     end
  end

  module DemeterMethods
    def method_missing(method, *args)
      message_split = method.to_s.split("_")
      raise NoMethodError if DemeterLaw.demeter_objects[self.class.to_s.to_sym].select { |object| message_split.first.to_sym == object }.length == 0
      object = self.send(message_split.first)
      message_split.delete message_split.first
      object.send(message_split.join("_"))
    end
  end
end
