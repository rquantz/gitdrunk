(($, Backbone, exports) ->
  
  App.Views.AddBottles = Backbone.View.extend
    initialize: ->
      @render()
      @$('.spirit_search_field').spirit_search(this, (search) -> "/spirits/search/#{search}/?brand_only=true")
    className: 'add_bottles'
    template: JST['bottles/add_bottles']
    render: ->
      @$el.html(@template())
    set_spirit_id: (id) ->
      @spirit_id = id
      @$('.submit_add_bottle').removeClass('disabled')
    set_spirit_name: (name) ->
      @spirit_name = name
    add_bottle: ->
      if @spirit_id? && @spirit_name?
        bottle = new App.Models.Bottle(spirit_id: @spirit_id, spirit_name: @spirit_name)
        promise = bottle.save().done? =>
          @collection.add bottle
        @clear_spirit()
    clear_spirit: ->
        @spirit_id = null
        @spirit_name = null
        @$('.submit_add_bottle').addClass('disabled')
        @$('.spirit_search_field').val('')
    events:
      'submit .add_bottles_form': 'submit_form'
    submit_form: ->
      @add_bottle()
      return false
    

)(jQuery, Backbone, window)
