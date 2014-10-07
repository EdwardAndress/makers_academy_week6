require 'spec_helper'


feature 'A user can browse links' do
	
before(:each) {Link.create(title: 'Google', url: 'http://google.co.uk')}

	scenario "when they land on the homepage" do
		visit '/'
		expect(page).to have_content('Google')
	end

end