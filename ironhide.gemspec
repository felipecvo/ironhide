# -*- encoding: utf-8 -*-
require File.expand_path("../lib/ironhide/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "ironhide"
  s.version     = Ironhide::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Felipe Oliveira"]
  s.email       = ["felipecvo@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/ironhide"
  s.summary     = "Allows you to include an external html file inside your view."
  s.description = s.summary

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "ironhide"

  s.add_dependency "rails", ">= 2.3"
  s.add_dependency "httpclient", ">= 2.1.5.2"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", ">= 2.2"
  s.add_development_dependency "webmock", ">= 1.6.1"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.test_files   = `git ls-files -- {spec}/*`.split("\n")
  s.require_path = 'lib'
end
