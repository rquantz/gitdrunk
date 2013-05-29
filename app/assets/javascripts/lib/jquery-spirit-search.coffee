(($, exports) ->
  
  $.fn.spirit_search = (view) ->
    spirits = null
    @typeahead
      source: (query, process) ->
        $.ajax
          url: "/spirits/search/#{query}"
          type: 'GET'
          dataType: 'json'
          success: (json) ->
            names = []
            spirits = {}
            $.each json, ->
              spirits[@name] = @id
              names.push @name
            return process names
      updater: (item) ->
        view.set_spirit_id(spirits[item])
        item


)(jQuery, window)
