class ApplicationController < ActionController::API
  include ActionController::Cookies

  before_action :authorize
  
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

    def authorize
       if !session[:user_id]
        render json: { errors: ["You must be logged in"] }, status: :unauthorized
       end
    end

    def record_invalid(e)
       render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
end
