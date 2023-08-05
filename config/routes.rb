Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users

  patch 'recipes/:id/update_public', to: 'recipes#update_public', as: 'recipe_update_public'

  resources :recipes, only: %i[index show new create destroy] do
    patch :update_public, on: :member
  end

  resources :public_recipes, only: [:index]
  resources :recipe_foods, only: %i[create new destroy]
  resources :foods, only: [:index, :new, :create, :destroy]
  get 'general_shopping_list', to: 'shopping_list#index', as: :shopping_list
end