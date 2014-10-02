require "rails_helper"

RSpec.describe CourseSubjectsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/course_subjects").to route_to("course_subjects#index")
    end

    it "routes to #new" do
      expect(:get => "/course_subjects/new").to route_to("course_subjects#new")
    end

    it "routes to #show" do
      expect(:get => "/course_subjects/1").to route_to("course_subjects#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/course_subjects/1/edit").to route_to("course_subjects#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/course_subjects").to route_to("course_subjects#create")
    end

    it "routes to #update" do
      expect(:put => "/course_subjects/1").to route_to("course_subjects#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/course_subjects/1").to route_to("course_subjects#destroy", :id => "1")
    end

  end
end
