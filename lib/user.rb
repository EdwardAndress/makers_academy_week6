require 'bcrypt'

class User

	include DataMapper::Resource

	property :id, Serial
	property :username, String
	property :email, String
	property :password_digest, Text

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password

	has n, :links, through: Resource

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(email: email)
		if user && BCrypt::Password.new(user.password_digest) == password
			return user
		else
			nil
		end
	end

end