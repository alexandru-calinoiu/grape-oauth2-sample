class Client
  attr_reader :id, :secret

  def self.verify(client_id)
    Client.new(client_id) if client_id == '42'
  end

  def initialize(client_id)
    @id = client_id
    @secret = 'secret'
  end
end
