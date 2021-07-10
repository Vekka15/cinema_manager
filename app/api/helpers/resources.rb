# frozen_string_literal: true

module Helpers
  module Resources
    extend ActiveSupport::Concern

    included do
      def current_user
        @current_user ||= request.env['user']
      end
    end
  end
end
