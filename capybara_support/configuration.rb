require 'spec/spec_helper'

module CapybaraSupport
  class Configuration
    @default_env = :demo     #This is default environment. If user do not pass any values from command prompt then this environment will be used.
    @default_device = :desktop_chrome  #This is default device. It user do not pass any value from command prompt then this device will be used.

    #This function will reset the capybara
    def self.reset_capybara
      Capybara.reset!
      Capybara.default_wait_time=10
      Capybara.server_boot_timeout = 30
      Capybara.default_selector =:css
      Capybara.ignore_hidden_elements =false
    end

    # This function will configure the capybara
    def self.configure_environment
      @environment = ENV.fetch('ENV_NAME', @default_env).to_sym #This will set environment value from command prompt
      $device = ENV.fetch('DEVICE_NAME', @default_device).to_sym #This will set device value from command prompt
      Capybara.app_host = self.get_environment_url
      Capybara.default_driver= :device_driver
      Capybara.javascript_driver= Capybara.default_driver
      self.register_driver
      Capybara.current_session.driver.browser.manage.window.maximize
      puts "Running on environment: #{@environment}"
      puts "Running on device: #{$device}"
    end

    #This function will return environment url
    def self.get_environment_url
      case @environment
        when :demo
          'http://shopping-ecomm.demo.modcloth.com'
        when :stage
          'http://www.stage.modcloth.com'
        when :production
          'http://www.modcloth.com'
      end
    end

    #This function will register driver for following devices
      #desktop_chrome - On desktop device with chrome broswer
      #desktop_firefox - On desktop device with firefox browser.
      #mobile_iphone - On iPhone mobile device
      #tablet_ipad - On iPad tablet device
    def self.register_driver()
      case $device
        when :desktop_chrome     #For Chrome browser on desktop
          Capybara.register_driver :device_driver do |app|
            Capybara::Selenium::Driver.new(app, :browser => :chrome)
          end

        when :desktop_firefox    #For Firefox browser on desktop
          Capybara.register_driver :device_driver do |app|
            Capybara::Selenium::Driver.new(app, :browser => :firefox)
          end

        when :mobile_iphone      #For iphone mobile
          Capybara.register_driver :device_driver do |app|
            Capybara::Selenium::Driver.new(app, :browser => :remote, :url => 'http://localhost:3001/wd/hub/', :desired_capabilities => :iphone)
          end

        when :tablet_ipad        # For ipad tablet
          Capybara.register_driver :device_driver do |app|
            Capybara::Selenium::Driver.new(app, :browser => :remote, :url => 'http://localhost:3001/wd/hub/', :desired_capabilities => :ipad)
          end
      end
    end
  end
end