class CustomError < StandardError
  attr_reader :status

  def initialize(message = '', status = 400)
    @status = status
    super(message)
  end
end