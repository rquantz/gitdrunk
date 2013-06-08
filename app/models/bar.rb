class Bar < ActiveRecord::Base
  belongs_to :user
  has_many :bottles
  has_many :spirits, through: :bottles, after_remove: :remove_ancestors
  
  before_save :add_ancestors
  
  def can_make?(recipe, modifier = 0)
    (recipe.spirits & spirits).count == recipe.spirits.count - modifier
  end
  
  def recipes
    Recipe.all.select { |recipe| can_make?(recipe) }
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
