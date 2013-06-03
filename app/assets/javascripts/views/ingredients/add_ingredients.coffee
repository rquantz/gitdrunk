(($, Backbone, exports) ->
  
  App.Views.AddIngredients = Backbone.View.extend(
    initialize: ->
      @render()
      @collection.on 'add', (ingredient) => @add_to_list(ingredient)
    template: JST['ingredients/add_ingredients']
    className: 'ingredients add_ingredients'
    render: ->
      @$el.html @template()
      @$('.spirit_search_field').spirit_search(this)
      @collection.each (ingredient) =>
        @add_to_list ingredient
    add: ->
      ingredient_attributes = FormHelpers.objectize @$('.add_ingredient_form')
      ingredient = new App.Models.Ingredient(_(ingredient_attributes).extend(recipe_id: @recipe_id()))
      @collection.add ingredient
      @clear_form()
      ingredient.save()
    recipe_id: ->
      @options.recipe_id
    add_to_list: (ingredient) ->
      new App.Views.EditIngredient(model: ingredient).$el.appendTo(@$('.ingredients_list'))
    set_spirit_id: (spirit_id) ->
      @$('.ingredient_spirit_id_field').val(spirit_id)
    clear_form: ->
      @$('.ingredient_amount_field, .spirit_search_field, .ingredient_spirit_id_field').val('')
      @$('.ingredient_amount_field').focus()
    get_recipe_order: ->
    events:
      "submit .add_ingredient_form": "form_submit"
    form_submit: ->
      @add()
      false
  )

)(jQuery, Backbone, window)
