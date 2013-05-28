class Recipe < ActiveRecord::Base
  belongs_to :cocktail
  has_many :ingredients
  has_many :spirits, through: :ingredients
  
  validates :cocktail, presence: true
  
  def as_json(options={})
    super(options.merge({include: :ingredients}))
  end
end
