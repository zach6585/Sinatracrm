class ProjectController < ApplicationController
    get '/projects' do
        if logged_in?
          @projects = Join.all
          @worker = current_worker
          erb :'projects/show_projects'
        else 
          redirect to '/login'
        end 
      end 
    
    
      get '/projects/:id/edit' do 
        # binding.pry
        @project = Project.find_by_id(params[:id])
        @join = Join.find_by(:worker_id => current_worker.id, :project_id => params[:id])
        erb :'projects/edit_notes'
      end 
    
      
      patch '/projects/:id/' do 
        # binding.pry
        @project = Project.find_by_id(params[:id])
        if !params[:notes].empty?
    
          @project.notes = params[:notes] 
          @project.save 
          redirect to "/projects"
        else 
          @a = "Cannot accept empty notes"
          erb :'projects/edit_project'
        end 
    
      end 
    
    
      post '/new1' do 
        erb :'projects/new'
      end 

      get '/add/:id' do 
        @project = Project.find_by_id(params[:id])
        @workers = Worker.all 
        erb :'projects/add'
      end 

      post '/add/:id' do 
       
        params.each do |param, value|
          @name = param unless value != on
          @name = Worker.find_by(:name => param)
          @join = Join.create(:worker_id => @name.id, :project_id => params[:id], :leader => 0)
          @join.save
        end 


      end 
    
      post '/new' do 
       
        @project = Project.create(:name => params[:projectname], :notes => params[:notes])
        @join = Join.create(:worker_id => current_worker.id, :project_id => @project.id, :leader => 1)
        redirect to '/projects'
      end 
    
      get '/delete/:id' do
        # binding.pry
        @join = Join.find_by_id(params[:id])
        erb :'projects/delete'
      end 
    
      delete '/projects/:id' do 
        # binding.pry
    
        if params[:choice] == "No, take me back"
          redirect to '/projects'
        else 
          @join = Join.find_by(:worker_id => current_worker.id, :project_id => params[:id])
          @join.delete 
          erb :'projects/deleted'
        end 
      end 
end 