(($, Backbone, exports) ->

  App.Views.EditRecipe = Backbone.View.extend(
    initialize: ->
      @render()
    className: 'recipe edit_recipe'
    template: JST['recipes/edit_recipe']
    render: ->
      @$el.html @template(@model.attributes)
      ingredients = new App.Collections.Ingredients(@model.get('ingredients'))
      @ingredients_list = new App.Views.AddIngredients(collection: ingredients, recipe_id: @model.id)
      @$('.ingredients_list').html(@ingredients_list.$el)
    save: ->
      @dismiss_modal()
      @model.save @form_values()
    form_values: ->
      FormHelpers.objectize @$('.edit_recipe_form')
    modal: ->
      @$el.modal()
    dismiss_modal: ->
      @$el.modal('hide')
    events:
      'submit .edit_recipe_form': 'form_submit'
    form_submit: ->
      @save()
      false
  )

)(jQuery, Backbone, window)
