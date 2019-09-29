class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  # Part 1: alter to sort the movies by: Release date in ascending order OR alphabetically
  def index
    @movies = Movie.all
    # if "title" is passed then highlight it and sort Alphabetically 
    if params[:sortMoviesBy] == "title"
      # CSS link to hilite the title 
      @highlightMovie = "hilite"
      @movies = Movie.order('title ASC');
    # if "date" is passed then hihglight it and sort Alphabetically
    elsif params[:sortMoviesBy] == "date"
      # CSS link to hilite the title 
      @highlightDate = "hilite"
      @movies = Movie.order('release_date ASC');
  end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
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
