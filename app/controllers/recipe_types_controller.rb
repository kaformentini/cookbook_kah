class RecipeTypesController < ApplicationController
    def show
        @recipe_type = RecipeTypes.find(params[:id])
    end

    def new
        @recipe_type = RecipeTypes.new
    end

    def create
   

    end


private

    def params_recipe_type
        params.require(:recipe_tipe).permit(:name)
    end

end