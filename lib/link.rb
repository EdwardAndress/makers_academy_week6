class Link

	include DataMapper::Resource

	property :id, Serial
	property :title, String
	property :url, String
	property :user_id, Serial

	has n, :tags, through: Resource
	has 1, :user, through: Resource
	
end