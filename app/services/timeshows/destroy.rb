module Timeshows
  class Destroy
    include Callable

    def initialize(id:, user:)
      @id = id
      @user = user
    end

    def call
      timeshow.destroy
    end

    private

    def timeshow
      user.timeshows.find(id)
    end

    attr_reader :id, :user, :params
  end
end
