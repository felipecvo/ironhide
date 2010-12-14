require 'spec_helper'

describe Ironhide::Includer do
  it "should get external file contents through http request" do
    resource = 'http://somesite.com/resources/content.shtml'
    expected = '<div><h1>title</h1><p>text to describe it</p></div>'
    stub_request(:get, resource).to_return(:body => expected)
    
    actual = Ironhide::Includer.get(resource)

    WebMock.should have_requested(:get, resource)
    actual.should == expected
  end

  it "should returns nil when response status code is not 200" do
    resource = 'http://somesite.com/resources/content2.shtml'
    stub_request(:get, resource).to_return(:body => 'not found', :status => 404)
    
    actual = Ironhide::Includer.get(resource)

    WebMock.should have_requested(:get, resource)
    actual.should be_nil
  end

  it "should write response to cache" do
    resource = 'http://cdn.somesite.com/cached/jquery.js'
    expected = 'jquery code'
    stub_request(:get, resource).to_return(:body => expected)
    Rails.cache.should_receive(:write).with("Ironhide::Includer::#{Digest::MD5.hexdigest(resource)}", expected, :expires_in => 10.minutes)

    actual = Ironhide::Includer.get(resource)

    WebMock.should have_requested(:get, resource)
    actual.should == expected
  end

  it "should write response to cache with custom timeout" do
    resource = 'http://somesite.com/menu.html'
    expected = 'menu content'
    stub_request(:get, resource).to_return(:body => expected)
    Rails.cache.should_receive(:write).with("Ironhide::Includer::#{Digest::MD5.hexdigest(resource)}", expected, :expires_in => 1.hour)

    actual = Ironhide::Includer.get(resource, 1.hour)

    WebMock.should have_requested(:get, resource)
    actual.should == expected
  end

  it "should return content from cache" do
    resource = 'http://cdn.somesite.com/cached/jquery.min.js'
    expected = 'cached content'
    Rails.cache.should_receive(:read).
      with("Ironhide::Includer::#{Digest::MD5.hexdigest(resource)}").
      and_return(expected)

    actual = Ironhide::Includer.get(resource)

    actual.should == expected
  end

  it "should have cache default timeout" do
    Ironhide::Includer.default_timeout.should == 10.minutes
    Ironhide::Includer.default_timeout = 20.minutes
    Ironhide::Includer.default_timeout.should == 20.minutes
  end
end
