require 'spec/spec_helper'

describe 'Desktop header' do
  before(:all) do
    go_to_style_gallery_page
  end

  context 'Sign in' do
    it 'should sign in user successfully.' do
      click_sign_in_link
      sign_in
    end

    it 'should navigate user to style gallery homepage.' do
      page.find('#style-exchange-banner')
    end
  end

  context 'Sign out' do
    it 'should sign out user successfully.' do
      sign_out
    end

    it 'should navigate user to style gallery homepage.' do
      page.find('#style-exchange-banner')
    end
  end

  context 'Join' do
    it 'should join user successfully.' do
      join
    end

    it 'should navigate user to style gallery homepage.' do
      page.find('#style-exchange-banner')
      sign_out
    end
  end
end