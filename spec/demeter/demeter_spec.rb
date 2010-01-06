require File.dirname(__FILE__) + "/../spec_helper"

describe "Demeter" do
  subject { User.new }

  before do
    User.demeter :address, :video_game

    subject.name = "John"
    subject.address.street = "Some street"
    subject.address.zip_code = "98005"
    subject.video_game.title = "God of War 3"
    subject.video_game.production_year = 1999
    subject.profile.interests = %w(games programming music movies)
  end

  it "should allow demeter only one object" do
    Person.demeter :animal
    person = Person.new
    person.animal.name = "marley"

    person.animal_name.should == "marley"
  end

  it "should not delegate existing methods" do
    subject.name.should == "John"
  end

  it "should delegate methods from address object" do
    subject.address_street.should == "Some street"
    subject.address_zip_code.should == "98005"
  end

  it "should delegate methods from video game object" do
    subject.video_game_title.should == "God of War 3"
    subject.video_game_production_year.should == 1999
  end

  it "should return nil when demeter object is not set" do
    subject.address = nil
    subject.address_title.should be_nil
  end

  it "should raise exception when method is not defined on the demeter class" do
    doing { subject.address_foo }.should raise_error(NoMethodError)
  end

  it "should not delegate unset objects" do
    doing { subject.profile_interests }.should raise_error(NoMethodError)
  end

  it "should override demeter method" do
    subject.instance_eval do
      def address_street
        address.street.upcase
      end
    end

    subject.address_street.should == "SOME STREET"
  end

  it "should replace demeter names" do
    User.demeter_names = []
    User.demeter_names.should == []

    doing { subject.address_title }.should raise_error(NoMethodError)
  end
end
