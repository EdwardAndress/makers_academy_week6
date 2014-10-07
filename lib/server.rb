require 'sinatra/base'
require 'data_mapper'

env = ENV["Rack_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link'
require './lib/tag'
require './lib/user'

DataMapper.finalize
DataMapper.auto_upgrade!

class BookmarkManager < Sinatra::Base

  get '/' do
  	@links = Link.all
    erb :homepage
  end

  post '/links' do
  	tags = params["tags"].split(",").map do |tag|
  		Tag.first_or_create(text: tag)
  	end
  	Link.create(url: params[:url], title: params[:title], tags: tags)
  	redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
