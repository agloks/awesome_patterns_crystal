# TODO: Write documentation for `CommandPattern`
module Commands
    #Only common contract
    abstract class ICommand
    
      abstract def execute()
    end
  
    #The command and derivation are everyone triggered by Invoker class
    class Command < ICommand
      
      def execute(): String
        "Default execute"
      end
    end
  
    #One of the many possible derivatives of the Command
    class CustomCommandOne < Command
      
      def execute(): String
        "Hello, i'm the commandOne"
      end
    end

    #One of the many possible derivatives of the Command
    class CustomCommandTwo < Command
      def execute(): String
        "Hello, i'm the commandTwo"
      end
    end

    #One of the many possible derivatives of the Command
    class CustomCommandThree < Command
      def execute(): String
        "Hello, i'm the commandThree"
      end
    end

    #One way to rollback action in LIFO
    class CommandHistory
      @history = [] of Command

      def push(command : Command): Bool
        @history.push(command)
        true
      end

      def pop(): Command
        @history.pop()
      end
    end      
end

module CommandPattern
  VERSION = "0.1.0"
  include Commands

  #The role of Invoker is to be the sender of the context to the Command class
  class Invoker
    @commandHistory = CommandHistory.new
    @command = Command.new
    
    def executeAction()
      @commandHistory.push(@command)
      @command.execute if @command.is_a? Command
    end

    def setterCommand(command : Command)
      @command = command
    end
  end

  #The Client that does send the order to the sender
  class Client
    @sender = Invoker.new
    @command = Command.new

    def setterCommand(action : String)
      case action
      when "one"
        @command = CustomCommandOne.new
      when "two"
        @command = CustomCommandTwo.new
      else
        @command = CustomCommandThree.new
      end
    end

    def doAnything()
      @sender.setterCommand @command
      @sender.executeAction
    end
  end
end