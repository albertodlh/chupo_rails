###setUpAjax = ->
  token = $('meta[name="csrf-token"]').attr('content')
  $.ajaxSetup
    beforeSend: (xhr) ->
      xhr.setRequestHeader('X-CSRF-Token', token)###

$(()->
  pForm = $('#js-comment-form').parsley()
  $.listen('parsley:field:validate', (algo) ->
    #pForm.isValid()
  )

  $('.js-twitter-date').each (inx, rawDate) ->
    $(rawDate).html(moment($(rawDate).html(), 'YYYY-MM-DD HH:mm:ss Z').fromNow())

  comments = new Chupo.Managers.Comments()

  comments.fetch ->
    comments.showCollection()
  , limit: 10

  $("#js-comment-form").on "submit", (evt) ->
    evt.preventDefault()
    $submit = $(@).find(":submit")
    $submit.prop("disabled", true)
    submitLabel = $submit.val()
    $submit.val("Guardando...")

    comments.add "#js-comment-form", (success) ->
      comments.clearErrors()
      if success
        #$("#js-comment-form").trigger('reset')
        $("#comment_content").val('')
      else
        comments.showErrors()
      $submit.val(submitLabel)
      $submit.prop("disabled", false)
)














