describe 'Spirits', ->
  spirits = null

  beforeEach ->
    spirits = build_spirits()

  it 'has a url', ->
    expect(spirits.url).toBe('/spirits/?brand_only=true')
    
  describe 'by_category', ->
    it 'returns a hash of the spirits with root spirits as the keys', ->
      keys = _(spirits.by_category()).keys()
      expect(keys.length).toBe(2)
