@Machines = new Meteor.Collection 'machines'

Machines.attachSchema new SimpleSchema

  machine:
    type: String
    label: 'Machine'

  


