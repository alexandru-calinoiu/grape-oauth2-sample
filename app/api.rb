module Sample
  class API < Grape::API
    version 'v1'
    prefix 'api'
    format :json

    get :version do
      {version: '1.0.0'}
    end
  end
end
