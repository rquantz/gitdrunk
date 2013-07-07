(($, Backbone, exports) ->
  
  App.Collections.Spirits = Backbone.Collection.extend
    url: '/spirits/?brand_only=true'
    by_category: ->
      @groupBy((s) -> s.get('root_name'))
  
)(jQuery, Backbone, window)

