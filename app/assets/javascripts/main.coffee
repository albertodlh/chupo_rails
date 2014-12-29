setUpAjax = ->
  token = $('meta[name="csrf-token"]').attr('content')
  $.ajaxSetup
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', token)

Comments = () ->
  endpoint = '/api/comments/'
  template = 'test'
  comments = []

  @getList = (callback) ->
    $.getJSON endpoint, (data) ->
      comments = data
      callback()

  @add = (params, callback) ->
    $.post endpoint, params, (data) ->
      if data == 'success'
        @getList callback
      else
        console.log data

  @appendTo = (containerId) ->
    console.log comments
    elem = HandlebarsTemplates[template]({comments: comments})
    $(elem).appendTo(containerId)

  return false

$(()->
  comMgr = new Comments()
  comMgr.getList ()->
    comMgr.appendTo('#container')

  $("#miforma").on "submit", (evt) ->
    evt.preventDefault()
    comMgr.add $(this).serialize(), ()->
      comMgr.appendTo('#container')
)














