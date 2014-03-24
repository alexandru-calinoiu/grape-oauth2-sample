module Concerns
  module OAuth2Token
    extend ActiveSupport::Concern

    included do
      attr_accessor :token
      attr_accessor :expires_in
    end

    module ClassMethods
      def build(token = nil, bytes = 64)
        builded_token = new
        builded_token.token = token || SecureRandom.base64(bytes)
        builded_token.expires_in = 15.minutes
        builded_token
      end
    end
  end
end
