module API
  module Resources
    class Users < Grape::API
      before do
        require_oauth_token
      end

      resource :users do
        get do
        end
      end
    end
  end
end
