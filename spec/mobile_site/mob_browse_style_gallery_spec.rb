require 'spec/spec_helper'

describe 'Browse style gallery' do
  before(:each) do
    go_to_style_gallery_page
  end

  it 'Verify style gallery banner' do
    page.find(:xpath, '//div[@id = "style-exchange-banner"]/img[@alt = "Style Gallery"]')
  end

  it 'Verify one column layout', :type => :request do
    page.find(:xpath, "//div[@id = 'gallery']/div/div[1][contains(@style,'left: 0px;')]")
    page.find(:xpath, "//div[@id = 'gallery']/div/div[2][contains(@style,'left: 0px;')]")
    page.find(:xpath, "//div[@id = 'gallery']/div/div[3][contains(@style,'left: 0px;')]")
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

  it 'Verify when user clicks on "Most Loved" tab then user see 3 links and by default user navigates to "This week" page.' do
    page.find('#loved').click
    within('#secondary-filters')do
      page.find_link('All Time')
      page.find_link('This Week')
      page.find_link('Today')
      page.should have_css('a#week.active')
    end
  end

end
