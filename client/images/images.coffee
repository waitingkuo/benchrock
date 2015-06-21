Meteor.startup ->

  Template.images.helpers

    images: -> Images.find()
