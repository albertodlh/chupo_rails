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

  validate: (item) ->
    true

  add: (params, callback) ->
    success = false
    if @validate(params)
      $.post @endpoint, params, (data) =>
        if data == 'success'
          success = true
        else
          @errors.push data
    callback(success)

  add: (params, callback) ->
    success = false
    if @validate(params)
      $.post @endpoint, params, (data) =>
        if data == 'success'
          success = true
        else
          @errors.push data
    callback(success)

  showIn: (containerId) ->
    elem = HandlebarsTemplates[@template](@collection)
    $(containerId).html(elem)

  lastError: () ->
    @errors[@errors.length-1]

  createFrom: (formId) ->
    obj = {}
    array = $(formId).serializeArray()
    $.each array, (inx, item) ->
      itemname = item.name
      if itemname.indexOf("[") != -1
        parent = itemname.split("[")[0]
        child = itemname.split("[")[1].replace("]", "")
        itemname = child
      if (obj[itemname] != undefined)
        if (!obj[itemname].push)
          obj[itemname] = [obj[itemname]]
        obj[itemname].push(item.value || '')
      else
        obj[itemname] = item.value || ''
    return obj


