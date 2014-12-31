class Chupo.Managers.Comments extends SimPL.Manager
  endpoint: '/api/comments/'
  itemTemplate: 'comment'
  collectionTemplate: 'comments'
  collectionContainer: '#js-comments'
  errorContainer: '#js-comment-errors'

  validate: (item) ->
    if item.email is 'albertodlh@gmail.com'
      @addError "That's not really your email address, is it? -.-"
    super item

  beforeSave: (item) ->
    item.website = 'http://hotmail.com'


