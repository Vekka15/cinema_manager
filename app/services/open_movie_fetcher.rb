class OpenMovieFetcher
  include Callable

  URL = Rails.configuration.open_movie.url
  API_KEY = Rails.configuration.open_movie.api_key

  def initialize(movie:)
    @movie = movie
  end

  def call
    return response_body if response_body['Response'] == 'True'

    raise ::MovieNotFoundError.new
  end

  private

  attr_reader :movie

  def response_body
    @response_body ||= JSON.parse(connection.get { |req| req.params = params }.body)
  end

  def connection
    ::Faraday.new(url: URL) do |faraday|
      faraday.request :url_encoded
      faraday.adapter ::Faraday.default_adapter
    end
  end

  def params
    {
      'apikey' => API_KEY,
      'i' => movie.imdb_id
    }
  end
end