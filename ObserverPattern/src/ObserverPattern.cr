# TODO: Write documentation for `ObserverPattern`
module ObserverPattern
  VERSION = "0.1.0"

  # Interface to represent publishers
  abstract class IPublisher
  end

  # Common interface to comunication between publisher with subscribers
  abstract class ISubscriber
    def update(context) end
  end

  # Subscriber that assign to the publisher and get the events
  class Subscriber < ISubscriber
    getter news : String

    def initialize
      @news = "empty"
    end

    def update(context : IPublisher)
      @news = context.news
    end
  end 

  # Publisher is the responsible for send the events
  class Publisher < IPublisher
    @subs : Array(ISubscriber)
    getter news : String

    def initialize
      @subs = Array(ISubscriber).new
      @news = "Publisher Is On :X"
    end

    def subscribe(element : ISubscriber)
      @subs << element
    end

    def unscribe(element : ISubscriber)
      @subs.each_index do |idx|
        sub = @subs[idx]
        @subs.delete_at(idx) if sub.hash == element.hash
      end
    end

    def notify()
      @subs.each do |sub|
        sub.update(self)
      end
    end

    def news=(value : String)
      if value != @news
        @news = value
        notify()
      end
    end
  end

end

pub = ObserverPattern::Publisher.new
sub1 = ObserverPattern::Subscriber.new
sub2 = ObserverPattern::Subscriber.new

pub.subscribe(sub1)
pub.subscribe(sub2)
pub.unscribe(sub1)
pub.notify()

p sub1.news
p sub2.news

pub.subscribe(sub1)
pub.news = "hihi"

p sub1.news
p sub2.news