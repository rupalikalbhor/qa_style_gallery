SPEC_ROOT = File.expand_path(File.dirname(__FILE__)) unless defined?(SPEC_ROOT)
require 'rspec'
require 'capybara/dsl'
require 'capybara/rspec'
require 'capybara_support/configuration'
require 'selenium-webDriver'
require 'spec/common_helper'
require 'database_cleaner'

RSpec.configure do |config|
  config.before(:all) do
    CapybaraSupport::Configuration.reset_capybara
  end
  config.include Capybara::DSL
  CapybaraSupport::Configuration.configure_environment

  #config.before(:suite) do
  #  DatabaseCleaner.strategy = :transaction
  #  DatabaseCleaner.clean_with(:truncation)
  #end
  #
  #config.before(:each) do
  #  DatabaseCleaner.start
  #end
  #
  #config.after(:each) do
  #  DatabaseCleaner.clean
  #end
end
