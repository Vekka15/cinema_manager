class InvalidCredentialsError < CustomError
  def initialize(message = "Check that you've entered correct username and password", status = 400)
    super(message, status)
  end
end