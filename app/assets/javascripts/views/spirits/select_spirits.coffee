(($, Backbone, exports) ->
  
  App.Views.SelectSpirits = Backbone.View.extend
    initialize: ->
      @render()
      @collection.fetch().done =>
        @render()
    className: 'select_spirits modal hide fade'
    id: 'select_spirits_modal'
    template: JST['spirits/select_spirits']
    render: ->
      @$el.html(@template(@collection.by_category()))
    save: ->
      @$('input:checked').each (i, input) =>
        $input = $(input)
        attr =
          spirit_name: $input.data('spirit-name')
          spirit_id: $input.data('spirit-id')
          spirit_root: $input.data('spirit-root')

        bottle = new App.Models.Bottle(attr)
        bottle.save().done =>
          @options.bottles.add(bottle)
      @$('input:checked').attr('checked', null)
      @$el.modal('hide')
    events:
      'click .save_select_spirits': 'save_select_spirits_click'
    save_select_spirits_click: ->
      @save()
  
)(jQuery, Backbone, window)
