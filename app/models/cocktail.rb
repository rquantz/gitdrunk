class Cocktail < ActiveRecord::Base
  attr_accessor :current_user

  has_many :recipes
  
  validates :name, presence: true, uniqueness: true
  
  self.per_page = 20
end
