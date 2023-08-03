class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :recipes, through: :recipe_foods

  validates :name, :measurement_unit, :quantity, :price, presence: true
  validates :quantity, :price, numericality: true , comparison: { greater_than_or_equal_to: 0 }
end
