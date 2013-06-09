window.build_bottles = ->
  bottles = []
  for i in [1..5]
    bottles.push new App.Models.Bottle
      id: i
      spirit_id: i + 5
      spirit_name: "Spirit #{i}"
      spirit_root: if i % 2 == 0 then 'Even' else 'Odd'
      
  return new App.Collections.Bottles(bottles)
