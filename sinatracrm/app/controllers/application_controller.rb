require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "password_security"
  end
  
  helpers do
		def logged_in?
			!!session[:worker_id]
		end

		def current_worker
			Worker.find(session[:worker_id])
		end
	end

end