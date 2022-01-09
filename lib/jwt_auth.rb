module Lib
  class JwtAuth
    def self.issue_token(user, expiry_in_hours = 60.hours)
      exp = Time.now.to_i + (expiry_in_hours)
      iss = issuer
      id = user.id

      payload = {
        iss: iss,
        exp: exp,
        id: id,
      }

      JWT.encode(payload, secret_key, 'HS256')
    end

    def self.validate_token(token)
      unless token.present?
        return nil
      end

      begin
        token.gsub!('Bearer ','')
        decoded_token = JWT.decode(
          token,
          secret_key,
          true,
          { verify_iss: true, iss: issuer, algorithm: 'HS256' }
        )

        return decoded_token
      rescue JWT::DecodeError
        Rails.logger.warn "Error decoding the JWT: "+ e.to_s
      end
      
      nil
    end

    private

    def secret_key
      Rails.application.secrets[:secret_key_base]
    end

    def issuer
      "web-black-lily"
    end
  end
end