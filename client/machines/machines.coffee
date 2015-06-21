Meteor.startup ->

  Template.machines.helpers

    machines: -> Machines.find()
