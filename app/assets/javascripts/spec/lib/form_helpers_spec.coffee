describe "FormHelpers", ->
  
  describe "objectize", ->
    it 'returns the values of a form element serialized as an object', ->
      loadFixtures('form.html')
      form = $('#form-fixture')
      expect(FormHelpers.objectize(form)).toEqual({
        'a': '1',
        'b': '2',
        'c': '3',
        'd': '4',
        'e': '5'
      })
