class Spirit < ActiveRecord::Base
  has_ancestry

  validates :name, presence: true
  
  def in_category?(spirit)
    ancestors.include? spirit
  end
end
