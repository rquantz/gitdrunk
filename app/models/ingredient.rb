class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :spirit
  
  validates :spirit, presence: true
  validates :recipe, presence: true
  validates :amount, presence: true
  
  def spirit_name
    spirit.name
  end
  
  def as_json(options={})
    super(options.merge({methods: :spirit_name}))
  end
end
