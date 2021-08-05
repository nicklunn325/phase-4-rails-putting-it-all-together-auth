class RecipesController < ApplicationController
    # rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
    def index
        if session[:user_id]
            recipes = Recipe.all 
            render json: recipes, status: :created
        else
            render json: { errors: ["You must be logged in"] }, status: :unauthorized
        end
    end

    def create
        if session[:user_id]
            recipe = Recipe.create(recipe_params)
            recipe.update!(user_id: session[:user_id])
            # recipe.user_id = session[:user_id]
            # recipe.save
            render json: recipe, status: :created
        else
            render json: { errors: ["You must be logged in"] }, status: :unauthorized
        end
    end

    private

    def record_invalid(e)
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end

end
