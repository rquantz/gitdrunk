ThinkingSphinx::Index.define :spirit, with: :active_record do
  indexes :name, :sortable => true
  has is_brand
end
