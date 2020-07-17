# TODO: Write documentation for `StatePattern`
module StatePattern
  VERSION = "0.1.0"

  abstract class IState
    abstract def doThis : String | Int32
  end
  
  class Context
    property fakePrivateVar
    property state

    def initialize(@state : IState)
      @fakePrivateVar = "H4CK3D"
    end

    def changeState(state : IState)
      @state = state
    end

    def sayHi
      @state.doThis
    end

    def getState
      @state
    end
  end

  class ConcreteState < IState
    property context : Context | Nil

    def setContext(c : Context) : Context
      @context = c
    end

    def doThis : String
      p "Hi from ConcreteState"
    end

    def changeStateFather
      p "From A to B"
      _s = OtherConcreteState.new
      _s.setContext @context.not_nil!
      @context.not_nil!.changeState(_s) if !@context.nil?
    end
  end


  class OtherConcreteState < IState
    property context : Context | Nil

    def setContext(c : Context) : Context
      @context = c
    end

    def doThis : Int32
      p 999
    end

    def changeStateFather
      p "From B to A"
      _s = ConcreteState.new
      _s.setContext @context.not_nil!
      @context.not_nil!.changeState(_s) if !@context.nil?
    end
  end
end

include StatePattern

state = ConcreteState.new
other_state = OtherConcreteState.new
context = Context.new state

state.setContext context
other_state.setContext context

#Delegate role to the Composite 
context.sayHi

#Get property from 'father'|'main app'|'Context'
# state.setContext context
p state.context.not_nil!.fakePrivateVar

#Change state and with the same function get other response
context.changeState other_state
context.sayHi

#States can change states in our context too
while true
  context.state.changeStateFather
  context.state.changeStateFather
  context.state.changeStateFather
  context.state.changeStateFather

  sleep(1.2)
end

###############################################################################################################################

# class CM
#   @conversation : IState

#   propertyGot = getPropertyFromXX -> (String | Int | Null)

#   if propertyGot == String
#     conversation = new HandlerConversationString
#   elseif propertyGot == Int
#     conversation = new HandlerConversationInt
#   else
#     conversation = new HandlerConversationNull
# end

# CM.conversation.sayThings