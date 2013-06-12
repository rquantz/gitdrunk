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
    ingredient_difference(recipe).length - modifier == 0 && recipe.spirits.any?
  end
  
  def recipes
    @recipes ||= Recipe.all.select { |recipe| can_make?(recipe) }
  end
  
  def cocktails
    @cocktails ||= recipes.collect { |recipe| recipe.cocktail }.uniq
  end
  
  def next_bottles
    top_bottles.collect {|item| item[0] }.flatten
  end

  def top_bottles
    @top_bottles ||= best_bottles.sort_by {|spirits, recipes| recipes.length }.reverse
  end
  
  def almost_recipes
    @almost_recipes ||= Recipe.all.select { |recipe| can_make?(recipe, 1) }
  end
  
  def almost_cocktails
    @almost_cocktails ||= almost_recipes.collect { |recipe| recipe.cocktail }.uniq
  end

  private
    def ingredient_difference(recipe)
      recipe.spirits - spirits
    end
    
    def best_bottles
      best_hash = {}
      Recipe.all.each do |recipe|
        diff = ingredient_difference(recipe)
        diff.sort!
        best_hash[diff] = [] unless best_hash.has_key? diff
        best_hash[diff] << recipe.cocktail unless best_hash[diff].include? recipe.cocktail
      end
      @next_recipes ||= best_hash.select {|spirits, recipes| spirits.length == 1}
    end

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
