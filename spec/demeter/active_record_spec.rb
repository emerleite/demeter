require File.dirname(__FILE__) + "/../spec_helper"

describe "Demeter on ActiveRecord" do
  it "should respond to demeter method" do
    ActiveRecord::Base.should respond_to(:demeter)
  end

  it "should dispatch original method missing" do
    Task.demeter :project

    task = Task.create!(:name => "Do the right thing", :project_attributes => {:name => "Amazing Project"})
    Task.find_by_name("Do the right thing").should == task
  end

  it "should also dispatch original method missing when not demetered" do
    Demeter::ClassMethods.send(:remove_class_variable, :@@demeter_names)
    owner = Owner.new
    owner.name.should be_nil #name uses ActiveRecord method_missing instance method
  end
end
