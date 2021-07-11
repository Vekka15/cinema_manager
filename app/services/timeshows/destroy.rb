module Timeshow
  class Update
    include Callable

    def initalize(id:, user:)
      @id = id
      @user = user
    end

    def call
      timeshow.destroy!
    end

    private

    def timeshow
      @timeshow ||= user.timeshows.find(id)
    end

    attr_reader :id, :user, :params
  end
end
