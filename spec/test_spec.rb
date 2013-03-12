require 'spec/spec_helper'
require 'support/common_helper'

#describe 'Browse style gallery' do
#  before(:each) do
#    go_to_style_gallery_page
#  end
#
#  it 'test' do
#    outfit_id,love_count,moderated_at,username,personal_website_url = connection(:query_name => :latest_tab_outfit_details)
#
#    puts "outfit id is ****************- #{outfit_id}"
#    puts "love count is ****************- #{love_count}"
#    puts "moderated at is ****************- #{moderated_at}"
#    #puts "first name is ****************- #{firstname}"
#    #puts "last name is ****************- #{lastname}"
#    puts "personal website url is ****************- #{personal_website_url}"
#     puts username
#
#  end
#end


describe 'Quick Look' do
  outfit_id, love_count, outfit_time, username, personal_website_url = connection(:query_name => :latest_tab_outfit_details)
  puts "username is:  #{username}"
  puts "outfit id is ****************- #{outfit_id}"
  puts "love count is ****************- #{love_count}"
  puts "moderated at is ****************- #{outfit_time}"
  puts "personal website url is ****************- #{personal_website_url}"

  before(:all) do
    go_to_style_gallery_page
  end

  context 'Outfit details' do
    it 'should display outfit image' do
      page.find(:xpath, "//div[@data-id ="+outfit_id+"]/a/img[contains(@alt,'Open Outfit Link "+outfit_id+"')]")
    end

    puts "outfit id is ****************- #{outfit_id}"
    puts "love count is ****************- #{love_count}"
    puts "moderated at is ****************- #{moderated_at}"
    #puts "first name is ****************- #{firstname}"
    #puts "last name is ****************- #{lastname}"
    puts "personal website url is ****************- #{personal_website_url}"
     puts username

    it 'should display username' do
      expected_username = page.find(:xpath, "//div[@data-id ="+outfit_id+"]/div/div[@class='left']/strong").text
      actual_username = username
      expected_username.should == actual_username
    end

    it 'should display outfit time' do
      expected_outfit_time = page.find(:xpath, "//div[@data-id ="+outfit_id+"]/div/div[@class='left']/p").text
      actual_outfit_time = outfit_time
      expected_outfit_time.should == actual_outfit_time
    end
  end

  context 'Love it' do
    before(:all) do
      click_sign_in_link
      sign_in
      wait_for_script
    end
    it 'should display love it button.' do
      page.find(:xpath, "//div[@class = 'love-button unloved']",:visible => true)
    end

    it 'should increment the love count when logged in user click on Love it.' do
      unloved_outfit_id = get_unloved_outfit_id
      if (unloved_outfit_id == '')
       puts "There is no outfit with unloved id.."
      else
        before_love_count = page.find(:xpath, "//div[@data-id = "+unloved_outfit_id+"]/div/div[@class = 'right']/div[@class = 'bb-love-button gallery-view']/div/div[@class = 'loves-count']").text
        page.find(:xpath, "//div[@data-id = "+unloved_outfit_id+"]/div/div[@class = 'right']/div[@class = 'bb-love-button gallery-view']/div/div[@class = 'love-button unloved']").click
        page.find(:xpath, "//div[@data-id = "+unloved_outfit_id+"]/div/div[@class = 'right']/div[@class = 'bb-love-button gallery-view']/div/div[@class = 'love-button loved']", :visible => true)
        after_love_count = page.find(:xpath, "//div[@data-id = "+unloved_outfit_id+"]/div/div[@class = 'right']/div[@class = 'bb-love-button gallery-view']/div/div[@class = 'loves-count']").text
        after_love_count.to_i.should == before_love_count.to_i + 1
      end
    end

    it 'should decrement the love count when logged in user click on unlove it.' do
        loved_outfit_id = get_loved_outfit_id
        if (loved_outfit_id == '')
          puts "There is no outfit with loved id.."
        else
          before_love_count = page.find(:xpath, "//div[@data-id = "+loved_outfit_id+"]/div/div[@class = 'right']/div[@class = 'bb-love-button gallery-view']/div/div[@class = 'loves-count']").text
          page.find(:xpath, "//div[@data-id = "+loved_outfit_id+"]/div/div[@class = 'right']/div[@class = 'bb-love-button gallery-view']/div/div[@class = 'love-button loved']").click
          page.find(:xpath, "//div[@data-id = "+loved_outfit_id+"]/div/div[@class = 'right']/div[@class = 'bb-love-button gallery-view']/div/div[@class = 'love-button unloved']", :visible => true)
          after_love_count = page.find(:xpath, "//div[@data-id = "+loved_outfit_id+"]/div/div[@class = 'right']/div[@class = 'bb-love-button gallery-view']/div/div[@class = 'loves-count']").text
          after_love_count.to_i.should == before_love_count.to_i - 1
        end
    end

    it 'should increment the love count when logged out user click on Love it.' do
      unloved_outfit_id = get_unloved_outfit_id
      sign_out
      if (unloved_outfit_id == '')
        puts "There is no outfit with unloved id.."
      else
        page.find(:xpath, "//div[@data-id = "+unloved_outfit_id+"]/div/div[@class = 'right']/div[@class = 'bb-love-button gallery-view']/div/div[@class = 'love-button unloved']").click
        sign_in
        wait_for_script
        page.should have_css("a#latest.active")
      end
    end
    after(:all) do
      sign_out
    end
  end
end
