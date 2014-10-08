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

enable :sessions
set :session_secret, 'super secret'

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

  get '/users/new' do
  	erb :new_user
  end

  post '/users/new' do
  	user = User.create( username:	params[:username],
  						                  email: 		params[:email],
  						                  password: params[:password])
    session[:current_user_id] = user.id
  	redirect '/'
  end

  post '/current_user/sign_out' do
    session[:current_user_id] =  nil
    redirect '/'
  end

  helpers do

    def current_user
      @current_user ||= User.get(session[:current_user_id]) if session[:current_user_id]
    end

  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end
