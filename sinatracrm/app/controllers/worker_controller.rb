class WorkerController < ApplicationController

    get '/' do 
        erb :intro
    end 


    get '/intro' do 
      erb :intro
    end 
    
    post '/start' do 
      # binding.pry 
      if params[:choice] == "Login"
        redirect to '/login'
      elsif params[:choice] == "Sign Up"
        redirect to '/signup'
        
      end 
    end 
  
 
    
    get '/signup' do
      # binding.pry
      erb :'workers/create_worker'
    end 
    
    post '/signup' do 
      worker = Worker.new(:username => params[:username], :email => params[:email], :password => params[:password], :name => params[:name], :company_id => 1, :their_id => nil)
          if worker.save 
            redirect "/login"
          else 
            @a = "Invalid credentials. Please try again."
            erb :'workers/create_worker'
          end 
    end 

    get '/login' do 
      if logged_in?
        redirect to '/projects'
      else 
        erb :'workers/login'
      end 
    end 
     
    post '/login' do 
      worker = Worker.find_by(:username => params[:username])
      worker.company_id = 1 
      worker.save
      # binding.pry
          if worker && worker.authenticate(params[:password])
            session[:worker_id] = worker.id
            redirect to '/projects'
          else 
            @a = "Invalid credentials. Please try again."
            erb :'workers/login'
          end 
    end 
    
    get '/logout' do 
      session.clear 
      redirect to '/'
    end 
    
    
    
  end
  
  