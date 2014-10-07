require 'spec_helper'

feature 'Users can do different things depending on whether they are logged in or out' do

	scenario 'when logged out they can sign up' do
		visit '/'
		expect(User.count).to eq 0
		sign_up('Eddie', 'eddie_andress@hotmail.com', '12345678')
		expect(User.count).to eq 1
	end

	def sign_up(username, email, password)
		visit '/'
		click_link 'Sign up'
		within('#new-user')
		fill_in 'username', with: username
		fill_in 'email', with: email
		fill_in 'password', with: password
	end

end