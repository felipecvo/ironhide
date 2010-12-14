require 'spec_helper'

include Ironhide::Helpers::IncluderHelper

describe Ironhide::Helpers::IncluderHelper do
  before(:each) do
    @url = 'http://www.thatsite.com/full_content.html'
    @expected = 'ok'
    stub_request(:get, @url).to_return(:body => @expected)
  end

  it 'should provide helper method to get file contents' do
    actual = file_get_contents(@url)

    actual.should == @expected
  end

  it 'should be included in ActionView::Base' do
    actual = ActionView::Base.new.file_get_contents(@url)

    actual.should == @expected
  end
end
