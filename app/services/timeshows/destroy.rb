module Timeshows
  class Destroy
    include Callable

    def initialize(id:, user:)
      @id = id
      @user = user
    end

    def call
      timeshow.delete
    end

    private

    def timeshow
      @timeshow ||= user.timeshows.find(id)
    end

    attr_reader :id, :user, :params
  end
end
