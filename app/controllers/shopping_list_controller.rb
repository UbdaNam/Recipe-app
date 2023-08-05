class ShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    recipes = current_user.recipes.preload(:foods)
    food_list = current_user.foods
    @shopping_list = generate_shopping_list(recipes, food_list)
    @total_quantity, @total_price = calculate_totals(@shopping_list)
  end

  private

  def generate_shopping_list(recipes, food_list)
    shopping_list = []
    recipe_foods = RecipeFood.where(recipe_id: recipes.pluck(:id), food_id: food_list.pluck(:id)).includes(:food)
    recipes.each do |recipe|
      recipe_foods.select { |rf| rf.recipe_id == recipe.id }.each do |recipe_food|
        food = recipe_food.food
        general_food = food_list.find { |f| f.id == food.id }
        if general_food
          update_shopping_list(shopping_list, general_food, food, recipe_food.quantity)
        else
          shopping_list << food
        end
      end
    end
    shopping_list
  end
  
  def update_shopping_list(shopping_list, general_food, food, recipe_quantity)
    general_food ||= shopping_list.find { |f| f.id == food.id }
    general_food[:quantity] -= (recipe_quantity * food[:quantity])
    shopping_list << general_food unless shopping_list.include?(general_food)
  end

  def calculate_totals(shopping_list)
    negative_foods = shopping_list.select { |food| food.quantity < 0 }
    total_quantity = negative_foods.sum(&:quantity).abs
    total_price = negative_foods.sum { |food| food.quantity.abs * food.price }
    [total_quantity, total_price]
  end
end
