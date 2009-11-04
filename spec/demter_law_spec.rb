require 'spec'
require 'lib/demeter_law'

describe DemeterLaw do
  it 'Should provide demeter class method when module extended' do
    AClass = Class.new
    AClass.send(:extend, DemeterLaw)
    AClass.respond_to?(:demeter).should be_true
  end

  it 'Should receive an object when demeter' do
    AClass = Class.new
    AClass.send(:extend, DemeterLaw)
    AClass.demeter :some_object
  end

  it 'Should get value for name when invoke person_name' do
    Person = Class.new
    Person.send(:attr_accessor, :name)

    AClass = Class.new
    AClass.send(:extend, DemeterLaw)
    AClass.send(:attr_accessor, :person)
    AClass.demeter :person
    instance = AClass.new

    person = Person.new
    person.name = "emerson"
    
    instance.person = person
    instance.person_name.should be_eql("emerson")

    person2 = Person.new
    person2.name = "patricia"
    
    instance.person = person2
    instance.person_name.should be_eql("patricia")
  end

  it 'Should get value for gender when invoke person_gender' do
    Person = Class.new
    Person.send(:attr_accessor, :gender)

    AClass = Class.new
    AClass.send(:extend, DemeterLaw)
    AClass.send(:attr_accessor, :person)
    AClass.demeter :person
    instance = AClass.new

    person = Person.new
    person.gender = "male"

    instance.person = person
    instance.person_gender.should be_eql("male")

    person2 = Person.new
    person2.gender = "female"

    instance.person = person2
    instance.person_gender.should be_eql("female")
  end
  
  it 'Should allow method with undescore' do
    Person = Class.new
    Person.send(:attr_accessor, :phone_number)
    Person.send(:attr_accessor, :three_undescore_method)

    AClass = Class.new
    AClass.send(:extend, DemeterLaw)
    AClass.send(:attr_accessor, :person)
    AClass.demeter :person
    instance = AClass.new

    person = Person.new
    person.phone_number = 99999999
    person.three_undescore_method = "nothing"

    instance.person = person
    instance.person_phone_number.should be_eql(99999999)
    instance.person_three_undescore_method.should be_eql("nothing")
  end

  it 'Should raise error if object is not demetered' do
    Person = Class.new
    Person.send(:attr_accessor, :phone_number)

    AClass = Class.new
    AClass.send(:extend, DemeterLaw)
    AClass.send(:attr_accessor, :person)
    AClass.demeter :animal
    instance = AClass.new

    person = Person.new
    person.phone_number = 99999999

    instance.person = person
    lambda {instance.person_phone_number}.should raise_error(NoMethodError)
  end    
end
