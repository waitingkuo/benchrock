@Wrks = new Meteor.Collection 'wrks'

Wrks.attachSchema new SimpleSchema

  images:
    type: [String]

  machines:
    type: [String]

@WrkResults = new Meteor.Collection 'wrkResults'

WrkResults.attachSchema new SimpleSchema

  wrkId:
    type: [String]

  image:
    type: [String]

  machine:
    type: [String]

  latency:
    type: [String]

  req:
    type: [String]
  
