module Api
  module V1
    class LecturesController < ApiController
      before_action :set_lecture, only: [:show]
      before_action :locate_collection, :only => :index

      # GET /lectures
      # GET /lectures.json
      def index
        render status: :ok, json: @lectures
      end

      # GET /lectures/1
      # GET /lectures/1.json
      def show
        render status: :ok, json: @lecture
      end

      # # GET /lectures/new
      # def new
      #   @lecture = Lecture.new
      #   render status: :ok, json: @lecture
      # end

      # # GET /lectures/1/edit
      # def edit
      #   render status: :ok, json: @lecture
      # end

      # # POST /lectures
      # # POST /lectures.json
      # def create
      #   @lecture = Lecture.new(lecture_params)
      #   if @lecture.save
      #     render status: :created, json: @lecture
      #   else
      #     self.send(:new)
      #   end
      # end

      # # PATCH/PUT /lectures/1
      # # PATCH/PUT /lectures/1.json
      # def update
      #   if @lecture.update(lecture_params)
      #     render status: :ok, json: @lecture
      #   else
      #     self.send(:edit)
      #   end
      # end

      # # DELETE /lectures/1
      # # DELETE /lectures/1.json
      # def destroy
      #   @lecture.destroy
      #   head :no_content
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_lecture
          @lecture = Lecture.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def lecture_params
          params.require(:lecture).permit(:course_id, :name, :subtitle, :avatar, :order)
        end

        def locate_collection
          if (params.has_key?("course_id"))
            @lectures = Course.find(params[:course_id]).lectures
          else
            @lectures = Lecture.all
          end
        end


    end
  end
end
