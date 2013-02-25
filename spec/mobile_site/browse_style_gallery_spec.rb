require 'spec/spec_helper'

describe 'Browse style gallery' do
  it 'Verify user see all 3 tabs' do
    go_to_style_gallery_page

    page.find('#featured').click
    sleep 10
  end
end


