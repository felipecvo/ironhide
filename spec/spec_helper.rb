require 'rubygems'
require 'bundler/setup'

require 'ironhide'

require 'webmock/rspec'

RSpec.configure do |config|
  Class.new(Rails::Application)
  Rails.application.initializers.select { |x| x.name == :initialize_cache }.first.run
end
