class Api::V1::RecipesController < Api::V1::ApiController
    def show
        @recipe = Recipe.find(params[:id])
        render json: @recipe, status: :ok
    

    rescue ActiveRecord::RecordNotFound
        render json: {message: 'Receita não encontrada'}, status: :not_found
    end

    def create
        @recipe = Recipe.new(params_recipe)
        @recipe.user = current_user
        if @recipe.save
            render json: @recipe, status: :created
        else
            render json: { message: "Falha ao registrar uma receita"}, status: :precondition_failed
        end
    end

private
    def params_recipe
        params.require(:recipe).permit(:title, :image_recipe, :recipe_type_id, :cuisine_id, :cook_time, :difficulty, :ingredients, :cook_method)
    end

end
