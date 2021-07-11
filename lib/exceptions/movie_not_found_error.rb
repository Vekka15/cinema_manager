class MovieNotFoundError < CustomError
  def initialize(message = 'Movie was not found in Open Movie Database.', status = 404)
    super(message, status)
  end
end