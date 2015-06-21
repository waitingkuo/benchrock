Router.configure
  layoutTemplate: 'layout'

Router.route '/',
  name: 'index'
  action: ->
    @render 'index'

Router.route '/images',
  action: ->
    @render 'images'

Router.route '/machines',
  action: ->
    @render 'machines'
