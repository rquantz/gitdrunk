(($, Backbone, exports) ->
  
  App.Collections.Bottles = Backbone.Collection.extend
    model: App.Models.Bottle
    comparator: (model) ->
      model.get('spirit_name')
    categories: ->
      output = {}
      @each (bottle) ->
        root = bottle.get('spirit_root')
        output[root] = [] unless output[root]?
        output[root].push bottle
      output

)(jQuery, Backbone, window)
