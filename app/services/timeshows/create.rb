module Timeshow
  class Create
    include Callable

    def initalize(user:, params:)
      @user = user
      @params = params
    end

    def call
      user.timeshows.create!(params)
    end

    private

    attr_reader :user, :params
  end
end
