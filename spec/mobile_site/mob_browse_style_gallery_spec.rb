require 'spec/spec_helper'


describe 'Browse style gallery' do
 it 'Verify tabs go on clicked filter' do
    page.should have_css("a#latest.active") # by default user is directed to latest filter on gallery
    page.find('#featured').click                #user is directed to featured on clicking featured
    page.should have_css("a#featured.active")
    sleep 10
    page.find('#loved').click                    #user is directed to most loved on clicking most loved
    page.should have_css("a#loved.active")
    sleep 10
    page.find('#latest').click                  #user is directed to latest on clicking latest
    page.should have_css("a#latest.active")
    sleep 10

 end

 it 'Verify one column layout' do
   within("#gallery") do
    page.find(".outfits.columns-1")
    end

end
end