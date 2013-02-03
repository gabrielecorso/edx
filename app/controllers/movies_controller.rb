class MoviesController < ApplicationController
  # hash de filtro
  # attr_accessor :param_filter

  def show
    id = params[:id] # retrieve movie ID from URI route
    if params[:ratings] != nil then  
      params[:ratings].each do |pr|
          session[:ratings].store(pr[0],pr[1])
      end
    end
    session[:message] = "show"
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  # parametros: array
  # params: hash
  # param_filter: hash
  # allratingvalues = array

  

  def index
    #### first call: /movies ####
    #if params[:id] == nil and params[:ratings] == nil and session == nil
    #   parametros = Movie.allratingvalues
    #   sortorder = "rating"
    #end
    #### from show ####
    if (params[:id] == nil) and (params[:ratings] == nil) and ((session[:ratings] != nil) or (session[:order] != nil))then
        session[:message] = "from show"
        if session[:ratings] != nil then
           parametros = session[:ratings].each_key
        end
        if session[:order] != nil then
           sortorder = session[:order]
        end
    end
    ###### call  from sort: choose stored ratings otherwise 
    if (params[:ratings] != nil)
       parametros = params[:ratings].each_key
    end
    #### copy params ratings to session
    if params[:ratings] != nil then
      session.delete(:ratings)
      session[:ratings] = {}
      params[:ratings].each do |pr|
        session[:ratings].store(pr[0],pr[1])
      end
    end
    if params[:id] != nil
       sortorder = params[:id]
       session[:order] = sortorder
    end
    if (params[:id] == nil) and (params[:ratings] == nil)
       sortorder = session[:order]
    end
    if parametros == nil
       parametros = Movie.allratingvalues.each
    end
    if sortorder == nil
       if (session[:order] != nil)
         sortorder = session[:order]
       else
         sortorder = "rating"
       end
    end
    session[:order] = sortorder
    #@movies = Movie.find(:all,:conditions => ["rating IN (?)", parametros],:order => "#{params[:id]}")
    @movies = Movie.find(:all,:conditions => ["rating IN (?)", parametros],:order => sortorder)
  end

  def link_extension(movie,parametros)
    #ratings[G]=1&
    string_parametros = ""
    if parametros == nil then
       string_parametros = ""
    else
       #string_parametros = print parametros 
       # parametros es un hash
       parametros.each_key  do |p|
         string_parametros =  string_parametros + "&" + "ratings[" + p + "]=1"
       end
    end
    session[:message] = string_parametros
    #redirect_to movie_path(@movie + string_parametros)
    redirect_to movie_path(movie)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
