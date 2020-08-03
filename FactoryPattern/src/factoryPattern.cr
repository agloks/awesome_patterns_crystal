module FactoryPattern
  VERSION = "0.1.0"

  #product interface
  abstract class Model
    abstract def sexyPosition()
  end

  #product
  class ManModel < Model
    def sexyPosition
      "__I__"      
    end
  end

  #product
  class FemaleModel < Model
    def sexyPosition
     "\\//"
    end
  end

  #fabric
  class ModelsStudio
    def giveMeOneModel(person_genre : String) : Model
      person_genre == "male" ? FemaleModel.new : ManModel.new
    end
  end

  #application and creator, would be good to do it separate responsibility,
  #but as example and the logic implemented here, it'll only over complicate the things
  class MainBusinessLogic
    def initialize(@client_genre : String)
      @client_genre = @client_genre.downcase
      @modelsStudio = ModelsStudio.new
      #Doing a lot of things that you can't see... 
    end

    def makeCommercial : String | Nil
      #Doing a lot of things that you can't see... 
      myModel = Model | Nil
      if @client_genre == "male"
        myModel = @modelsStudio.giveMeOneModel "male"
      elsif @client_genre == "female"
        myModel = @modelsStudio.giveMeOneModel "female"
      else
        myModel = nil
      end

      #I don't need to care about which product will come and how handle with it, i only want one thing independent of who are
      myModel.sexyPosition if myModel.is_a?(Model) 
    end 
  end

end

include FactoryPattern

mainOne = MainBusinessLogic.new "Male"
p mainOne.makeCommercial

mainTwo = MainBusinessLogic.new "Female"
p mainTwo.makeCommercial