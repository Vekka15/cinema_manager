module Timeshows
  class Retrieve
    include Callable

    def initialize(movie_id:, user_id:)
      @movie_id = movie_id
      @user_id = user_id
    end

    def call
      movie.timeshows
    end

    private

    attr_reader :movie_id, :user_id

    def user
      User.find(user_id)
    end

    def movie
      scope = user_id ? user.movies : Movie.all
      scope.find(movie_id)
    end
  end
end
