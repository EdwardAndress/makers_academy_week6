require 'spec_helper'

feature 'users can add new links' do 

	scenario 'from the homepage' do 
		visit '/'
		add_link("http://bbc.co.uk/football", "BBC Football")
		expect(Link.count).to eq 1
		expect(page).to have_content "BBC Football"
	end

	scenario 'with tags' do 
		visit '/'
		add_link("http://picfair.com", "Picfair", ["photos", "stock photography", "sell photos"])
		expect(Link.count).to eq 1
		expect(Link.first.tags.count).to eq 3
		expect(page).to have_content "Picfair"
		expect(page).to have_content "photos"
	end

	def add_link(url, title, tags = [])
		within('#new-link') do
			fill_in 'url', with: url
			fill_in 'title', with: title
			fill_in 'tags', with: tags.join(',')
			click_button 'Add link'
		end
	end

end