(($, Backbone, exports) ->
  
  App.Views.AddIngredients = Backbone.View.extend(
    initialize: ->
      @_ingredient_views = {}
      @render()
      @$('tbody').sortable
        update: =>
          @collection.set_recipe_order(@get_recipe_order())
          @collection.each (model) -> model.save()
      @collection.on 'add', (ingredient) => @add_to_list(ingredient)
      @collection.on 'remove', (ingredient) => @remove_from_list(ingredient)
    template: JST['ingredients/add_ingredients']
    className: 'ingredients add_ingredients'
    render: ->
      @$el.html @template()
      @$('.spirit_search_field').spirit_search(this)
      @collection.each (ingredient) =>
        @add_to_list ingredient
    add: ->
      ingredient_attributes = FormHelpers.objectize @$('.add_ingredient_form')
      ingredient = new App.Models.Ingredient(
        _(ingredient_attributes).extend(recipe_id: @recipe_id(), recipe_order: @collection.length))
      @collection.add ingredient
      @clear_form()
      ingredient.save()
    recipe_id: ->
      @options.recipe_id
    _ingredient_views: {}
    add_to_list: (ingredient) ->
      edit_ingredient = new App.Views.EditIngredient(model: ingredient)
      edit_ingredient.$el.appendTo(@$('.ingredients_list'))
      edit_ingredient.on 'delete', (view) =>
        @collection.remove(view.model)
      @_ingredient_views[ingredient.cid] = edit_ingredient
    remove_from_list: (ingredient) ->
      @_ingredient_views[ingredient.cid].remove()
      delete @_ingredient_views[ingredient.cid]
    set_spirit_id: (spirit_id) ->
      @$('.ingredient_spirit_id_field').val(spirit_id)
    clear_form: ->
      @$('.ingredient_amount_field, .spirit_search_field, .ingredient_spirit_id_field').val('')
      @$('.ingredient_amount_field').focus()
    get_recipe_order: ->
      output = {}
      _(@_ingredient_views).each (view) ->
        output[view.model.cid] = view.$el.index()
      output
    events:
      "submit .add_ingredient_form": "form_submit"
    form_submit: ->
      @add()
      false
  )

)(jQuery, Backbone, window)
