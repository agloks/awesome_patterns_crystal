require "./spec_helper"

describe ObserverPattern do
  pub = uninitialized ObserverPattern::IPublisher 
  sub1 = sub2 = uninitialized ObserverPattern::ISubscriber

  before_each {
    pub = ObserverPattern::Publisher.new
    sub1 = ObserverPattern::Subscriber.new
    sub2 = ObserverPattern::Subscriber.new
  }

  it "Publisher must respond as IPublisher" do
    pub.should be_a(ObserverPattern::IPublisher)
  end

  it "Subscriber must respond as ISubscriber" do
    sub1.should be_a(ObserverPattern::ISubscriber)
    sub2.should be_a(ObserverPattern::ISubscriber)
  end

  it "Both subscribers must be update when publisher call" do
    old_value = sub1.news
    sub2.news.should eq(old_value)

    pub.subscribe(sub1)
    pub.subscribe(sub2)
    pub.notify()
    sub1.news.should eq(pub.news)

    new_value = sub1.news
    sub2.news.should eq(new_value)
  end

  it "Subscriber can cancel subscription on pub" do
    original_value = sub1.news

    pub.subscribe(sub1)
    pub.subscribe(sub2)
    pub.unscribe(sub1)
    pub.news = "assign this variable will trigger notify and update all subs"

    sub1.news.should eq(original_value)
    sub1.news.should_not eq(sub2.news)
  end
end
