require 'spec/spec_helper'

describe 'Browse style gallery' do
  before(:each) do
    go_to_style_gallery_page
    sleep 5
  end

  #it "Verify that outfit detail view opens up"do
  #
  #  #page.find(@id='#latest').click
  #  page.find(:xpath, "//div[@id = 'gallery']/div/div[1]/a/img[contains(@alt,'Open Outfit Link')]").click
  #  #page.should have_selector(:xpath, "//div[@class= 'outfit-detail']/div/button[contains(@class, 'close')]")    --finds close button
  #  #page.should have_css("button.close")        -- finds close button
  #  #page.find(:xpath, "//div[@class= 'user-details']/div/div/div/div/div/img[contains(@alt,'Heart1')]").click
  ##page.find(:xpath, "//div[@class= 'user-details']/div/div[1]/div[1]/div[2][contains(@class,'love-button')]")    #doesnt work for mobile love the outfit
  ##  page.should have_css(".love-button.unloved")    # if outfit is not loved by user or user is not signed in
  #  # page.find(:xpath,"//ul[@class= 'detail-header']/li[2]/div/div[2][contains(@class, 'love-button')]").click     #love an outfit from outfit detail page
  #  #within('#outfit-detail-container')   do
  #  #page.find('.love-button').click                  #instead of xpath within can also be used
  #  #sleep 5
  #  #       end
  #  #page.find(:xpath, "//div[@class='user-details']/div/span/div[1][contains(@class, 'social-sharing-product')]/a[1][contains(@class, 'pinterest')]").click      --- for sharing via pinterest xpath and click both
  #  #page.execute_script "window.scrollBy(0,'$(window).height()')"
  #  sleep 10
  #    end


  #it 'Verify scroll works and it loads outfits' do
  #  def scroll
  #    #page.find('#featured').click
  #    b=0
  #    begin
  #      t = page.evaluate_script "$(document).height() -($(window).scrollTop() + $(window).height())"
  #      t.to_f
  #      a= page.evaluate_script"$(document).height()"
  #      page.find(:xpath, "//div[@id = 'gallery']/div[@class='outfits']/div/a/img[contains(@alt,'Open Outfit Link')]")
  #      page.execute_script "window.scrollBy(#{b}, #{a})"
  #      sleep 2
  #      b=  a
  #    end while t > 0
  #  end
  #  scroll
  #end
end



