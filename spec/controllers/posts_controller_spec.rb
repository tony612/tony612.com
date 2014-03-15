require 'helper'

describe PostsController do
  before(:each) do
    5.times.each do |i|
      create(:post)
    end
  end

  describe "GET index" do
    it "returns posts ordered by time" do
      get :index
      posts = assigns(:posts)
      expect(posts.size).to be(5)
      expect(posts.first.id).to be > posts.last.id
    end
  end

  describe "authenticate_admin" do
    it "before new, create, edit, update, destroy" do
      expect(controller).to receive(:authenticate_admin!).exactly(5).times
      get :new
      post :create, post: {title: ""}
      get :edit, id: "1"
      put :update, id: "1", post: {title: ""}
      delete :destroy, id: "1"
    end

    it "redirect to login page" do
      expect(controller).to receive(:admin_signed_in?).and_return(false)
      get :new
      expect(response).to redirect_to("/login")
    end
  end

  describe "user_signed_in?" do
    it "calls warden.authenticated?" do
      expect(controller).to receive(:warden).and_return(double(authenticated?: false))
      get :new
    end
  end

  describe "admin_signed_in?" do
    it "returns true only when user signed in and is admin" do
      expect(controller).to receive(:user_signed_in?).and_return(true)
      expect(controller).to receive(:warden).and_return(double(user: {}))
      expect(User).to receive(:find_from_user_info).and_return(true)
      expect(controller.admin_signed_in?).to be true
    end
  end
end
