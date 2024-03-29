module Api
  module V1
    class UsersController < ApiController
      before_action :set_user, only: [:show, :edit, :update, :destroy]

      # GET /users
      # GET /users.json
      # def index
      #   @users = User.all
      #   render status: :ok, json: @users
      # end

      # GET /users/1
      # GET /users/1.json
      def show
        render status: :ok, json: @user
      end

      # GET /users/new
      def new
        @user = User.new
        render status: :ok, json: @user
      end

      # GET /users/1/edit
      def edit
        render status: :ok, json: @user
      end

      # POST /users
      # POST /users.json
      def create
        @user = User.new(user_params)
        if @user.save
          render status: :created, json: @user
        else
          self.send(:new)
        end
      end

      # PATCH/PUT /users/1
      # PATCH/PUT /users/1.json
      def update
        if @user.update(user_params)
          render status: :ok, json: @user
        else
          self.send(:edit)
        end
      end

      # DELETE /users/1
      # DELETE /users/1.json
      def destroy
        @user.destroy
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = Rails.cache.fetch('user_'+params[:id]) do
            @user = User.find(params[:id])
          end
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
          params.require(:user).permit(:name, :email, :birthday, :gender, :avatar, :fb_id, :fb_at, :origin, :provider, :status)
        end
    end
  end
end
