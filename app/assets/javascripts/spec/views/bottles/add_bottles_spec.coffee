describe 'AddBottles', ->

  describe 'when instantiated', ->
    bottles = null
    add_bottles_view = null

    beforeEach ->
      bottles = build_bottles()
      add_bottles_view = new App.Views.AddBottles(collection: bottles)
      
    it 'has an element', ->
      expect(add_bottles_view.$el).toBe('.add_bottles')
      
    it 'has a form', ->
      expect(add_bottles_view.$('.add_bottles_form').length).toBe(1)
      
    describe 'set_spirit_id', ->
      it 'sets the spirit_id attribute', ->
        add_bottles_view.set_spirit_id(5)
        expect(add_bottles_view.spirit_id).toBe(5)
        
      it 'removes the disabled class from the submit button', ->
        add_bottles_view.set_spirit_id(5)
        expect(add_bottles_view.$('.submit_add_bottle')).not.toHaveClass('disabled')
    
    describe 'set_spirit_name', ->
      it 'sets the spirit_name attribute', ->
        add_bottles_view.set_spirit_name('New spirit')
        expect(add_bottles_view.spirit_name).toBe('New spirit')
        
    describe 'add_bottle', ->
      beforeEach ->
        add_bottles_view.set_spirit_id(6)
        add_bottles_view.set_spirit_name('Cleopatra Mead')

      it 'adds a bottle to the collection when the record is saved', ->
        jasmine.Ajax.useMock()

        collection_length = bottles.length
        add_bottles_view.add_bottle()
        request = mostRecentAjaxRequest()
        request.response(AjaxResponses.save_bottle.success(spirit_id: 6, spirit_name: 'Cleopatra Mead'))

        expect(bottles.length).toEqual(collection_length + 1)

      it 'saves the bottle', ->
        jasmine.Ajax.useMock()

        add_bottles_view.add_bottle()
        request = mostRecentAjaxRequest()
        request.response(AjaxResponses.save_bottle.success(spirit_id: 6, spirit_name: 'Cleopatra Mead'))
        expect(bottles.findWhere(spirit_name: 'Cleopatra Mead').isNew()).toBeFalsy()

      it 'clears spirit_id and spirit_name', ->
        add_bottles_view.add_bottle()
        expect(add_bottles_view.spirit_id).toBeNull()
        expect(add_bottles_view.spirit_name).toBeNull()
        
      it 'returns the disabled class to the submit button', ->
        add_bottles_view.add_bottle()
        expect(add_bottles_view.$('.submit_add_bottle')).toHaveClass('disabled')
        
      it 'empties the search field', ->
        add_bottles_view.$('.spirit_search_field').val('Search')
        add_bottles_view.add_bottle()
        expect(add_bottles_view.$('.spirit_search_field').val()).toBeFalsy()
        
      describe 'without valid attributes', ->
        collection_length = null
        
        beforeEach ->
          collection_length = bottles.length

        it 'does nothing when spirit_id is not set', ->
          add_bottles_view.set_spirit_id(null)
          add_bottles_view.add_bottle()
          expect(bottles.length).toEqual(collection_length)
        
        it 'does nothing when spirit_name is not set', ->
          add_bottles_view.set_spirit_name(null)
          add_bottles_view.add_bottle()
          expect(bottles.length).toEqual(collection_length)
      
    describe 'form submit', ->
      it 'triggers bottle_add', ->
        spyOn(add_bottles_view, 'add_bottle')
        add_bottles_view.$('.add_bottles_form').submit()
        expect(add_bottles_view.add_bottle).toHaveBeenCalled()
        


