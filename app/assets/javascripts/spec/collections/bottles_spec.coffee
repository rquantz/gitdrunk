describe 'Bottles', ->
  it 'orders the bottles by spirit_name', ->
    bottles = new App.Collections.Bottles()
    bottles.add(new App.Models.Bottle(spirit_name: 'Zeta Gin'))
    bottles.add(new App.Models.Bottle(spirit_name: 'Alpha Gin'))
    expect(bottles.last().get('spirit_name')).toBe('Zeta Gin')
  describe '#categories', ->
    bottles = null

    beforeEach ->
      bottles = build_bottles()

    it 'returns a hash of the categories from spirit_root', ->
      expect(bottles.categories()['Even']).toBeDefined()
      expect(bottles.categories()['Odd']).toBeDefined()
      
    it 'arranges the bottles into categories based on spirit_root', ->
      expect(bottles.categories()['Even'].length).toBe(2)
      expect(bottles.categories()['Odd'].length).toBe(3)
