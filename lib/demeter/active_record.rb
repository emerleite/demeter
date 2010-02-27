class ActiveRecord::Base
  def self.inherited(base)
    super
    base.send :extend, ::Demeter
  end
end if defined? ActiveRecord::Base
