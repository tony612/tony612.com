require 'helper'

describe SessionsController do
  describe '#new' do
    it 'redirects to github auth' do
      get :new
      expect(response).to redirect_to('/auth/github')
    end
  end

  describe '#create' do
    it 'authenticates github' do
      warden = double(authenticate!: {})
      expect(controller).to receive(:warden).and_return(warden)
      expect(warden).to receive(:authenticate!).with(:github)
      get :create, provider: 'github'
      expect(response).to redirect_to('/')
    end
  end

  describe '#unauthenticated' do
    it 'log the error and redirects' do
      get :unauthenticated
      expect(response).to redirect_to('/')
    end
  end

  describe '#destroy' do
    it 'logouts by warden' do
      warden = double(logout: {})
      expect(controller).to receive(:warden).and_return(warden)
      expect(warden).to receive(:logout)
      delete :destroy
      expect(response).to redirect_to('/')
    end
  end
end
