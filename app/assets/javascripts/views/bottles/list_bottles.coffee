(($, Backbone, exports) ->
  
  App.Views.ListBottles = Backbone.View.extend
    initialize: ->
      @render()
      @collection.on 'add', => @render()
      @collection.on 'remove', => @render()
    tagName: 'dl'
    className: 'list_bottles'
    template: JST['bottles/list_bottles']
    render: ->
      @$el.html(@template(@collection))
    destroy_bottle: (bottle_id) ->
      bottle = @collection.findWhere(id: bottle_id)
      bottle.destroy()
    events:
      'click .list_bottles_destroy': 'destroy_click'
    destroy_click: (e) ->
      id = $(e.target).data('bottle-id')
      @destroy_bottle(id)
      return false


)(jQuery, Backbone, window)
