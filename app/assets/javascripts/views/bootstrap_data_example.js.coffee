class App.V.BoostrapDataExample extends Backbone.View
  template: ->
    JST['bootstrap_data_example/bootstrap_data_example'](@data)
  initialize: ->
    if data = App.bootstrapData('bootstrap-example-from-backend')
      @data = data
    else
      @data = {
        title:   "BootstrapData is not working! :-("
        content: "No boostrap example was provided from the backend"
      }
    this
