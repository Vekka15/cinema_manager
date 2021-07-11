class JsonWebToken
  class << self
    def encode(payload, expiration_time = 24.hours.from_now)
      payload[:exp] = expiration_time.to_i
      JWT.encode(payload, secret)
    end

    def decode(token)
      JWT.decode(token, secret)[0]
    rescue
      nil
    end

    private

    def secret
      Rails.application.config.jwt.hmac_secret
    end
  end
end
