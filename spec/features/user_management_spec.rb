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