require 'spec/spec_helper'

describe 'Browse style gallery' do
  before(:each) do
    go_to_style_gallery_page
    sleep 5
  end

  it "Verify that outfit detail view opens up"do

    #page.find(@id='#latest').click
    page.find(:xpath, "//div[@id = 'gallery']/div/div[1]/a/img[contains(@alt,'Open Outfit Link')]").click
    #page.should have_selector(:xpath, "//div[@class= 'outfit-detail']/div/button[contains(@class, 'close')]")    --finds close button
    #page.should have_css("button.close")        -- finds close button
    #page.find(:xpath, "//div[@class= 'user-details']/div/div/div/div/div/img[contains(@alt,'Heart1')]").click
    #page.find(:xpath, "//div[@class= 'user-details']/div/div[1]/div[1]/div[2][contains(@class,'love-button')]").click    # love the outfit
    #page.should have_css(".love-button.unloved")    # if outfit is not loved by user or user is not signed in

    sleep 5

   page.find(:xpath, "//div[@class='user-details']/div/span/div[1][contains(@class, 'social-sharing-product')]/a[1][contains(@class, 'pinterest')]").click      # for sharing via pinterest xpath and click both
    click_button "x"   #close the modal window
    sleep 10

  end
    end
