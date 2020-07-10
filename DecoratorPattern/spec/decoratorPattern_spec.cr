require "./spec_helper"

describe DecoratorPattern do
  # TODO: Write tests

  it "All classes could be instantiated" do
    instance_master = DecoratorPattern::MasterDecorator.new
    instance_father = DecoratorPattern::FatherDecorator.new instance_master
    instance_child  = DecoratorPattern::ChildDecorator.new instance_father

    instance_child.should be_a(DecoratorPattern::IDecorator)
  end

  it "The latest instance should reponse to the interface and the master decorator" do 
    instance_master = DecoratorPattern::MasterDecorator.new
    instance_father = DecoratorPattern::FatherDecorator.new instance_master
    instance_child  = DecoratorPattern::ChildDecorator.new instance_father
    
    instance_child.should be_a(DecoratorPattern::IDecorator)
    instance_child.should be_a(DecoratorPattern::MasterDecorator)
  end

  it "It's working sucessfully the method master from child" do
    instance_master = DecoratorPattern::MasterDecorator.new
    instance_father = DecoratorPattern::FatherDecorator.new instance_master
    instance_child  = DecoratorPattern::ChildDecorator.new instance_father

    /master/i.match(instance_child.say).should be_truthy
  end 
end
