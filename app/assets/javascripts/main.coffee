###setUpAjax = ->
  token = $('meta[name="csrf-token"]').attr('content')
  $.ajaxSetup
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', token)###

$(()->
  comMgr = new Chupo.Managers.Comments()

  comMgr.fetch ()->
    comMgr.showIn('#js-comments.comments')

  $("#js-comment-form").on "submit", (evt) ->
    evt.preventDefault()
    success = false
    comMgr.add $(this).serialize(), success, ()->
      if success
        comMgr.fetch ()->
          comMgr.showIn('#js-comments.comments')
      else
        alert(comMgr.lastError())

)














