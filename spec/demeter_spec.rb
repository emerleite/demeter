require 'spec'
require 'lib/demeter'

describe Demeter do
  before do
    AClass = Class.new
    AClass.send(:extend, Demeter)

    Person = Class.new
    Animal = Class.new    
  end    
  
  it 'Should provide demeter class method when module extended' do
    AClass.respond_to?(:demeter).should be_true
  end

  it 'Should receive an object when demeter' do
    AClass.demeter :some_object
  end

  it 'Should get value for name when invoke person_name' do
    Person.send(:attr_accessor, :name)

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
    Person.send(:attr_accessor, :gender)

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
  
  it 'Should allow attribute with undescore' do
    Person.send(:attr_accessor, :phone_number)
    Person.send(:attr_accessor, :three_undescore_method)

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
    Person.send(:attr_accessor, :phone_number)

    AClass.send(:attr_accessor, :person)
    AClass.demeter :animal
    instance = AClass.new

    person = Person.new
    person.phone_number = 99999999

    instance.person = person
    lambda {instance.person_phone_number}.should raise_error(NoMethodError)
  end    

  it 'Should demeter 2 attribute objects' do

    Animal.send(:attr_accessor, :name)

    Person.send(:attr_accessor, :phone_number)

    AClass.send(:attr_accessor, :person)
    AClass.send(:attr_accessor, :animal)
    AClass.demeter :person
    AClass.demeter :animal

    instance = AClass.new

    person = Person.new
    person.phone_number = 99999999

    animal = Animal.new
    animal.name = "marley"

    instance.person = person
    instance.animal = animal
    instance.person_phone_number.should be_eql(99999999)
    instance.animal_name.should be_eql("marley")
  end    

  it 'Should allow to extend Demeter in 2 classes' do
    Animal.send(:attr_accessor, :name)

    Person.send(:attr_accessor, :phone_number)

    AClass.send(:attr_accessor, :person)
    AClass.send(:attr_accessor, :animal)
    AClass.demeter :person
    AClass.demeter :animal
    
    ASecondClass = AClass
    
    instance = AClass.new

    person = Person.new
    person.phone_number = 99999999

    animal = Animal.new
    animal.name = "marley"

    instance.person = person
    instance.animal = animal
    instance.person_phone_number.should be_eql(99999999)
    instance.animal_name.should be_eql("marley")

    instance2 = ASecondClass.new

    person2 = Person.new
    person2.phone_number = 88888888

    animal2 = Animal.new
    animal2.name = "fox"

    instance2.person = person2
    instance2.animal = animal2
    instance2.person_phone_number.should be_eql(88888888)
    instance2.animal_name.should be_eql("fox")
  end

  it 'Should demeter 2 attributes with one call' do
    Animal.send(:attr_accessor, :name)

    Person.send(:attr_accessor, :phone_number)

    AClass.send(:attr_accessor, :person)
    AClass.send(:attr_accessor, :animal)
    AClass.demeter :person, :animal

    instance = AClass.new

    person = Person.new
    person.phone_number = 99999999

    animal = Animal.new
    animal.name = "marley"

    instance.person = person
    instance.animal = animal
    instance.person_phone_number.should be_eql(99999999)
    instance.animal_name.should be_eql("marley")
  end

  it 'Should get value when instance attribute have diferent name' do
    Person.class_eval do
      define_method :initialize do |name|
        @a_name = name
      end
      define_method :name do
        @a_name
      end
    end

    AClass.send(:attr_accessor, :person)
    AClass.demeter :person
    instance = AClass.new

    person = Person.new "emerson"
    
    instance.person = person
    instance.person_name.should be_eql("emerson")
  end

  it 'Should allow override the demeter method' do
    Person.send(:attr_accessor, :name)

    AClass.send(:attr_accessor, :person)
    AClass.demeter :person
    AClass.class_eval do
      define_method :person_name do
        "name overrided"
      end
    end
    instance = AClass.new

    person = Person.new
    person.name = "emerson"
    
    instance.person = person
    instance.person_name.should be_eql("name overrided")
  end

  it 'Should return nil when demetered object is nil' do
    AClass.send(:attr_accessor, :person)
    AClass.demeter :person

    instance = AClass.new
    instance.person_name.should be_nil
  end
end
