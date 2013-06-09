class Bar < ActiveRecord::Base
  belongs_to :user
  has_many :bottles
  has_many :spirits, through: :bottles, after_remove: :remove_ancestors
  
  before_save :add_ancestors
  
  def brand_spirits
    spirits.where(is_brand: true)
  end
  
  def brand_bottles
    bottles.joins(:spirit).where('spirits.is_brand = true')
  end
  
  def can_make?(recipe, modifier = 0)
    ((recipe.spirits & spirits).count == recipe.spirits.count - modifier) && recipe.spirits.any?
  end
  
  def recipes
    @recipes ||= Recipe.all.select { |recipe| can_make?(recipe) }
  end
  
  def cocktails
    @cocktails ||= recipes.collect { |recipe| recipe.cocktail }.uniq
  end
  
  def almost_recipes
    @almost_recipes ||= Recipe.all.select { |recipe| can_make?(recipe, 1) }
  end
  
  def almost_cocktails
    @almost_cocktails ||= almost_recipes.collect { |recipe| recipe.cocktail }.uniq
  end

  private
    def add_ancestors
      spirits.each do |spirit|
        spirits << (spirit.ancestors - (spirits & spirit.ancestors))
      end
    end

    def remove_ancestors(spirit)
      spirits.delete(*spirit.ancestors)
      add_ancestors
    end
end
