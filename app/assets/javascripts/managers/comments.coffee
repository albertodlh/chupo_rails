class Chupo.Managers.Comments extends SimPL.Manager
  endpoint: '/api/comments/'
  itemTemplate: 'comment'
  collectionItemTemplate: 'comment_collection'
  collectionEmptyTemplate: 'comment_collection_empty'
  collectionContainer: '#js-comments'
  errorContainer: '#js-comment-errors'
  onAdd: 'prepend'

  validate: (item) ->
    if item.email is 'albertodlh@gmail.com'
      @addError "Ese no es realmente tu email, ¿verdad? -.-"
    super item

  afterFetch: (collection) ->
    #for item in collection
    #  item.user = ':: ' + item.user

  beforeShow: (item) ->
    #item.user += ' ::'

  beforeAppend: ($el) ->
    $el.hide()

  afterAppend: ($el) ->
    $el.slideDown(100)

  beforeSave: (item) ->
    if item.website isnt '' and not item.website.includes(/^https?:\/\//)
      item.website = 'http://' + item.website


