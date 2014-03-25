require 'spec_helper'

describe API::Resources::OAuth2 do
  include Rack::Test::Methods

  def app
    API::Root
  end

  let(:client_id) { '42' }

  let(:params) { Hash[:grant_type, grant_type, :client_id, '42'] }

  shared_examples_for 'oauth2 grant type' do
    subject { last_response }

    context 'and it has a valid params' do
      before :each do
        post '/api/v1/oauth2/token', valid_params
      end

      its(:status) { should == 200 }

      its(:body) { should include('access_token') }
    end

    context 'and it has an invalid params' do
      before :each do
        post '/api/v1/oauth2/token', invalid_params
      end

      its(:status) { should == 400 }

      its(:body) { should have_json_path('error') }

      its(:body) { should have_json_path('error_description') }
    end
  end

  shared_examples_for 'contains refresh_token' do
    subject { last_response }

    context 'and it has a valid params' do
      before :each do
        post '/api/v1/oauth2/token', valid_params
      end

      its(:body) { should have_json_path('refresh_token') }
    end
  end

  context 'when grant type is authorization_code' do
    let(:grant_type) { :authorization_code }
    let(:valid_params) { params.merge(code: '43') }

    it_behaves_like 'oauth2 grant type' do
      let(:invalid_params) { params.merge(code: '44') }
    end

    it_behaves_like 'contains refresh_token'
  end

  context 'when grant type is refresh_token' do
    let(:grant_type) { :refresh_token }

    it_behaves_like 'oauth2 grant type' do
      let(:valid_params) { params.merge(refresh_token: 'r123') }
      let(:invalid_params) { params.merge(refresh_token: 'i123') }
    end
  end

  context 'when grant type is client_credentials' do
    let(:grant_type) { :client_credentials }
    let(:valid_params) { params.merge(client_secret: 'secret') }

    it_behaves_like 'oauth2 grant type' do
      let(:invalid_params) { params.merge(client_secret: 'not secret') }
    end

    it_behaves_like 'contains refresh_token'
  end

  context 'when grant type is invalid' do
    let(:grant_type) { :invalid }

    before :each do
      post '/api/v1/oauth2/token', params
    end

    subject { last_response }

    its(:status) { should == 400 }

    its(:body) { should have_json_path('error') }
  end
end
