class Recipe < ActiveRecord::Base
  belongs_to :cocktail
  has_many :ingredients
  has_many :spirits, through: :ingredients
  
  validates :cocktail, presence: true
end
