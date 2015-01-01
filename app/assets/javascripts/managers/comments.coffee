class Chupo.Managers.Comments extends SimPL.Manager
  endpoint: '/api/comments/'
  itemTemplate: 'comment'
  collectionItemTemplate: 'collection_comment'
  collectionContainer: '#js-comments'
  errorContainer: '#js-comment-errors'
  onAdd: 'prepend'

  validate: (item) ->
    #if item.email is 'albertodlh@gmail.com'
    #  @addError "That's not really your email address, is it? -.-"
    super item

  afterFetch: (collection) ->
    #for item in collection
    #  item.user = ':: ' + item.user

  beforeShow: (item) ->
    item.user += ' ::'

  beforeAppend: (el) ->
    #console.log $(el)


  afterAppend: (el) ->
    inx = $('.comment').length
    console.log 'ahi va'
    console.log $($('.comment')[inx-1])
    console.log $($(el)[0])
    #console.log $(el).slideDown('fast')
    #$($(el)[0]).show()
    #console.log $($(el)[0])
    #$('.comment').slideDown()


  beforeSave: (item) ->
    if item.website isnt '' and not item.website.includes(/^https?:\/\//)
      item.website = 'http://' + item.website


