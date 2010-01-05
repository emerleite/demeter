ActiveRecord::Schema.define(:version => 0) do
  create_table :projects do |t|
    t.string :name
  end

  create_table :tasks do |t|
    t.string :name
    t.references :owner, :project
  end

  create_table :owners do |t|
    t.string :name
    t.references :owner
  end
end
