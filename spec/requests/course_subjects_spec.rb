require 'rails_helper'

RSpec.describe "CourseSubjects", :type => :request do
  describe "GET /course_subjects" do
    it "works! (now write some real specs)" do
      get course_subjects_path
      expect(response.status).to be(200)
    end
  end
end
