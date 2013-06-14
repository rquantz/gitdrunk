class Recipe < ActiveRecord::Base
  belongs_to :cocktail
  belongs_to :user
  has_many :ingredients
  has_many :spirits, through: :ingredients
  
  validates :cocktail, presence: true
  
  def ingredients
    super.order(:recipe_order)
  end

  def as_json(options={})
    super(options.merge(include: {ingredients: {methods: :spirit_name}}))
  end
end
