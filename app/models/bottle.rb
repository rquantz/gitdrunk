class Bottle < ActiveRecord::Base
  belongs_to :bar
  belongs_to :spirit
  
  validates :spirit_id, uniqueness: { scope: :bar_id }
  validates :spirit, presence: true
  validates :bar_id, presence: true
  
  def spirit_name
    spirit.name
  end
  
  def as_json(options={})
    super(options.merge(methods: :spirit_name))
  end
end
