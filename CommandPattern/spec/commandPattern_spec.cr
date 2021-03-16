require "./spec_helper"

describe CommandPattern do
  # TODO: Write tests

  it "CustomCommands must response as Command" do
    custom = Commands::CustomCommandTwo.new

    custom.should be_a(Commands::Command)
  end

  it "Choice the command in client working" do
    client = CommandPattern::Client.new
    
    client.setterCommand("two")
    /commandTwo/i.match(client.doAnything.not_nil!).should be_truthy

    client.setterCommand("one")
    /commandOne/i.match(client.doAnything.not_nil!).should be_truthy

    client.setterCommand("three")
    /commandThree/i.match(client.doAnything.not_nil!).should be_truthy
  end
end
