require File.dirname(__FILE__) + "/../spec_helper"

describe "Demeter on ActiveRecord" do
  it "should respond to demeter method" do
    Project.should respond_to(:demeter)
    Task.should respond_to(:demeter)
    Owner.should respond_to(:demeter)
  end

  it "should dispatch original method missing" do
    Task.demeter :project

    task = Task.create!(:name => "Do the right thing", :project_attributes => {:name => "Amazing Project"})
    Task.find_by_name("Do the right thing").should == task
  end

  it "should also dispatch original method missing when not demetered" do
    owner = Owner.new
    owner.name.should be_nil
  end

  it "should load demeter_names for each model" do
    Task.demeter :project
    Owner.demeter :task

    Task.demeter_names.should == [:project]
    Owner.demeter_names.should == [:task]
  end
end
