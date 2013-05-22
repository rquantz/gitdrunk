(($, exports) ->

  $.fn.clear_form = ->
    @find('input[type="text"]').val('')
    @find('input[type="checkbox"]').attr('checked', false)
    @find('input[name="spirit[name]"]').focus()
    this

  render_spirit = (spirit) ->
    $("<li class='js-draggable-spirit spirit-list #{'brand-spirit' if spirit['is_brand']}' data-spirit-id='#{spirit['id']}'>
      #{spirit['name']}
      | <a href='/spirits/#{spirit['id']}/edit'>Edit</a>
      </li>")
      
  render_spirit_form = (parent_id='') ->
    $("<li><form method='POST' action='/spirits'>
         <input type='text' name='spirit[name]' />
         <input type='hidden' name='spirit[parent_id]' value='#{parent_id}' />
         <input type='hidden' name='spirit[is_brand]' value='0' />
         <input type='checkbox' name='spirit[is_brand]' value='1' />
         <label for='spirit[is_brand]'>brand?</label>
         <input type='submit' value='Create' />
       </form></li>").find('form').submit(->
        $.ajax
          url: '/spirits'
          type: 'POST'
          dataType: 'json'
          data: $(this).serialize()
          success: (response) ->
            new_spirit = render_spirit(response).appendTo(".children-of-spirit-#{parent_id}")
              .draggable(revert: 'invalid')
              .droppable(droppable_prefs)
            if !new_spirit.hasClass('brand-spirit')
              render_spirit_form(response['id']).wrap("<ul class='children-of-spirit-#{response['id']}'>")
                .parent()
                .insertAfter(new_spirit)

        $(this).clear_form()
        return false
      ).submit(false).parent()

  droppable_prefs =
    accept: '.js-draggable-spirit'
    over: (e, ui) ->
      $(this).css('border-color', '#aaa')
    out: (e, ui) ->
      $(this).css('border-color', 'transparent')
    drop: (e, ui) ->
      parent_id = $(this).data('spirit-id')
      spirit_id = ui.draggable.data('spirit-id')
      $(this).css('border-color', 'transparent')
      $.ajax
        url: "/spirits/#{spirit_id}"
        type: 'POST'
        dataType: 'json'
        data: 
          _method: 'PUT'
          spirit: { parent_id: parent_id }
        success: (response) ->
          ui.draggable.remove()
          $children = $(".children-of-spirit-#{spirit_id}").remove()
          render_spirit(response).appendTo(".children-of-spirit-#{parent_id}")
            .draggable(revert: 'invalid')
            .droppable(droppable_prefs)
          $children.appendTo(".children-of-spirit-#{parent_id}")
            .find('.js-draggable-spirit')
            .draggable(revert: 'invalid')
            .droppable(droppable_prefs)

  $(->
                     
    $('.nested-spirits').not('.brand-spirit').each ->
      parent_id = $(this).data('parent-id')
      render_spirit_form(parent_id).prependTo(this)          
    $('.js-draggable-spirit').draggable(revert: 'invalid')
    $('.js-draggable-spirit').droppable(droppable_prefs)

  )
  
)(jQuery, window)

