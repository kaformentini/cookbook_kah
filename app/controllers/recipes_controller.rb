class RecipesController < ApplicationController
  before_action :recipe_type_all, only: %i[ new create edit ]

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
    if @recipe.save
      redirect_to @recipe
    else
      recipe_type_all
      flash.now[:error] = "Você deve informar todos os dados da receita"
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
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

private

  def params_recipe
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine, :difficulty, :cook_time, :difficulty, :ingredients, :cook_method)
  end

  def recipe_type_all
    @recipe_type = RecipeType.all
  end


end
