require 'spec_helper'


feature 'A user can browse links' do
	
before(:each) do
	Link.create(title: 'Google', url: 'http://google.co.uk', tags: [Tag.first_or_create(text: 'search')])
	Link.create(title: 'BBC Football', url: 'http://bbc.co.uk/football', tags: [Tag.first_or_create(text: 'BBC')])
end

	scenario "when they land on the homepage" do
		visit '/'
		expect(page).to have_content('Google')
	end

	scenario 'and filter them by their tags' do 
		visit '/'
		within('#filter') do
			fill_in 'filter', with: 'search'
			click_button 'Submit'
		end
		expect(page).to have_content 'Google'
		expect(page).not_to have_content 'BBC'
	end

end