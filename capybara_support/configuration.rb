#$: << File.expand_path(File.dirname(__FILE__) + "/../support")
#$ROOT_PATH = File.expand_path(File.dirname(__FILE__))
require 'capybara'
require 'selenium-webDriver'

module CapybaraSupport
  class Configuration
    @default_env= :demo

    def self.reset_capybara
      Capybara.reset!
      Capybara.current_driver= Capybara.default_driver
      Capybara.javascript_driver= Capybara.default_driver
      Capybara.default_wait_time=10
      Capybara.server_boot_timeout = 30
      Capybara.default_selector =:css
      Capybara.ignore_hidden_elements =false
    end

    def self.configure_env

    Capybara.run_server=false
      Capybara.app_host = 'http://shopping-ecomm.demo.modcloth.com'
      Capybara.default_driver= :selenium_iphone   #This is registered driver in get_browser method
      self.get_browser
    end

    def self.get_browser
      #puts "Android"
      #Capybara.register_driver :selenium_android do |app|
      #
      #
      #  Capybara::Selenium::Driver.new(app,:browser => :remote, :url => 'http://127.0.0.1:8080/wd/hub')

            puts "Selenium iphone on simulator"
        Capybara.register_driver :selenium_iphone do |app|
          Capybara::Selenium::Driver.new(app, :browser => :remote, :url => 'http://localhost:3001/wd/hub/',:desired_capabilities => :iphone)

    #  puts "Selenium ipad on simulator"
    #  Capybara.register_driver :selenium_iphone do |app|
    #  Capybara::Selenium::Driver.new(app, :browser => :remote, :url => 'http://ipaddress of local host :3001/wd/hub',:desired_capabilities => :ipad)
    #
    #  puts "Safari browser"
    #  Capybara.register_driver :selenium_iphone do |app|
    #  Capybara::Selenium::Driver.new(app, :browser => :safari, :url => 'http://ipaddress of local host :3001/wd/hub')
    #
    #  puts "Firefox or Chrome browser"
    #  Capybara.register_driver :selenium_iphone do |app|
    #  Capybara::Selenium::Driver.new(app, :browser => :firefox)
    #

    end
    end
  end
end

#  module CapybaraSupport
#  class Configuration
#    @default_env= :demo
#    #@default_browser = :firefox
#    #@default_device= :iphone
#    #@default_driver= :selenium_iphone
#
#    def self.reset_capybara
#      Capybara.reset!
#      Capybara.current_driver= Capybara.default_driver
#      Capybara.javascript_driver= Capybara.default_driver
#      Capybara.default_wait_time=10
#      Capybara.server_boot_timeout = 30
#      Capybara.default_selector =:css
#      Capybara.ignore_hidden_elements =false
#    end
#
#    def self.get_browser
#      #     case @browser_name
#      #        when :firefox
#      #          puts "Running tests using FIREFOX browser"
#      #          profile = Selenium::WebDriver::Firefox::Profile.new
#      #         profile.assume_untrusted_certificate_issuer = false
#      #          Capybara.register_driver :selenium do |app|
#      #            Capybara::Selenium::Driver.new(app, :profile => profile)
#      #
#      #
#      #        end
#      #when :chrome
#      #  Capybara.register_driver :selenium do |app|
#      #             args = []
#      #              #args << "--window-size=320,480"
#      #              # you can also set the user agent
#      #                args << "--user-agent='Mozilla/5.0 (iPhone; CPU iPhone OS 5_0 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9A334 Safari/7534.48.3'"
#      #        end
#      #                 Capybara::Selenium::Driver.new(app, :browser => :chrome, :args => args)
#      #    end
#      #
#      #    when:iphone
#      Capybara.register_driver :selenium_iphone do |app|
#        Capybara::Selenium::Driver.new(app, :browser => :remote, :url => 'http://10.3.10.92:3001/wd/hub/', :desired_capabilities => :iphone)
#      end
#      #@driver = Selenium::Driver.new(:browser => :remote, :url => 'http://10.3.30.92:3001/wd/hub', :desired_capabilities => :iphone)
#      #@driver = Selenium::WebDriver.for :chrome
#      #@base_url = "http://www.google.com/"
#      @driver.manage.timeouts.implicit_wait = 30
#      @verification_errors = []
#    end
#
#
#    run_server=true
#    Capybara.app_host = 'http://shopping-ecomm.demo.modcloth.com'
#    Capybara.default_driver = :selenium
#    #self.get_browser
#    #driver = Selenium::Webdriver.for :firefox , :profile =>profile
#    #Capybara.default_driver = :selenium
#    #Capybara.default_selector = :css
#  end
#
#end
#
#

