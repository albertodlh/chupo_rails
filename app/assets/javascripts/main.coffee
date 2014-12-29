###setUpAjax = ->
  token = $('meta[name="csrf-token"]').attr('content')
  $.ajaxSetup
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', token)###

$(()->
  comMgr = new Chupo.Managers.Comments()

  comMgr.fetch ()->
    comMgr.showIn('#container')

  $("#miforma").on "submit", (evt) ->
    evt.preventDefault()
    comMgr.add $(this).serialize(), ()->
      comMgr.fetch ()->
        comMgr.showIn('#container')
)














