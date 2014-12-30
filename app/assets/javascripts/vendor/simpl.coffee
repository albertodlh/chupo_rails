@SimPL = {}

class SimPL.Manager
  endpoint: ''
  template: ''
  collection: []
  errors: []

  fetch: (callback) ->
    $.getJSON @endpoint, (data) =>
      @collection = data
      callback()

  add: (params, success, callback) ->
    $.post @endpoint, params, (data) =>
      if data == 'success'
        success = true
      else
        success = false
        @errors.push data
      callback()

  showIn: (containerId) ->
    elem = HandlebarsTemplates[@template](@collection)
    $(containerId).html(elem)

  lastError: () ->
    @errors[@errors.length-1]
