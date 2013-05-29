(($, exports) ->
  
  exports.FormHelpers =
    objectize: (form) ->
      output = {}
      $.each $(form).serializeArray(), ->
        output[@name] = @value
      return output

)(jQuery, window)
