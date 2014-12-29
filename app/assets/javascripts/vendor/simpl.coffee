@SimPL = {}

class SimPL.Manager
  endpoint: ''
  template: ''
  collection: []

  fetch: (callback) ->
    $.getJSON @endpoint, (data) =>
      @collection = data
      callback()

  add: (params, callback) ->
    $.post @endpoint, params, (data) =>
      if data == 'success'
        callback()
      else
        console.log data

  showIn: (containerId) ->
    elem = HandlebarsTemplates[@template](@collection)
    $(containerId).html(elem)