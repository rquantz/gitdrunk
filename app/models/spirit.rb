class Spirit < ActiveRecord::Base
  has_many :ingredients
  has_many :recipes, through: :ingredients
  has_ancestry

  validates :name, presence: true
  
  def in_category?(spirit)
    ancestors.include? spirit
  end
end
