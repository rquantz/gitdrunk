class Cocktail < ActiveRecord::Base
  has_many :recipes
  
  validates :name, presence: true
  
  self.per_page = 20
end
