(($, Backbone, exports) ->
  
  App.Views.ListBottles = Backbone.View.extend
    initialize: ->
      @render()
      @collection.on 'add', => @render()
    tagName: 'dl'
    className: 'list_bottles'
    template: JST['bottles/list_bottles']
    render: ->
      @$el.html(@template(@collection))

)(jQuery, Backbone, window)
