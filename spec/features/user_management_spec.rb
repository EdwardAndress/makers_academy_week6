require 'spec_helper'

feature 'Users can do different things depending on whether they are logged in or out' do

	scenario 'when logged out they can sign up' do
		visit '/'
		expect(User.count).to eq 0
		sign_up('Eddie', 'eddie_andress@hotmail.com', '12345678')
		expect(User.count).to eq 1
	end

	scenario 'users must confirm their chosen password during the sign up process and the two must match' do 
		visit '/'
		expect{ sign_up('Eddie', 'eddie_andress@hotmail.com', '12345678', '1234') }.to change(User, :count).by 0
	end

	scenario 'the user should be redirected back to the sign up page if they make an input error when confirming the password' do
		sign_up('Eddie', 'eddie_andress@hotmail.com', '12345678', '1234')
		expect(current_path).to eq '/users/new'
	end

	scenario '' do
		sign_up('Eddie', 'eddie_andress@hotmail.com', '12345678', '1234')
		expect(page).to have_content 'Sorry, your password does not match the confirmation'
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

	scenario 'a registered user can sign in' do
		visit '/'
		sign_up
		click_button 'Sign out'
		expect(User.count).to eq 1
		expect(page).to have_css('#sign_in')
		within('#sign_in') do
			fill_in 'email', with: 'eddie_andress@hotmail.com'
			fill_in 'password', with: '12345678'
			click_button 'Sign in'
		end
		expect(page).to have_content 'Hello Eddie'
	end

	def sign_up(username = 'Eddie', email = 'eddie_andress@hotmail.com', password = '12345678', password_confirmation = '12345678')
		visit '/'
		click_link 'Sign up'
		within('#new-user') do
			fill_in 'username', with: username
			fill_in 'email', with: email
			fill_in 'password', with: password
			fill_in 'password_confirmation', with: password_confirmation
			click_button 'Submit'
		end
	end

end