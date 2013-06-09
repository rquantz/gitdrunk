describe 'Bottles', ->
  it 'orders the bottles by spirit_name', ->
    bottles = new App.Collections.Bottles()
    bottles.add(new App.Models.Bottle(spirit_name: 'Zeta Gin'))
    bottles.add(new App.Models.Bottle(spirit_name: 'Alpha Gin'))
    expect(bottles.last().get('spirit_name')).toBe('Zeta Gin')
    
