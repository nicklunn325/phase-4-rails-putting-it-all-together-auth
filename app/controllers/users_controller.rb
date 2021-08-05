class UsersController < ApplicationController
    # rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    skip_before_action :authorize
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    def show
        user = User.find(session[:user_id])   
        render json: user, status: :created
    end

    private

    # def record_invalid(e)
    #    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    # end

    def record_not_found
        render json: { error: "Not authorized" }, status: :unauthorized
    end

    def user_params
        params.permit(:username,:image_url, :bio, :password, :password_confirmation)
    end
end
