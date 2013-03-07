SPEC_ROOT = File.expand_path(File.dirname(__FILE__)) unless defined?(SPEC_ROOT)
require 'rspec'
require 'capybara/dsl'
#require 'capybara/rspec'
require 'capybara_support/configuration'
require 'selenium-webDriver'
require 'support/common_helper'
require 'support/user_data/user_data_helper'
require 'support/database_support/database_helper'

RSpec.configure do |config|
  config.before(:all) do
    CapybaraSupport::Configuration.reset_capybara
  end
  config.include Capybara::DSL
  CapybaraSupport::Configuration.configure_environment
end
