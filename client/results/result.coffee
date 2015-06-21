Meteor.startup ->

  Template.result.onRendered ->

    @autorun =>
      results = @data.results.fetch()
      draw(results)
