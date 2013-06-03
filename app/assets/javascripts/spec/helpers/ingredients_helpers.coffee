window.build_ingredients = ->
  ingredients = []
  for i in [1..5]
    ingredients.push new App.Models.Ingredient(
      spirit_name: "Spirit #{i}"
      spirit_id: i
      recipe_id: 6
      amount: '1 oz'
    )
  new App.Collections.Ingredients(ingredients)
