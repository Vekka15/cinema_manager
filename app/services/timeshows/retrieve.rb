module Timeshows
  class Retrieve
    include Callable

    def initialize(movie:)
      @movie = movie
    end

    def call
      movie.timeshows
    end

    private

    attr_reader :movie
  end
end
