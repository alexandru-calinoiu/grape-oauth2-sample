require 'spec_helper'

describe API::Resources::OAuth2 do
  include Rack::Test::Methods

  def app
    API::Root
  end

  let(:client_id) { '42' }

  let(:params) { {grant_type: grant_type, client_id: '42'} }

  shared_examples_for 'oauth2 grant type' do
    subject { last_response }

    context 'and it has a valid authorization code' do
      before :each do
        post '/api/v1/oauth2/token', valid_params
      end

      its(:status) { should == 200 }

      its(:body) { should include('access_token') }

      its(:body) { should include('refresh_token') }
    end

    context 'and it has an invalid authorization code' do
      before :each do
        post '/api/v1/oauth2/token', invalid_params
      end

      its(:status) { should == 400 }

      its(:body) { should have_json_path("error") }

      its(:body) { should have_json_path("error_description") }
    end
  end

  context 'when grant type is authorization_code' do
    let(:grant_type) { :authorization_code }

    it_behaves_like 'oauth2 grant type' do
      let(:valid_params) { params.merge(code: '43') }
      let(:invalid_params) { params.merge(code: '44') }
    end
  end
end
