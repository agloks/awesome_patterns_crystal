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