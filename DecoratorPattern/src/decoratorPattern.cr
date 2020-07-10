# TODO: Write documentation for `DecoratorPattern`
module DecoratorPattern
  VERSION = "0.1.0"

  abstract class IDecorator

    abstract def say: String
  end

  class MasterDecorator < IDecorator

    def say: String
      "MasterDecorator"
    end
  end

  class FatherDecorator < MasterDecorator

    def initialize(@decorator : MasterDecorator)
    end

    def say: String
      "FatherDecorator(#{@decorator.say})"
    end
  end

  class ChildDecorator < FatherDecorator
    
    def initialize(@decorator : FatherDecorator)
    end

    def say: String
      "ChildDecorator(#{@decorator.say})"
    end
  end
end

# def invoke_decorator(member : DecoratorPattern::IDecorator)
#   p "RESULT: #{member.say}"
# end

# instance_master = DecoratorPattern::MasterDecorator.new
# instance_father = DecoratorPattern::FatherDecorator.new instance_master
# instance_child  = DecoratorPattern::ChildDecorator.new instance_father

# invoke_decorator instance_child