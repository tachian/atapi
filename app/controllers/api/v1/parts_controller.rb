module Api
  module V1
    class PartsController < ApiController
      # Concerns for token_authenticable
      include TokenAuthentication

      before_action :set_part, only: [:show]
      before_action :locate_collection, :only => :index

      # GET /parts
      # GET /parts.json
      def index
        render status: :ok, json: @parts
      end

      # GET /parts/1
      # GET /parts/1.json
      def show
        render status: :ok, json: @part
      end

      # # GET /parts/new
      # def new
      #   @part = Part.new
      #   render status: :ok, json: @part
      # end

      # # GET /parts/1/edit
      # def edit
      #   render status: :ok, json: @part
      # end

      # # POST /parts
      # # POST /parts.json
      # def create
      #   @part = Part.new(part_params)
      #   if @part.save
      #     render status: :created, json: @part
      #   else
      #     self.send(:new)
      #   end
      # end

      # # PATCH/PUT /parts/1
      # # PATCH/PUT /parts/1.json
      # def update
      #   if @part.update(part_params)
      #     render status: :ok, json: @part
      #   else
      #     self.send(:edit)
      #   end
      # end

      # # DELETE /parts/1
      # # DELETE /parts/1.json
      # def destroy
      #   @part.destroy
      #   head :no_content
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_part
          @part = Part.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def part_params
          params.require(:part).permit(:lecture_id, :name, :teacher, :url, :duration, :order)
        end

        def locate_collection
          if (params.has_key?("lecture_id"))
            @parts = Lecture.find(params[:lecture_id]).parts
          else
            @parts = Parts.all
          end
        end
    end
  end
end
