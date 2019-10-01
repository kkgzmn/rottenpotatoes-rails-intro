class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
  
  def index
    @movies = Movie.all
  # Part 1: alter to sort the movies by: Release date in ascending order OR alphabetically
  # if "title" is passed then highlight it and sort Alphabetically
    session[:sortMoviesBy] = params[:sortMoviesBy]
    if session[:sortMoviesBy] == "title"
      @highlightMovie = "hilite"  # CSS link to hilite the title 
      @movies = Movie.order('title ASC');
  # if "date" is passed then hihglight it and sort Alphabetically
    elsif session[:sortMoviesBy] == "date"
      @highlightDate = "hilite"
      @movies = Movie.order('release_date ASC');
    end
    
  # Part 2: Movie Ratings Checkbox Filter
    @all_ratings = Movie.all_ratings()
    unless params[:ratings].nil?
      @ratings_keys = params[:ratings].keys
      session[:ratings_keys] = @ratings_keys
    end
  # Filter out the movies
    if session[:ratings_keys]
       @movies = @movies.select{ |movie| session[:ratings_keys].include? movie.rating }
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
