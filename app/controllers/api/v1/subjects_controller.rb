module Api
  module V1
    class SubjectsController < ApiController
      before_action :set_subject, only: [:show]

      # GET /subjects
      # GET /subjects.json
      def index
        @subjects = Subject.all
        render status: :ok, json: @subjects
      end

      # GET /subjects/1
      # GET /subjects/1.json
      def show
        render status: :ok, json: @subject
      end

      # # GET /subjects/new
      # def new
      #   @subject = Subject.new
      #   render status: :ok, json: @subject
      # end

      # # GET /subjects/1/edit
      # def edit
      #   render status: :ok, json: @subject
      # end

      # # POST /subjects
      # # POST /subjects.json
      # def create
      #   @subject = Subject.new(subject_params)
      #   if @subject.save
      #     render status: :created, json: @subject
      #   else
      #     self.send(:new)
      #   end
      # end

      # # PATCH/PUT /subjects/1
      # # PATCH/PUT /subjects/1.json
      # def update
      #   if @subject.update(subject_params)
      #     render status: :ok, json: @subject
      #   else
      #     self.send(:edit)
      #   end
      # end

      # # DELETE /subjects/1
      # # DELETE /subjects/1.json
      # def destroy
      #   @subject.destroy
      #   head :no_content
      # end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_subject
          @subject = Subject.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def subject_params
          params.require(:subject).permit(:name, :description)
        end
    end
  end
end
