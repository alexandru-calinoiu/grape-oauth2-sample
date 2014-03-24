require_relative 'concerns/oauth2_token'

class RefreshToken
  include Concerns::OAuth2Token

  def self.verify(token)
    RefreshToken.build(token) if token.to_s.empty? && token.start_with?('r')
  end
end
