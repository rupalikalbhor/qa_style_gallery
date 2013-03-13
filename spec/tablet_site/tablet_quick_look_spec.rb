require 'spec/spec_helper'

describe 'Quick Look' do
  outfit_id, love_count, outfit_time, username, personal_website_url = connection(:query_name => :latest_tab_outfit_details)
  before(:all) do
    go_to_style_gallery_page
  end

  context 'Quick Look Outfit details' do
    it 'should display outfit image' do
      page.find(:xpath, "//div[@data-id ="+outfit_id+"]/a/img[contains(@alt,'Open Outfit Link "+outfit_id+"')]")
    end

    it 'should display correct love count' do
      expected_love_count= page.find(:xpath, "//div[@data-id ="+outfit_id+"]/div/div[@class='right']/div[@class = 'bb-love-button gallery-view']/div/div[@class = 'loves-count']").text
      actual_love_count = love_count
      expected_love_count.should == actual_love_count
    end

    it 'should display username' do
      actual_username = page.find(:xpath, "//div[@data-id ="+outfit_id+"]/div/div[@class='left']/strong").text
      expected_username = username
      expected_username.should == actual_username
    end

    it 'should display outfit time' do
      actual_outfit_time = page.find(:xpath, "//div[@data-id ="+outfit_id+"]/div/div[@class='left']/p").text
      expected_outfit_time = outfit_time
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