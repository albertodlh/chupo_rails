Handlebars.registerHelper 'relativeDate', (date)->
  return moment(date).fromNow()

Handlebars.registerHelper 'replaceReturns', (text)->
  return text.replace(/(\r\n|\n|\r)/g,"<br />");