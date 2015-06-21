Router.configure
  layoutTemplate: 'layout'

Router.route '/',
  name: 'index'
  action: ->
    @render 'index'

Router.route '/new',
  name: 'new'
  action: ->
    @render 'new'

Router.route '/results/:_id',
  name: 'result'
  action: ->
    wrkId = @params._id
    wrkResults = WrkResults.find wrkId: wrkId
    @render 'result', 
      data:
        results: wrkResults

Router.route '/images',
  action: ->
    @render 'images'

Router.route '/machines',
  action: ->
    @render 'machines'
