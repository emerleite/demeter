ActiveRecord::Base.class_eval do
  extend ::Demeter
end if defined? ActiveRecord::Base
