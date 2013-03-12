require 'spec/spec_helper'

def go_to_style_gallery_page
  visit '/style-gallery'
end

def wait_for_script(wait_time = Capybara.default_wait_time)
  wait_until(wait_time) do
    page.evaluate_script('$.active') == 0
  end
end

private
def should_be_signed_in_as_user(name, email)
  name = get_short_name(name, email)
  return name
end

private
def get_short_name(name, email)
  if (name == '')
    name = email.match(/([\S]+)@/)[1]
    if (name.length > 15)
      name = "#{name[0..14]}..."
    else
      name
    end
  elsif (name.length > 15)
    name = "#{name[0..14]}..."
  end
  return name
end

private
def generate_new_email
  number = Time.now.to_i.to_s
  "new-user#{number}@example.com"
end

def click_sign_in_link
  case $device
    when :mobile_iphone
      click_phone_sign_in_link
    when :tablet_ipad
      click_tablet_sign_in_link
    when :desktop_chrome
      click_desktop_sign_in_link
    when :desktop_firefox
      click_desktop_sign_in_link
  end
end

private
def click_phone_sign_in_link
  within ('#mc-phone-header-welcome') do
    page.find(:xpath, '//a[@id="mc-phone-header-join"]', :visible => true).click
    wait_for_script
  end
end

private
def click_tablet_sign_in_link
  page.find(:xpath, '//a[@id="mc-header-sign-in"]', :visible => true).click
  wait_for_script
end

private
def click_desktop_sign_in_link
  within ('#mc-header-personalization') do
    page.find(:xpath, '//a[@id="mc-header-sign-in"]', :visible => true).click
    wait_for_script
  end
end

def sign_in()
  sign_in_user_info
  case $device
    when :mobile_iphone
      sign_in_phone
    when :tablet_ipad
      sign_in_tablet
    when :desktop_chrome
      sign_in_desktop
    when :desktop_firefox
      sign_in_desktop
  end
end

private
def sign_in_user_info
  user_data = get_sign_in_user_data
  @sign_in_user_email = user_data['email']
  @sign_in_user_password = user_data['password']
end

private
def sign_in_desktop
  page.find(:xpath, '//input[@id = "email"]', :visible => true)
  within ('#login-form') do
    fill_in 'email', :with => @sign_in_user_email
    fill_in 'sign_in_password', :with => @sign_in_user_password
    click_button('Sign In')
    wait_for_script
  end
  name = should_be_signed_in_as_user('', @sign_in_user_email)
  page.has_xpath?('//div[@id="mc-header-hello"]/span', :visible => true)
  page.find(:xpath, '//div[@id="mc-header-hello"]/span').text.should eq('Hello,')
  page.find(:xpath, '//a[@id="mc-header-welcome-name"]').text.should eq(name)
end

private
def sign_in_tablet
  page.find(:xpath, "//input[@id = 'email']", :visible => true)
  within ('#login-form') do
    fill_in 'email', :with => @sign_in_user_email
    fill_in 'sign_in_password', :with => @sign_in_user_password
    click_button('Sign In')
    wait_for_script
  end
  name = should_be_signed_in_as_user('', @sign_in_user_email)
  page.has_xpath?('//div[@id="mc-header-hello"]/span', :visible => true)
  page.find(:xpath, '//div[@id="mc-header-hello"]/span').text.should eq('Hello,')
  page.find(:xpath, '//div[@id="mc-header-hello"]/a').text.should eq(name)
end

private
def sign_in_phone
  page.find(:xpath, '//input[@id = "email"]', :visible => true)
  within ('#signin-form') do
    fill_in 'email', :with => @sign_in_user_email
    fill_in 'password', :with => @sign_in_user_password
    click_button('Sign In')
    wait_for_script
  end
  name = should_be_signed_in_as_user('', @sign_in_user_email)
  page.has_xpath?('//div[@id="mc-phone-header-welcome"]/span', :visible => true)
  page.find(:xpath, '//div[@id="mc-phone-header-welcome"]/span').text.should eq('Hello')
  page.find(:xpath, '//div[@id="mc-phone-header-welcome"]/a').text.should eq(name)
end

def sign_out()
  case $device
    when :mobile_iphone
      sign_out_iphone()
    when :tablet_ipad
      sign_out_ipad()
    when :desktop_chrome
      sign_out_desktop()
    when :desktop_firefox
      sign_out_desktop()
  end
end

private
def sign_out_desktop
  wait_until {
    page.find(:xpath, '//a[@id = "mc-header-sign-out"]').visible? == true
  }
  page.find(:xpath, '//a[@id = "mc-header-sign-out"]', :visible => true).click
  wait_until {
    page.find(:xpath, '//a[@id = "mc-header-sign-in"]').visible? == true
  }
end

private
def sign_out_ipad
  page.find(:xpath, '//a[@id = "mc-header-sign-out"]', :visible => true).click
  wait_until {
    page.find(:xpath, '//a[@id = "mc-header-sign-in"]').visible? == true
  }
end

