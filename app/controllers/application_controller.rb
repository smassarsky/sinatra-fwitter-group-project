require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  class Helpers

    def self.current_user(session)
      User.find(session[:user_id])
    end

    def self.is_logged_in?(session)
      !!session[:user_id]
    end

  end

end
