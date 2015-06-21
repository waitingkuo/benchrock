Meteor.startup ->

  Template.index.helpers
    wrks: -> 
      index = 1
      Wrks.find().map( (e) -> 
        e.index= index
        index += 1
        return e
      ).reverse()

  Template.index.events

    'click #view-benchmark': ->
      Router.go 'result', _id: @_id

