require 'rails_helper'

RSpec.describe "Subjects", :type => :request do
  describe "GET /subjects" do
    it "works! (now write some real specs)" do
      get subjects_path
      expect(response.status).to be(200)
    end
  end
end
