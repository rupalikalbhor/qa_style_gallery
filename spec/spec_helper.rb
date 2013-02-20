SPEC_ROOT = File.expand_path(File.dirname(__FILE__)) unless defined?(SPEC_ROOT)
require 'rspec'
require 'capybara/dsl'
require 'capybara/rspec'
require 'capybara_support/configuration'
require 'selenium-webDriver'

RSpec.configure do |config|

  config.before(:all) do
    CapybaraSupport::Configuration.reset_capybara
    puts "capybara reset"
  end
  config.include Capybara::DSL
  CapybaraSupport::Configuration.configure_env
end
