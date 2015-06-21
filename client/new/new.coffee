Meteor.startup ->

  Template.new.helpers

    images: -> Images.find()
    machines: -> Machines.find()

  Template.new.events

    'click #run': (e) ->

      e.preventDefault()


      images = $('#images-selector option:checked').map( -> $(@).val()).toArray()
      machines = $('#machines-selector option:checked').map( -> $(@).val()).toArray()
      options = $('#options').val()
      Meteor.call 'wrkInit', images, machines, options, (err, result) ->
        if not err?
          console.log result
          if 'wrkId' of result
            wrkId = result.wrkId
            Meteor.call 'wrkRun', wrkId
            Router.go 'result', {_id: wrkId}

  Template.new.onRendered ->

    #if Images.find().count() > 0
    
    @autorun ->
      if Images.find().count() > 0
        $('#images-selector').multiselect('refresh')

    @autorun ->
      if Machines.find().count() > 0
        $('#machines-selector').multiselect('refresh')


