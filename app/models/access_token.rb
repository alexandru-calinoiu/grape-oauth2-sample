class AccessToken
  attr_accessor :token

  def self.verify(token)
    AccessToken.new(token) if (token || '').start_with?('g', 'e')
  end

  def initialize(token)
    @token = token
  end
end
