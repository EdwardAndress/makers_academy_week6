require 'spec_helper'


feature 'A user can browse links' do
	
before(:each) do
	sign_up
	add_link("http://picfair.com", "Picfair", ["photos", "stock photography", "sell photos"])
	add_link("http://google.co.uk", "Google", ["search engine", "personal data", "world rulers"])
end

	scenario "when they land on the homepage" do
		visit '/'
		expect(page).to have_content('Picfair')
	end

	scenario 'and filter them by their tags' do 
		visit '/'
		within('#filter') do
			fill_in 'filter', with: 'photos'
			click_button 'Submit'
		end
		expect(page).to have_content 'Picfair'
		expect(page).not_to have_content 'Google'
	end

end