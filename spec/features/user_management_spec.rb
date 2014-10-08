require 'spec_helper'

feature 'Users can do different things depending on whether they are logged in or out' do

	scenario 'when logged out they can sign up' do
		visit '/'
		expect(User.count).to eq 0
		sign_up('Eddie', 'eddie_andress@hotmail.com', '12345678')
		expect(User.count).to eq 1
	end

	scenario 'as part of the sign up process the user is automatically logged in and sees a relevant greeting on their homepage' do 
		visit '/'
		sign_up('Eddie', 'eddie_andress@hotmail.com', '12345678')
		expect(page).to have_content 'Hello Eddie'
	end

	scenario 'when logged in the user should not see a link to sign up' do
		visit '/'
		sign_up('Eddie', 'eddie_andress@hotmail.com', '12345678')
		expect(page).not_to have_content 'Sign up'
	end

	scenario 'a logged in user can see a link to sign out' do
		visit '/'
		sign_up('Eddie', 'eddie_andress@hotmail.com', '12345678')
		expect(page).to have_content('Hello Eddie')
		expect(page).to have_css('#sign_out')
	end

	scenario 'a logged in user can sign out' do 
		visit '/'
		sign_up('Eddie', 'eddie_andress@hotmail.com', '12345678')
		expect(page).to have_css('#sign_out')
		click_button 'Sign out'
		expect(page).to have_content 'Sign up'
	end

	def sign_up(username, email, password)
		visit '/'
		click_link 'Sign up'
		within('#new-user') do
			fill_in 'username', with: username
			fill_in 'email', with: email
			fill_in 'password', with: password
			click_button 'Submit'
		end
	end

end