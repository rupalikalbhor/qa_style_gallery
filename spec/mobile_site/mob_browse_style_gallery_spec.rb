require 'spec/spec_helper'

describe 'Browse style gallery on mobile' do
  before(:each) do
    go_to_style_gallery_page
    wait_for_script
  end

  context 'Home page:' do
    it 'should display style gallery banner.' do
      page.find(:xpath, '//div[@id = "style-exchange-banner"]/img[@alt = "Style Gallery"]')
    end

    it 'should display 3 tabs (Latest, Loved, Featured) with hyperlink.' do
      page.find(:xpath, "//ul[@id ='primary-filters']/li[1]/a[@id = 'latest' and @src = '/latest']")
      page.find(:xpath, "//ul[@id ='primary-filters']/li[2]/a[@id = 'loved' and @src = '/loved']")
      page.find(:xpath, "//ul[@id ='primary-filters']/li[3]/a[@id = 'featured' and @src = '/featured']")
    end

    it 'should display one column layout.' do
      page.find(:xpath, "//div[@id = 'gallery']/div/div[1][contains(@style,'position: static; width: auto;')]")
      page.find(:xpath, "//div[@id = 'gallery']/div/div[2][contains(@style,'position: static; width: auto;')]")
      page.find(:xpath, "//div[@id = 'gallery']/div/div[3][contains(@style,'position: static; width: auto;')]")
    end
  end

  context 'Latest Tab:' do
    it 'should contains outfit with image.' do
      page.find(:xpath, "//div[@id = 'gallery']/div/div[1]/a/img[contains(@alt,'Open Outfit Link')]")
    end

    it 'should go on clicked filter.' do
      page.should have_css("a#latest.active") # by default user is directed to latest filter on gallery
    end
  end

  context 'Most Loved Tab:' do
    it 'should contains outfit with image' do
      page.find('#loved').click
      page.find(:xpath, "//div[@id = 'gallery']/div/div[1]/a/img[contains(@alt,'Open Outfit Link')]")
    end

    it 'should go on clicked filter.' do
      page.find('#loved').click #user is directed to most loved on clicking most loved
      page.should have_css("a#loved.active")
    end
  end

  context 'Featured Tab:' do
    it 'should contains outfit with image' do
      page.find('#featured').click
      page.find(:xpath, "//div[@id = 'gallery']/div/div[1]/a/img[contains(@alt,'Open Outfit Link')]")
    end

    it 'should go on clicked filter.' do
      page.find('#featured').click #user is directed to featured on clicking featured
      page.should have_css("a#featured.active")
    end
  end
end
