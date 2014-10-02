module Api
  module V1
    class UniversitiesController < ApiController
      before_action :set_university, only: [:show]

      # GET /universities
      # GET /universities.json
      def index
        @universities = University.all
        render status: :ok, json: @universities
      end

      # GET /universities/1
      # GET /universities/1.json
      def show
        render status: :ok, json: @university
      end

      # # GET /universities/new
      # def new
      #   @university = University.new
      #   render status: :ok, json: @university
      # end

      # # GET /universities/1/edit
      # def edit
      #   render status: :ok, json: @university
      # end

      # # POST /universities
      # # POST /universities.json
      # def create
      #   @university = University.new(university_params)
      #   if @university.save
      #     render status: :created, json: @university
      #   else
      #     self.send(:new)
      #   end
      # end

      # # PATCH/PUT /universities/1
      # # PATCH/PUT /universities/1.json
      # def update
      #   if @university.update(university_params)
      #     render status: :ok, json: @university
      #   else
      #     self.send(:edit)
      #   end
      # end

      # # DELETE /universities/1
      # # DELETE /universities/1.json
      # def destroy
      #   @university.destroy
      #   head :no_content
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_university
          @university = Rails.cache.fetch('university_'+params[:id]) do
            @university = University.find(params[:id])
          end
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def university_params
          params.require(:university).permit(:name, :fullname, :description, :status)
        end
    end
  end
end
