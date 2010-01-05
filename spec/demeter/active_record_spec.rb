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
end
