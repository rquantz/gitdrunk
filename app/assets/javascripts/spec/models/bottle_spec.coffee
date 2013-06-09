describe 'Bottle', ->
  bottle = null

  beforeEach ->
    bottle = new App.Models.Bottle
      id: 1
      spirit_id: 2
      spirit_name: 'Beefeater Gin'

  it 'has a url', ->
    expect(bottle.url()).toBe('/bottles/1')
