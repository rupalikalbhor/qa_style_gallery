require 'spec/spec_helper'

describe 'Mobile header' do
  before(:all) do
    go_to_style_gallery_page
  end

  it 'Verify user gets sign in successfully.' do
    click_sign_in_link
    sign_in
  end

  it 'Verify after successfully sign, user navigates to style gallery homepage.' do
    page.find('#style-exchange-banner')
  end

  it 'Verify user gets sign out successfully.' do
    sign_out
  end

  it 'Verify after successfully sign out, user navigates to style gallery homepage.' do
    page.find('#style-exchange-banner')
  end

  it 'Verify user gets sign joined successfully.' do
    join
  end

  it 'Verify after successfully join, user navigates to style gallery homepage.' do
    page.find('#style-exchange-banner')
    sign_out
  end
end