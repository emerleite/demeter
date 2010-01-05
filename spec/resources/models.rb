class Project < ActiveRecord::Base
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :project
  has_one :owner

  accepts_nested_attributes_for :project
end

class Owner < ActiveRecord::Base
  belongs_to :task
end
