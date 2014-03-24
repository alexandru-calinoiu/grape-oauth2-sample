require_relative 'concerns/oauth2_token'

class AccessToken
  include Concerns::OAuth2Token

  def self.verify(token)
    AccessToken.build(token) if (token || '').start_with?('g', 'e')
  end

  def to_bearer_token(with_refresh_token = false)
    bearer_token = Rack::OAuth2::AccessToken::Bearer.new(
      access_token: @token,
      expires_in: @expires_in
    )

    bearer_token.refresh_token = RefreshToken.build.token if with_refresh_token

    bearer_token
  end
end
