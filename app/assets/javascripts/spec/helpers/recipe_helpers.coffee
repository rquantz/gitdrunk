window.build_recipe = ->
  return new App.Models.Recipe({
    id: 1
    cocktail_id: 2
    tasting_notes: "Delicious"
    ingredients: [{
      id: 3
      amount: "1 oz"
      spirit_name: "Gin"
    }]
  })
  
window.build_recipes = ->
  recipes = []
  for i in [1..5]
    recipes.push(
      id: i
      cocktail_id: i + 5
      tasting_notes: "Delicious #{i}"
      ingredients: [{
        id: i + 10
        amount: "1 oz"
        spirit_name: "Gin #{i}"
      }]
    )
  new App.Collections.Recipes(recipes)
