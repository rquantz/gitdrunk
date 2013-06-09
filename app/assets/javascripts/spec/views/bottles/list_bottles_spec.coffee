describe 'ListBottles', ->
  bottles = null
  list_bottles_view = null

  beforeEach ->
    bottles = build_bottles()
    list_bottles_view = new App.Views.ListBottles(collection: bottles)

  it 'has an element', ->
    expect(list_bottles_view.$el).toBe('ul.list_bottles')
    
  it 'renders its collection as a list', ->
    expect(list_bottles_view.$('.list_bottles_bottle').length).toEqual(bottles.length)
    
  describe 'add to collection', ->
    it 'adds the new bottle to the element', ->
      bottle = new App.Models.Bottle(spirit_name: 'spirit 6')
      bottles.add(bottle)
      expect(list_bottles_view.$('.list_bottles_bottle').length).toEqual(bottles.length)

