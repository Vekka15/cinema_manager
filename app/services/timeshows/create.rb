module Timeshows
  class Create
    include Callable

    def initialize(user:, params:)
      @user = user
      @params = params
    end

    def call
      user.timeshows.create!(params[:timeshow])
    end

    attr_reader :user, :params
  end
end
