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
