require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'


env = ENV["Rack_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")

require './lib/link'
require './lib/tag'
require './lib/user'

DataMapper.finalize
DataMapper.auto_upgrade!

class BookmarkManager < Sinatra::Base

use Rack::Flash #must make this declaration in order to use flash notices
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

  get '/tags/:text' do
    tag = Tag.first(text: params[:filter])
    @links = tag ? tag.links : [] # if the tag exists, list of links associated with that tag, otherwise an empty array
    erb :homepage #this time render the page rather than redirect otherwise the @links assignment is remade
  end

  get '/users/new' do
    @user = User.new
  	erb :new_user
  end

  post '/users/new' do
  	@user = User.new( username:	params[:username],
  						                  email: 		params[:email],
  						                  password: params[:password],
                                password_confirmation: params[:password_confirmation])
    if @user.save #the user will only be saved if the validations in place all pass
      session[:current_user_id] = @user.id
    	redirect '/'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :new_user
    end
  end

  post "/sessions/new" do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:current_user_id] = user.id
      redirect '/'
    end
  end

  post '/sessions/delete' do
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
