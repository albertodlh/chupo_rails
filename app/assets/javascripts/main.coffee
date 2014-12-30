###setUpAjax = ->
  token = $('meta[name="csrf-token"]').attr('content')
  $.ajaxSetup
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', token)###

$(()->
  $('#js-comment-form').parsley();

  $('.js-twitter-date').each (inx, rawDate) ->
    $(rawDate).html(moment($(rawDate).html(), 'YYYY-MM-DD HH:mm:ss Z').fromNow())

  comMgr = new Chupo.Managers.Comments()

  comMgr.fetch ()->
    comMgr.showIn('#js-comments.comments')

  $("#js-comment-form").on "submit", (evt) ->
    evt.preventDefault()
    elem = comMgr.createFrom("#js-comment-form")
    console.log elem

    comMgr.add $(this).serialize(), (success)->
      if success
        comMgr.fetch ()->
          comMgr.showIn('#js-comments.comments')
      else
        alert(comMgr.lastError())
)














