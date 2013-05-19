class Bar < ActiveRecord::Base
  has_and_belongs_to_many :spirits, after_remove: :remove_ancestors
  
  before_save :add_ancestors

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
