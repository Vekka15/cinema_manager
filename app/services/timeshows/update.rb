module Timeshow
  class Update
    include Callable

    def initalize(id:, user:, params:)
      @id = id
      @user = user
      @params = params
    end

    def call
      timeshow.update!(params)
    end

    private

    def timeshow
      @timeshow ||= user.timeshows.find(id)
    end

    attr_reader :id, :user, :params
  end
end
