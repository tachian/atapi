module Api
  module V1
    class CoursesController < ApiController

      before_action :set_course, only: [:show]
      before_action :locate_collection, :only => :index


      # GET /courses
      # GET /courses.json
      def index
        render status: :ok, json: @courses
      end

      # GET /courses/1
      # GET /courses/1.json
      def show
        render status: :ok, json: @course
      end

      # GET /courses/new
      # def new
      #   @course = Course.new
      #   render status: :ok, json: @course
      # end

      # # GET /courses/1/edit
      # def edit
      #   render status: :ok, json: @course
      # end

      # # POST /courses
      # # POST /courses.json
      # def create
      #   @course = Course.new(course_params)
      #   if @course.save
      #     render status: :created, json: @course
      #   else
      #     self.send(:new)
      #   end
      # end

      # # PATCH/PUT /courses/1
      # # PATCH/PUT /courses/1.json
      # def update
      #   if @course.update(course_params)
      #     render status: :ok, json: @course
      #   else
      #     self.send(:edit)
      #   end
      # end

      # # DELETE /courses/1
      # # DELETE /courses/1.json
      # def destroy
      #   @course.destroy
      #   head :no_content
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_course
          @course = Course.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def course_params
          params.require(:course).permit(:university_id, :avatar, :name, :description, :status)
        end

        def locate_collection
          if (params.has_key?("university_id"))  
            @courses = University.find(params[:university_id]).courses

          elsif (params.has_key?("id"))
            @courses = Subject.find(params[:id]).courses

          else
            @courses = Course.all
          end
        end

    end
  end
end
