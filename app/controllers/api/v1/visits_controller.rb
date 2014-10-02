module Api
  module V1
    class VisitsController < ApiController
      before_action :set_visit, only: [:show, :edit, :update, :destroy]
      before_action :locate_collection, :only => :index

      # GET /visits
      # GET /visits.json
      def index
        # @visits = Visit.all
        render status: :ok, json: @visits
      end

      # GET /visits/1
      # GET /visits/1.json
      def show
        render status: :ok, json: @visit
      end

      # GET /visits/new
      def new
        @visit = Visit.new
        render status: :ok, json: @visit
      end

      # GET /visits/1/edit
      def edit
        render status: :ok, json: @visit
      end

      # POST /visits
      # POST /visits.json
      def create
        @visit = Visit.where(user_id: params[:user_id], part_id: params[:part_id])
        if @visit.blank?
          @visit = Visit.new
          @visit.user_id = params[:user_id]
          @visit.course_id = params[:course_id]
          @visit.lecture_id = params[:lecture_id]
          @visit.part_id = params[:part_id]
          @visit.time = params[:time]
          if @visit.save
            Rails.cache.delete('part_' + params[:part_id].to_s + '_user_' + params[:user_id].to_s + '_visit')
            render status: :created, json: @visit
          else
            self.send(:new)
          end
        else
          render status: :created, json: @visit
        end
      end

      # PATCH/PUT /visits/1
      # PATCH/PUT /visits/1.json
      def update
        if @visit.update(params)
          render status: :ok, json: @visit
        else
          self.send(:edit)
        end
      end

      # DELETE /visits/1
      # DELETE /visits/1.json
      def destroy
        @visit.destroy
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_visit
          @visit = Visit.find(params[:id])
        end
        
        # Never trust parameters from the scary internet, only allow the white list through.
        def visit_params
          params.require(:visit).permit(:user_id, :course_id, :lecture_id, :part_id, :time, :status)
        end

        def locate_collection
          if (params.has_key?("user_id"))  
            @visits = User.find(params[:user_id]).visits
          else
            @visits = Visit.all
          end
        end
    end
  end
end
