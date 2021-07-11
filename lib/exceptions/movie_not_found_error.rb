class MovieNotFoundError < StandardError
  attr_reader :status

  def initialize(message = 'Movie was not found in Open Movie Database.', status = 404)
    @status = status
    super(message)
  end
end