private
def sign_out_iphone
  page.has_xpath?('//div[@id = "mc-phone-header-welcome"]/a[@class = "member-dropdown"]', :visible => true)
  page.find(:xpath, '//div[@id = "mc-phone-header-welcome"]/a[@class = "member-dropdown"]', :visible => true).click
  page.find(:xpath, '//a[@class = "button button-medium"]', :visible => true).click
  page.has_xpath?('//a[@id = "mc-phone-header-join"]', :visible => true)
  page.should have_xpath('//a[@id = "mc-phone-header-join"]', :text => 'Join or Sign In')
end

def join
  email_address = generate_new_email
  case $device
    when :mobile_iphone
      join_phone(email_address)
    when :tablet_ipad
      join_tablet(email_address)
    when :desktop_chrome
      join_desktop(email_address)
    when :desktop_firefox
      join_desktop(email_address)
  end
end

def join_desktop(email_address)
  page.has_xpath?('//a[@href = "/join?gate=join"]', :visible => true)
  within ('#mc-header-personalization') do
    page.find(:xpath, '//a[@id="mc-header-join"]', :visible => true).click
    wait_for_script
  end

  within ('#account-form') do
    fill_in 'Email Address', :with => email_address
    fill_in 'Password', :with => 'password'
    fill_in 'Confirm Password', :with => 'password'
    click_button('Join')
  end
  name = should_be_signed_in_as_user('', email_address)
  page.has_xpath?("//div[@id='mc-header-hello']/span", :visible => true)
  page.find(:xpath, "//div[@id='mc-header-hello']/span", :visible => true).text == 'Hello,'
  page.find(:xpath, "//a[@id='mc-header-welcome-name']", :visible => true).text == name
  return email_address
end

def join_tablet(email_address)
  page.find(:xpath, '//a[@id="mc-header-join"]', :visible => true).click
  wait_for_script
  within ('#account-form') do
    fill_in 'Email Address', :with => email_address
    fill_in 'Password', :with => 'password'
    fill_in 'Confirm Password', :with => 'password'
    click_button('Join')
  end
  name = should_be_signed_in_as_user('', email_address)
  page.has_xpath?('//div[@id="mc-header-hello"]/span', :visible => true)

  page.find(:xpath, '//div[@id="mc-header-hello"]/span', :visible => true).text.should eq('Hello,')
  page.find(:xpath, '//div[@id="mc-header-hello"]/a', :visible => true).text.should eq(name)
  return email_address
end

def join_phone(email_address)
  page.find(:xpath, '//a[@id="mc-phone-header-join"]', :visible => true).click
  wait_for_script
  page.has_xpath?('//input[@id = "account_email"]', :visible => true)
  within ('#signup-form') do
    fill_in 'account_email', :with => email_address
    fill_in 'account_password', :with => 'password'
    fill_in 'account-password-confirmation', :with => 'password'
    click_button('Join')
  end
  wait_until {
    page.has_xpath?('//div[@id="mc-phone-header-welcome"]/span', :visible => true)
    name = should_be_signed_in_as_user('', email_address)
    page.find(:xpath, '//div[@id="mc-phone-header-welcome"]/span', :visible => true).text.should eq('Hello')
    page.find(:xpath, '//div[@id="mc-phone-header-welcome"]/a', :visible => true).text.should eq(name)
  }
  return email_address
end

def get_unloved_outfit_id
  unloved_outfit_id = page.evaluate_script("$('.love-button.unloved').parent().parent().parent().parent().parent().attr('data-id')").to_s
  return unloved_outfit_id
end

def get_loved_outfit_id
  loved_outfit_id = page.evaluate_script("$('.love-button.loved').parent().parent().parent().parent().parent().attr('data-id')").to_s
  return loved_outfit_id
end


def outfit_detail_desktop(outfit_id,love_count,time,username,personal_website_url)
  page.find(:xpath, "//div[@id = 'gallery']/div/div[1]/a/img[contains(@alt,'Open Outfit Link')]").click
  #current_path.should == "/style-gallery/outfits/#{outfit_id}"
  #$outfitid ="#{outfit_id}"
  within(:css, ".details.row")   do
    #page.should have_content("#{username}")
    page.should have_css(".uploader-name", :text=> "#{username}")      # verify uploader name
    page.has_css?(".loves-count", :text => "#{love_count}")     # verify love_count
                                                                       #page.should have_content("#{time}")      #currently it doesnt work, time needs to be fixed in database_helper.rb          # verify time shows up correctly
    page.should have_css(".love-button.unloved")            # if outfit is not loved by user or user is not signed in
    page.find(:xpath, "//div[@class= 'user-details']/div/div[1]/div[1]/div[2][contains(@class,'love-button')]")
    page.find(:xpath, "//div[@class='user-details']/div/span/div[1][contains(@class, 'social-sharing-product')]/a[1][contains(@class, 'pinterest')]")
    page.find(:xpath, "//div[@class='user-details']/div/span/div[1][contains(@class, 'social-sharing-product')]/a[2][contains(@class, 'twitter')]")
    page.find(:xpath, "//div[@class='user-details']/div/span/div[1][contains(@class, 'social-sharing-product')]/a[3][contains(@class, 'facebook')]")
  end
  page.should have_css("button.close")
  click_button "x"
end

