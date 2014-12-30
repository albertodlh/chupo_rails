class Chupo.Managers.Comments extends SimPL.Manager
  endpoint: '/api/comments/?limit=10'
  template: 'comments'

  validate: (item) ->
    @errors = []
    ret = false
    if item.email == 'albertodlh@gmail.com'
      @errors.push 'There was an error with the email'
    super item, @errors


