window.AjaxResponses =
  create_ingredient:
    success: (attributes) ->
      status: 201
      responseText: JSON.stringify(_(attributes).extend(id: 1212))
  save_recipe:
    success:
      status: 201
      responseText: JSON.stringify(id: 145, cocktail_id: 1, tasting_note: null)
  save_bottle:
    success: (attributes) ->
      status: 201
      responseText: JSON.stringify(_(attributes).extend(id: 2323))
