setUpAjax = ->
  token = $('meta[name="csrf-token"]').attr('content')
  $.ajaxSetup
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', token)

getComments = ->
  $.getJSON "/api/comments/", (data) ->
    console.log data

saveCommentAnt = (callback) ->
  params =
    comment:
      user: "Alberto"
      email: "albertodlh@gmail.com"
      content: "Nada"
      website: "concha"

  $.post "/api/comments/", params, (data) ->
    if data == 'success'
      callback()
    else
      console.log data

saveComment = (params, callback) ->
  $.post "/api/comments/", params, (data) ->
    if data == 'success'
      callback()
    else
      console.log data

$(()->
  #setUpAjax()
  #saveComment(getComments)

  $("#miforma").on "submit", (evt) ->
    evt.preventDefault()
    saveComment $(this).serialize(), getComments
    #console.log $(this).serialize()
)


