@SimPL = {}

Array.prototype.blank = () ->
  (@.length == 0)

class SimPL.Manager
  endpoint: ''
  template: ''
  errorsTemplate: ''
  collection: []
  errors: []

  addError: (text) ->
    @errors.push text

  fetch: (callback, options) ->
    @collection = []
    endpoint = @endpoint

    if options?
      paramList = Object.keys(options)
      if not paramList.blank()
        paramString = '?'
        for param in paramList
          paramString += (if paramString is '?' then '' else '&') + param + '=' + options[param]
        endpoint += paramString

    $.getJSON endpoint, (data) =>
      @collection = data
      callback()

  validate: (item) ->
    if @errors.blank()
      true
    else
      false

  beforeSave: (item) ->
    true

  serialize: (item) ->
    string = ''
    objname = item.__control__.objname
    paramList = Object.keys(item)
    if not paramList.blank()
      for param in paramList
        if param is '__control__'
          controls = item[param]
          controlList = Object.keys(controls)
          for control in controlList
            if control != 'objname'
              string += control + '=' + encodeURIComponent(controls[control]) + '&'
        else
          string += objname + '%5B' + param + '%5D=' + encodeURIComponent(item[param]) + '&'
    string = string.substring(0, string.length - 1)
    return string

  add: (formId, callback) ->
    success = false
    @errors = []
    item = @createFrom(formId)
    @beforeSave(item)
    if @validate(item)
      #serial = @serialX(item)
      #console.log $(formId).serialize()
      $.post @endpoint, @serialize(item), (data) =>
        if data is 'success'
          success = true
        else
          @errors.push data
        callback(success)
    else
      callback(success)

  showAll: () ->
    if $(@collectionContainer)
      @showIn(@collectionContainer)

  showIn: (containerId) ->
    elem = HandlebarsTemplates[@collectionTemplate](@collection)
    $(containerId).html(elem)

  showErrors: () ->
    if $(@errorContainer)
      @showErrorsIn(@errorContainer)

  showErrorsIn: (containerId) ->
    if @errorsTemplate
      elem = HandlebarsTemplates[@errorsTemplate](@errors)
    else
      ul = $('<ul/>').addClass('simpl-error-list')
      $.each @errors, (inx, item) ->
        li = $('<li/>').text(item).appendTo(ul)
      elem = ul
    $(containerId).html(elem)

  lastError: () ->
    @errors[@errors.length-1]

  createFrom: (formId) ->
    objname = ''
    obj = {}
    obj['__control__'] = {}
    array = $(formId).serializeArray()
    $.each array, (inx, item) ->
      itemname = item.name
      curobj = obj
      if itemname.indexOf("[") != -1
        parent = itemname.split("[")[0]
        if objname is ''
          objname = parent
          obj['__control__'].objname = objname
        child = itemname.split("[")[1].replace("]", "")
        itemname = child
      else
        curobj = obj['__control__']
      if curobj[itemname]?
        if not curobj[itemname].push
          curobj[itemname] = [curobj[itemname]]
        curobj[itemname].push(item.value || '')
      else
        curobj[itemname] = item.value || ''
    console.log obj
    return obj


