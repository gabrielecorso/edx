class MoviesController < ApplicationController
  # hash de filtro
  # attr_accessor :param_filter

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  # parametros: array
  # params: hash
  # param_filter: hash
  # allratingvalues = array


  def index
    #### first call: /movies ####
    if params[:id] == nil and params[:ratings] == nil
	params[:id] = "rating"
        #self.param_filter = {}
        #Movie.allratingvalues.each do |arv|
        #  self.param_filter.store(arv,1)   
        #end
        parametros = Movie.allratingvalues
    end
    #### no sort chosen ######
    if params[:id] == nil
	params[:id] = "rating"
    end
    ###### call from sort: choose stored ratings otherwise 
    if params[:ratings] == nil
       #parametros = Movie.allratingvalues
       parametros = Movie.allratingvalues.each
    else
    parametros = params[:ratings].each_key
       #self.param_filter = params[:ratings]
    end
    @movies = Movie.find(:all,:conditions => ["rating IN (?)", parametros],:order => "#{params[:id]}")
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
