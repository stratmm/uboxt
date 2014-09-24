require 'rails_helper'

describe Api::GithubUsersController, :type => :controller do
  let(:user_name ) { 'stratmm'}

  context 'GET show' do
    it "returns the lasnguage hash" do
      get :show, id: user_name, format: :json
      expect(JSON.parse(response.body).keys).to include "Ruby"
    end

    it "returns status 200" do
      get :show, id: user_name, format: :json
      expect(response.status).to eql 200
    end
  end

end
