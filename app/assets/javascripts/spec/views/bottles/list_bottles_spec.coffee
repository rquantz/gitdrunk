describe 'ListBottles', ->
  bottles = null
  list_bottles_view = null

  beforeEach ->
    bottles = build_bottles()
    list_bottles_view = new App.Views.ListBottles(collection: bottles)

  it 'has an element', ->
    expect(list_bottles_view.$el).toBe('dl.list_bottles')
    
  it 'renders its collection as a list', ->
    expect(list_bottles_view.$('.list_bottles_bottle').length).toEqual(bottles.length)
    
  describe 'add to collection', ->
    it 'adds the new bottle to the element', ->
      bottle = new App.Models.Bottle(spirit_name: 'spirit 6')
      bottles.add(bottle)
      expect(list_bottles_view.$('.list_bottles_bottle').length).toEqual(bottles.length)
  
  describe 'destroy_bottle', ->
    it 'removes the model from the collection', ->
      collection_length = bottles.length
      list_bottles_view.destroy_bottle(bottles.first().id)
      expect(bottles.length).toBe(collection_length - 1)
      
    it 'removes the spirit from the view', ->
      collection_length = bottles.length
      list_bottles_view.destroy_bottle(bottles.first().id)
      expect(list_bottles_view.$('.list_bottles_bottle').length).toEqual(collection_length - 1)
      
  describe 'click_destroy', ->
    beforeEach ->
      list_bottles_view.$el.appendTo('body')

    afterEach ->
      list_bottles_view.remove()

    it 'calls destroy_bottle', ->
      spyOn(list_bottles_view, 'destroy_bottle');
      list_bottles_view.$('.list_bottles_destroy').trigger('click')
      expect(list_bottles_view.destroy_bottle).toHaveBeenCalled()




