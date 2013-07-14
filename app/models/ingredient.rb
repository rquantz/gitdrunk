class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :spirit
  
  validates :spirit, presence: true
  validates :recipe, presence: true
  validates :amount, presence: true
  
  def self.sub_spirit(old_id, new_id)
    where(spirit_id: old_id).each do |ingredient|
      ingredient.spirit_id = new_id
      ingredient.save
    end
  end

  def spirit_name
    spirit.name
  end
  
  def as_json(options={})
    super(options.merge({methods: :spirit_name}))
  end
end
