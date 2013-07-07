window.build_spirits = ->
  spirits = []
  for i in [1..5]
    spirits.push new Backbone.Model
      id: i
      name: "Spirit #{i}"
      root_name: "Parent Spirit #{i % 2}"
      
  new App.Collections.Spirits(spirits)
