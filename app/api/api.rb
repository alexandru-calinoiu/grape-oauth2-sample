module Sample
  class API < Grape::API
    version 'v1', :using => :path, vendor: 'sample', cascade: false
    prefix 'api'
    format :json

    desc 'Gets the latest version.'
    get :version do
      {version: '1.0.0'}
    end

    add_swagger_documentation(
          api_version: 'v1',
          mount_path: 'doc',
          hide_documentation_path: true,
          markdown: true
      )
  end
end
