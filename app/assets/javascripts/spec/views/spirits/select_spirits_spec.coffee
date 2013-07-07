describe 'SelectSpirits', ->
  spirits = null
  select_spirits_view = null

  beforeEach ->
    spirits = build_spirits()
    select_spirits_view = new App.Views.SelectSpirits(collection: spirits, bottles: new App.Collections.Bottles())
    
  it 'has an el', ->
    expect(select_spirits_view.$el).toBe('#select_spirits_modal.select_spirits')
    
  it 'has a form with elements', ->
    expect(select_spirits_view.$el).toContain('form')
    expect(select_spirits_view.$('input[type="checkbox"]').length).toEqual(spirits.length)
    
  describe 'save', ->
    beforeEach ->
      select_spirits_view.$('input').first().attr('checked', 'checked')

    it 'saves a new bottle for each checked spirit', ->
      real_model = App.Models.Bottle
      spyOn(App.Models, 'Bottle').andReturn(new real_model())
      select_spirits_view.save()
      expect(App.Models.Bottle).toHaveBeenCalled()

    it 'dismisses the modal', ->
      spyOn(select_spirits_view.$el, 'modal')
      select_spirits_view.save()
      expect(select_spirits_view.$el.modal).toHaveBeenCalledWith('hide')

    it 'unchecks the inputs', ->
      select_spirits_view.save()
      expect(select_spirits_view.$('input:checked').length).toBe(0)
      
  describe 'save button click', ->
    beforeEach ->
      select_spirits_view.$el.appendTo('body')
      
    afterEach ->
      select_spirits_view.remove()
      
    it 'calls save()', ->
      spyOn(select_spirits_view, 'save')
      select_spirits_view.$('.save_select_spirits').trigger('click')
      expect(select_spirits_view.save).toHaveBeenCalled()
