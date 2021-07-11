# frozen_string_literal: true

module ApiHelper
  def parsed_body(*)
    JSON.parse response.body
  end

  def jwt_token_for_user(data)
    JWT.encode(
      { user_id: user.id, exp: 24.hours.from_now.to_i },
      Rails.application.config.jwt_hmac_secret
    )
  end
end
