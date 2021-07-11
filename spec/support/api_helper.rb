# frozen_string_literal: true

module ApiHelper
  %w[get post patch delete].each do |verb|
    define_method "#{verb}_with_token" do |*args, **keywords|
      send(
        verb,
        *args,
        **{ headers: {
          'Authorization' => "Bearer #{jwt_token_for_user(user)}"
        } }.deep_merge(keywords)
      )
    end
  end

  def parsed_body(*)
    JSON.parse response.body
  end

  def jwt_token_for_user(user)
    JWT.encode(
      { user_id: user.id, exp: 24.hours.from_now.to_i },
      Rails.application.config.jwt_hmac_secret
    )
  end
end
