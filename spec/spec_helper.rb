require 'rubygems'

begin
  # rails 3.0.x
  require 'rails'
  require 'rails/application/configurable'
  require 'rails/application/configuration'
  require 'rails/application/bootstrap'
  require 'rails/application/railties'
  require 'rails/application/finisher'
  require 'action_view'
  require 'action_view/base'
  require 'action_view/helpers'
  require 'action_view/lookup_context'
  require 'action_view/paths'
  require 'active_support/cache'
  require 'active_support/cache/memory_store'
rescue LoadError
  # rails 2.3.x
  require 'initializer'
  require 'action_view'
  require 'action_view/base'
  require 'action_view/helpers'
  require 'action_view/paths'
  require 'active_support/cache'
  require 'active_support/cache/memory_store'
end

require 'bundler/setup'

require 'ironhide'

require 'webmock/rspec'

RSpec.configure do |config|
  if Rails.version.split('.').first == '3'
    Class.new(Rails::Application)
    Rails.application.initializers.select { |x| x.name == :initialize_cache }.first.run
  else
    RAILS_ROOT = "./"
    Rails::Initializer.new(Rails::Configuration.new).initialize_cache
  end
end
