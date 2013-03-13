require 'spec/spec_helper'


describe 'Browse style gallery' do
  before(:each) do
    go_to_style_gallery_page
    sleep 5
  end




  it "Verify outfit detail on latest tab "do
    outfit_id,love_count,time,username,personal_website_url = connection(:query_name => :latest_tab_outfit_details)
    outfit_detail_desktop(outfit_id,love_count,time,username,personal_website_url)
    end

  it "Verify outfit detail on featured tab "do
    page.find('#featured').click
    outfit_id,love_count,time,username,personal_website_url = connection(:query_name => :featured_tab_outfit_details)
    outfit_detail_desktop(outfit_id,love_count,time,username,personal_website_url)
  end

  it "Verify outfit detail on most loved tab" do
    page.find('#loved').click
    # if user clicks on most loved by default 'this week' loads up
    wait_for_script
    outfit_id,love_count,time,username,personal_website_url = connection(:query_name => :most_loved_This_week_outfit_details)
    outfit_detail_desktop(outfit_id,love_count,time,username,personal_website_url)
  end

  it "Verify outfit detail on most loved all tab" do
    page.find('#loved').click
    page.find('#all').click
    # if user clicks on most loved by default 'this week' loads up
    outfit_id,love_count,time,username,personal_website_url = connection(:query_name => :most_loved_All_time_tab_outfit_details)
    outfit_detail_desktop(outfit_id,love_count,time,username,personal_website_url)
  end


      #page.should have_xpath("//p[contains(@class,'date-added')]")
    #  page.should have_content("#{time}")

   #
   # page.should have_selector(:xpath, "//div[@class= 'outfit-detail']/div/button[contains(@class, 'close')]")    --finds close button
   # page.should have_css(".love-button.unloved")
   #
   # #page.should have_css("button.close")        -- finds close button
   # #page.find(:xpath, "//div[@class= 'user-details']/div/div/div/div/div/img[contains(@alt,'Heart1')]").click
   # #page.find(:xpath, "//div[@class= 'user-details']/div/div[1]/div[1]/div[2][contains(@class,'love-button')]").click    # love the outfit
   # page.should have_css(".love-button.unloved")    # if outfit is not loved by user or user is not signed in
   #
   # sleep 5
   #
   #page.find(:xpath, "//div[@class='user-details']/div/span/div[1][contains(@class, 'social-sharing-product')]/a[1][contains(@class, 'pinterest')]").click      # for sharing via pinterest xpath and click both
   # click_button "x"   #close the modal window
   # sleep 10

    end


