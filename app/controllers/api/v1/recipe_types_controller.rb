class Api::V1::RecipeTypesController < Api::V1::ApiController
    def create
    @recipe_type = RecipeType.new(recipe_types_params)
    @recipe_type.save
    render json: @recipe_type, status: :created

    end
  
    
private
    def recipe_types_params
        params.require(:recipe_type).permit(:name)
    end 
end