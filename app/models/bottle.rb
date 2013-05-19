class Bottle < ActiveRecord::Base
  belongs_to :bar
  belongs_to :spirit
  
  validates :spirit_id, uniqueness: { scope: :bar_id }
end
