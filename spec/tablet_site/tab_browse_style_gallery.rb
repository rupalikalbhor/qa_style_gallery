require 'spec/spec_helper'

describe 'Browse style gallery on tablet' do
  before(:each) do
    go_to_style_gallery_page
    wait_for_script
  end

  it 'Verify style gallery banner' do
    page.find(:xpath, '//div[@id = "style-exchange-banner"]/img[@alt = "Style Gallery"]')
  end

  it 'Verify user see all 3 tabs' do
    page.find(:xpath, "//ul[@id ='primary-filters']/li[1]/a[@id = 'latest' and @src = '/latest']")
    page.find(:xpath, "//ul[@id ='primary-filters']/li[2]/a[@id = 'loved' and @src = '/loved']")
    page.find(:xpath, "//ul[@id ='primary-filters']/li[3]/a[@id = 'featured' and @src = '/featured']")
  end

  it 'Verify "Latest" tab contains outfit and it is not blank.' do
    page.find(:xpath, "//div[@id = 'gallery']/div/div[1]/a/img[contains(@alt,'Open Outfit Link')]")
  end

  it 'Verify "Most Loved" tab contains outfit and it is not blank.' do
    page.find('#loved').click
    page.find(:xpath, "//div[@id = 'gallery']/div/div[1]/a/img[contains(@alt,'Open Outfit Link')]")
  end

  it 'Verify "Featured" tab contains outfit and it is not blank.' do
    page.find('#featured').click
    page.find(:xpath, "//div[@id = 'gallery']/div/div[1]/a/img[contains(@alt,'Open Outfit Link')]")
  end

  it 'Verify "Latest" tab is not blank' do
    page.find('#latest').click
    page.find(:xpath, "//div[@id = 'gallery']/div/div[1]/a/img[contains(@alt,'Open Outfit Link')]")
  end

  it 'Verify tabs go on clicked filter' do
    page.should have_css("a#latest.active") # by default user is directed to latest filter on gallery
    page.find('#featured').click #user is directed to featured on clicking featured
    page.should have_css("a#featured.active")
    sleep 10
    page.find('#loved').click #user is directed to most loved on clicking most loved
    page.should have_css("a#loved.active")
    sleep 10
    page.find('#latest').click #user is directed to latest on clicking latest
    page.should have_css("a#latest.active")
    sleep 10

  end

  it 'Verify 2 column layout' do
    page.find(:xpath, "//div[@id = 'gallery']/div/div[1][contains(@style,'left: 0px;')]")
    page.find(:xpath, "//div[@id = 'gallery']/div/div[2][contains(@style,'left: 381px;')]")
    page.find(:xpath, "//div[@id = 'gallery']/div/div[3][contains(@style,'left: 0px;')]")
  end
end