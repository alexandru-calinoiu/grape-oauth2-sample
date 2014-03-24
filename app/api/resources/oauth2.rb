module API
  module Resources
    class OAuth2 < Grape::API
      helpers do
        def authorization_response(env)
          GenerateOauthToken.for(env)
        end
      end

      params do
        requires  :grant_type,
                  type: Symbol,
                  values: [:authorization_code, :refresh_token],
                  desc: 'The grant type.'
        optional  :code,
                  type: String,
                  desc: 'The authorization code.'
        requires  :client_id,
                  type: String,
                  desc: 'The client id.'
        optional  :client_secret,
                  type: String,
                  desc: 'The client secret.'
        optional  :refresh_token,
                  type: String,
                  desc: 'The refresh_token.'
      end
      post :token do
        response = authorization_response(env)

        # status
        status response[0]

        # headers
        response[1].each do |key, value|
          header key, value
        end

        # body
        body JSON.parse(response[2].body.first)
      end
    end
  end
end
