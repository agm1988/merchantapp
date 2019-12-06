class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base. to_s
  EXPIRY_IN_HOURS = 2

  def self.encode(payload, exp = EXPIRY_IN_HOURS.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded)
  end
end
