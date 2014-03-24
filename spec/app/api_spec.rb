require 'spec_helper'

describe Sample::API do
  include Rack::Test::Methods

  def app
    Sample::API
  end

  describe 'GET /api/v1/version' do
    before do
      get '/api/v1/version'
    end

    it 'responds with some version' do
      expect(last_response.body).to eq({ version: '1.0.0' }.to_json)
    end
  end
end
