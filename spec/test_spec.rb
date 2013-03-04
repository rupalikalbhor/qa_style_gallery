require 'spec/spec_helper'
require 'support/common_helper'

describe 'Browse style gallery' do
  before(:each) do
    go_to_style_gallery_page
  end

  it 'test' do
    join
    sign_out
  end
end