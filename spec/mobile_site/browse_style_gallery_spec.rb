require 'spec/spec_helper'

describe 'Browse style gallery' do
  before(:each) do
    go_to_style_gallery_page
  end

  it 'Verify user see all 3 tabs' do
    page.find(:xpath, "//ul[@id ='primary-filters']/li[1]/a[@id = 'latest' and @src = '/latest']")
    page.find(:xpath, "//ul[@id ='primary-filters']/li[2]/a[@id = 'loved' and @src = '/loved']")
    page.find(:xpath, "//ul[@id ='primary-filters']/li[3]/a[@id = 'featured' and @src = '/featured']")
  end

  it 'Verify "Latest" tab contains outfit and it is not blank.' do
    page.find(:xpath, "//div[@id = 'gallery']/div[@class='outfits columns-1']/div[1]/a/img[contains(@alt,'Open Outfit Link')]")
  end

  it 'Verify "Most Loved" tab contains outfit and it is not blank.' do
    page.find('#loved').click
    page.find(:xpath, "//div[@id = 'gallery']/div[@class='outfits columns-1']/div[1]/a/img[contains(@alt,'Open Outfit Link')]")
  end

  it 'Verify "Featured" tab contains outfit and it is not blank.' do
    page.find('#featured').click
    page.find(:xpath, "//div[@id = 'gallery']/div[@class='outfits columns-1']/div[1]/a/img[contains(@alt,'Open Outfit Link')]")
  end
end


