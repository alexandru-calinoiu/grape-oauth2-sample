require 'api/root'
require 'rack/oauth2'

module Sample
  class App
    def initialize
      @filenames = ['', '.html']
      @rack_static = ::Rack::Static.new(
        -> { [404, {}, []] },
        root: File.expand_path('../../public', __FILE__),
        urls: %w(/)
        )
    end

    # rubocop:disable MethodLength
    def self.instance
      @instance ||= Rack::Builder.new do
        use Rack::Cors do
          allow do
            origins '*'
            resource '*', headers: :any, methods: :get
          end
        end

        use Rack::Static, urls: ['/apidoc'], root: 'public'
        use Rack::OAuth2::Server::Resource::Bearer, 'Sample API' do |req|
          AccessToken.verify(req.access_token) || req.invalid_token!
        end

        run Sample::App.new
      end.to_app
    end

    def call(env)
      # api
      response = API::Root.call(env)

      # Serve error pages or respond with API response
      case response[0]
      when 404, 500
        error_page = "/errors/#{response[0]}.html"
        content = @rack_static.call(env.merge('PATH_INFO' => error_page))
        [response[0], content[1], content[2]]
      else
        response
      end
    end
  end
end
