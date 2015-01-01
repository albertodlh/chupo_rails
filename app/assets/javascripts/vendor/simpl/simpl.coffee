@SimPL = {}

Array.prototype.blank = () ->
  (@length == 0)

String.prototype.includes = (regexp) ->
  regexp.test(@toLowerCase())

class SimPL.Collection extends Array
  name: ''

  where: (filter) ->
    filtered = new SimPL.Collection()
    filtered = _.where(@, filter)
    return filtered


class SimPL.Manager
  endpoint: ''
  template: ''
  errorsTemplate: ''
  collection: []
  errors: []
  tempTemplate: null
  tempContainer: null
  onAdd: 'prepend'

  addError: (text) ->
    @errors.push text

  afterFetch: (item) ->
    true

  fetch: (callback, options) ->
    @collection = []
    endpoint = @endpoint

    if options?
      paramList = _.keys(options) #Object.keys(options)
      if not paramList.blank()
        paramString = '?'
        for param in paramList
          paramString += (if paramString is '?' then '' else '&') + param + '=' + options[param]
        endpoint += paramString

    $.getJSON endpoint, (data) =>
      @collection = data.data
      @afterFetch(@collection)

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
        if data.success
          success = true
          item = data.data
          template = @tempTemplate || @collectionItemTemplate
          container = @tempContainer || @collectionContainer
          @addCollectionItem(item, template, container, @onAdd)
          @tempTemplate = null
          @tempContainer = null
        else
          APIerrors = data.errors
          for error in APIerrors
            @errors.push error
        callback(success)
      , 'json'
    else
      callback(success)

  withTemplate: (template) ->
    @tempTemplate = template
    return @

  inContainer: (containerId) ->
    @tempContainer = containerId
    return @

  beforeShow: (item) ->
    return true

  beforeAppend: (el) ->
    return true

  afterAppend: (el) ->
    return true

  addCollectionItem: (item, template, container, type) ->
    @beforeShow(item)
    elem = HandlebarsTemplates[template](item)
    @beforeAppend(elem)
    if type is 'append'
      $(container).append(elem)
    else
      $(container).prepend(elem)
    @afterAppend(elem)


  showCollection: (filter) ->
    if $(@collectionContainer)
      collection = if filter then _.where(@collection, filter) else @collection
      template = @tempTemplate || @collectionItemTemplate
      container = @tempContainer || @collectionContainer

      $(container).empty
      for item in collection
        @addCollectionItem(item, template, container, 'append')

      @tempTemplate = null
      @tempContainer = null

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


