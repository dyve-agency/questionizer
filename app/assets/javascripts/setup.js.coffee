window.App = { V:{}, M:{}, C:{}, R:{}, data:{}, mixins:{}, routes:{} }
_.extend(App, Backbone.Events)

if !window.console
  window.console =
    log: ->
    error: ->
    debug: ->
    group: ->
    groupEnd: ->
    warn: ->
    groupCollapsed: ->
    trace: ->
    assert: ->
    count: ->

Backbone.Model = Backbone.Model.extend({
 ajaxTried: 0,
 sync: (method, model, options) ->
   args = arguments
   errorHandler = options.error
   successHandler = options.success
   options.error = (xhr) =>
     if (xhr.status == 0)
       # App.flash_error('There was an unexpected error')
       console.error("There was an unexpected error")
     else if (xhr.status == 500)
       # App.ajax.handle500()
       console.error("There was an unexpected 500 error")
     else
       try
         serverAttrs = JSON.parse(xhr.responseText)
       catch error
         console.error "debug: #{error}"
         serverAttrs = xhr.responseText

       errorHandler.call(@, serverAttrs, xhr)

   # Conventions to trigger a redirect from a backend responde
   # Ex: render :json => {redirect_to: embed_path(entry)}
   options.success=  (xhr)=>
     if xhr? && _.has(xhr, 'redirect_to')
       window.location = xhr['redirect_to']
     else
       successHandler.apply(@, arguments)

   Backbone.sync.apply(this, args)
})

#######################################
# This App way of using Backbone.Views
#
# 1. @intialize is the place to
#     * process the options hash and set the instance variables (possibly using @_setArguments)
#     * instiantiate subViews
#     * listen to events on Backbone objects using @listenTo
# 2. use the @events hash to listen to DOM events
# 3. nobody calls externally to @render
# 4. instead we call @load
# 5. @load receives *most of the times one parameter*, $el, an element that *must already be present on the DOM*
#    the one ocassion when it is OK not to pass a DOM element to @load is when you expect the view to create it itself
#    and you are gonna do something like
#           myView = new MyBackboneView
#           $("...").append(myView.el)
#           myView.load()
#      1. calls to @_unload to ensure idempotence of the @load method.
#         It is every views responsability to implement @_unload. It might be ok to leave the implementation empty
#      2. @setElement($el) if a $el parameter was passed
#      3. renders itself
#      4. calls to @load on every subView
#      5. returns itself
# 6. @remove should call @remove on every subView and then call super
# 7. @reload is a simple way to tell a view to reload itself without the need of changing the @$el.
#    It is specially useful to use it as a callback for an event that should trigger a @load but you are not sure what
#    parameters will the event send, for example
#         @listenTo(@collection, 'remove', @reload)
#
Backbone.View = Backbone.View.extend({
  render: ->
    @$el.html @template()
    this
  load: ($el) ->
    @_unload()
    @setElement($el) if $el?
    @render()
    # this is where you do: @subView.load()
    this
  _unload: ->
  reload: -> @load(@$el)
})


App.getURLParameter = (name) ->
  return decodeURIComponent((new RegExp("[?|&]#{name}=([^&;]+?)(&|##|;|$)").exec(location.search) || [null,""] )[1].replace(/\+/g, '%20'))||null

App.navigate_to = (url) ->
  window.location = url

App.bootstrapData = (name) ->
  $("#bootstrap [data-"+name+"]").data(name)

String.prototype.capitalize = ->
  this.charAt(0).toUpperCase() + this.slice(1)

String.prototype.endsWith = (suffix)->
    this.indexOf(suffix, this.length - suffix.length) != -1

String.prototype.include = (substr)->
    this.indexOf(substr) != -1


$.fn.exists = -> this.length != 0

#http://stackoverflow.com/questions/14058193/remove-empty-properties-falsy-values-from-object-with-underscore-js
# _.compactObject({a:1, b:false, c:null, d:undefined})
# =>  {a: 1, b: false}
_.mixin compactObject: (o) ->
  _.each o, (v, k) ->
    delete o[k]  if v == null || v == undefined
  o
