@Images = new Meteor.Collection 'images'

Images.attachSchema new SimpleSchema

  image:
    type: String

  port:
    type: Number

