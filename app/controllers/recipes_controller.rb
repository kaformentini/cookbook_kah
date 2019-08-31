class RecipesController < ApplicationController
  before_action :authenticate_user!, only: %i[ new create edit]
  before_action :recipe_type_all, only: %i[ new create edit ] 
  before_action :cuisine_all, only: %i[ new create edit ]
  

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    
    @recipe = Recipe.new(params_recipe)
    @recipe.user = current_user

    if @recipe.save
      redirect_to @recipe
    else
      recipe_type_all
      cuisine_all
      flash.now[:error] = "Você deve informar todos os dados da receita"
      render :new
    end
  end

  def edit
    #if current_user.user_owner?(@recipe)
      @recipe = Recipe.find(params[:id])
    #else
     #redirect_to root_path
    #end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(params_recipe)
      redirect_to @recipe
    else
      recipe_type_all
      flash.now[:error] = "Você deve informar todos os dados da receita"
      render :edit
    end
  end

  def search
    @recipes_search = Recipe.where('title LIKE ?', "%#{params[:search_title]}%")
    if @recipes_search.empty?
      flash[alert] = "Nenhuma receita encontrada"
    else
      flash[alert] = "Resultados de busca:"
    end
  end




private

  def params_recipe
    params.require(:recipe).permit(:title, :image_recipe, :recipe_type_id, :cuisine_id, :difficulty, :cook_time, :difficulty, :ingredients, :cook_method)
  end

  def recipe_type_all
    @recipe_type = RecipeType.all
  end

  def cuisine_all
    @cuisine = Cuisine.all
  end
end
