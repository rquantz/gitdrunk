class Spirit < ActiveRecord::Base
  has_many :ingredients
  has_many :recipes, through: :ingredients
  has_many :bottles
  has_many :bars, through: :bottles
  has_ancestry

  validates :name, presence: true
  
  def self.brand_only
    where(is_brand: true)
  end

  def in_category?(spirit)
    ancestors.include? spirit
  end
  
  def root_name
    root.name unless root?
  end
  
  def as_json(opts={})
    super(opts.merge(methods: [:root_name]))
  end
end
