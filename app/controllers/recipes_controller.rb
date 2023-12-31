class RecipesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :recipe_created_notice, only: :create
  before_action :recipe_destroyed_notice, only: :destroy

  # GET /recipes or /recipes.json
  def index
    @recipes = current_user.recipes
  end

  def show
    @ingredients = RecipeFood.includes(:food).where(recipe_id: params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def update_public
    @recipe = Recipe.find(params[:id])

    if @recipe.update(public: params[:recipe][:public] == '1')
      flash[:notice] = 'Recipe public status sucessfully changed'
    else
      flash[:danger] = 'Sorry failed to change Recipe Public status!'
    end

    redirect_to request.referrer
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe successfully created' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe = current_user.recipes.find(params[:id])

    if @recipe&.destroy
      flash[:success] = 'Recipe Removed!'
    else
      flash[:danger] = 'Sorry, failed To Remove Recipe!'
    end
    redirect_to request.referrer
  end

  def toggle_visibility
    @toggle_recipe = Recipe.find(params[:id])
    @toggle_recipe.public = true
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end

  def recipe_created_notice
    flash.now[:notice] = 'Recipe was successfully created.'
  end

  def recipe_destroyed_notice
    flash.now[:notice] = 'Recipe was successfully destroyed.'
  end
end
