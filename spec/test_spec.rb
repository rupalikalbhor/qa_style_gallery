require 'spec/spec_helper'
require 'support/common_helper'

describe 'Browse style gallery' do
  before(:each) do
    go_to_style_gallery_page
  end

  it 'test' do
    outfit_id,love_count,moderated_at,firstname, lastname, personal_website_url = connection(:query_name => :most_loved_This_week_outfit_details)

    puts "outfit id is ****************- #{outfit_id}"
    puts "love count is ****************- #{love_count}"
    puts "moderated at is ****************- #{moderated_at}"
    puts "first name is ****************- #{firstname}"
    puts "last name is ****************- #{lastname}"
    puts "personal website url is ****************- #{personal_website_url}"
  end
end