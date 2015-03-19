require 'rails_helper'

RSpec.describe SearchPreferencesController, :type => :controller do
  describe '#new' do
    it "responds with success" do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe '#create' do
    it "responds with success" do
      post :create, {search_preference: {breeds: []}}
      expect(response.status).to eq(302)
    end
  end

  describe '#edit' do
    it "responds with success" do
      get :new
      expect(response.status).to eq(200)
    end
  end
end
