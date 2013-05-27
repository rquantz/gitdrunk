class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :spirit
  
  validates :spirit, presence: true
  validates :recipe, presence: true
  validates :amount, presence: true
end
