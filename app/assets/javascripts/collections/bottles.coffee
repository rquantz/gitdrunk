(($, Backbone, exports) ->
  
  App.Collections.Bottles = Backbone.Collection.extend
    model: App.Models.Bottle
    comparator: (model) ->
      model.get('spirit_name')

)(jQuery, Backbone, window)
