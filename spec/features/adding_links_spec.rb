require 'spec_helper'

feature 'users can add new links' do 

	scenario 'from the homepage' do 
		visit '/'
		add_link("http://bbc.co.uk/football", "BBC Football")
		expect(Link.count).to eq 1
		expect(page).to have_content "BBC Football"
	end

	def add_link(url, title)
		within('#new-link') do
			fill_in 'url', with: 'http://bbc.co.uk/football'
			fill_in 'title', with: 'BBC Football'
			click_button 'Add link'
		end
	end

end