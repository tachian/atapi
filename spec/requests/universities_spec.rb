require 'rails_helper'

RSpec.describe "Universities", :type => :request do
  describe "GET /universities" do
    it "works! (now write some real specs)" do
      get universities_path
      expect(response.status).to be(200)
    end
  end
end
