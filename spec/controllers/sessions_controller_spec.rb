require 'helper'

describe SessionsController do
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
  end
  describe '#new' do
    it 'redirects to github auth' do
      get :new
      expect(response).to redirect_to('/auth/github')
    end
  end

  describe '#create' do
    it 'authenticates github' do
      get :create, provider: 'github'
      expect(response).to redirect_to('/')
    end
  end

  describe '#unauthenticated' do
    it 'log the error and redirects' do
      in_fail_auth do
        get :create, provider: 'github'
        expect(response).to redirect_to('/')
      end
    end
  end

  describe '#destroy' do
    it 'logouts by warden' do
      delete :destroy
      expect(response).to redirect_to('/')
    end
  end
end
