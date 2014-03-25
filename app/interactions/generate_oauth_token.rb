class GenerateOauthToken
  def self.for(env)
    GenerateOauthToken.new.execute(env)
  end

  # rubocop:disable MethodLength
  def execute(env)
    Rack::OAuth2::Server::Token.new do |req, res|
      client = Client.verify(req.client_id)
      req.invalid_client! unless client

      case req.grant_type
      when :authorization_code
        req.invalid_grant! unless AuthorizationCode.verify(req.code)
        res.access_token = AccessToken.build.to_bearer_token(true)
      when :refresh_token
        req.invalid_grant! unless RefreshToken.verify(req.refresh_token)
        res.access_token = AccessToken.build.to_bearer_token
      when :client_credentials
        req.invalid_grant! unless client.secret == req.client_secret
        res.access_token = AccessToken.build.to_bearer_token(true)
      else
        req.unsupported_grant_type!
      end
    end.call(env)
  end
end
