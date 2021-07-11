class InvalidCredentialsError < StandardError
  def initialize(message = "Check that you've entered correct username and password")
    super(message)
  end
end