class Api::V1::RecipeTypesController < Api::V1::ApiController
    def create
    @recipe_type = RecipeType.new(recipe_types_params)
    if @recipe_type.save
        render json: @recipe_type, status: :created
    else 
        render json: {message: "Falha ao registrar uma receita"}, status: :precondition_failed
    end
  
    
private
    def recipe_types_params
        params.require(:recipe_type).permit(:name)
    end 
end