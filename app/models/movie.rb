class Movie < ActiveRecord::Base
    #Part 2: Addings Movie Ratings 
    @@all_ratings = ['G', 'PG', 'PG-13', 'R']
    
    def self.all_ratings
        #return the enumerable list
        @@all_ratings
    end
end
