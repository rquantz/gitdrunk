class Recipe < ActiveRecord::Base
  attr_accessor :current_user

  belongs_to :cocktail
  belongs_to :user
  has_many :ingredients
  has_many :spirits, through: :ingredients
  
  validates :cocktail, presence: true
  
  def ingredients
    super.order(:recipe_order)
  end
  
  def in_bar(bar=nil)
    bar ||= current_user.try(:bar)
    bar ||= cocktail.current_user.try(:bar)
    if bar
      bar.can_make? self
    else
      false
    end
  end
  
  def in_bar?(bar=nil)
    in_bar(bar)
  end

  def as_json(options={})
    super(options.merge(include: {ingredients: {methods: [:spirit_name]}}, methods: :in_bar))
  end
end
