class ShoppingListController < ApplicationController
  before_action :authenticate_user!

  def index
    recipes = current_user.recipes.includes(:foods)
    food_list = current_user.foods
    @shopping_list = []
    missing_food = {}
    recipes.each do |recipe|
      recipe.foods.each do |food|
        general_food = food_list.find { |f| f.id == food.id }
        if general_food
          if @shopping_list.include?(general_food)
            general_food = @shopping_list.find { |f| f.id == food.id }
            general_food[:quantity] = general_food[:quantity] - food[:quantity]
          else
            general_food[:quantity] = general_food[:quantity] - food[:quantity]
            @shopping_list << general_food
          end
        else
          @shopping_list << food
        end
      end
    end

  end
end
