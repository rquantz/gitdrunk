ThinkingSphinx::Index.define :cocktail, with: :active_record do
  indexes :name
  indexes recipes.spirits.name, as: :spirit_names
end
