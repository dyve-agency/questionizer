class App.Launcher extends Backbone.View
  initialize: ->
    @bootstraDataExample = new App.V.BoostrapDataExample(el: $("#x-bootstrap-example-from-backend-anchor"))
  _unload: ->
  load: ->
    @_unload()
    App.i18n.init()
    App.Triggers.init()
    @bootstraDataExample.load()
    this

$ ->
  App.launcher = new App.Launcher
  App.launcher.load()

  $(".textarea-wrapper, .textarea-blockquote-style-wrapper").on "click", ->
    $(@).find("textarea").focus()

  questionPreviewUpdater = ->
    $.ajax
      type: "POST"
      url:  "/lists/preview"
      data: {raw_text: $('#questions-raw-text').val()}
      success: (data) ->
        $('#questions-preview').html(data)

  $('#questions-raw-text').elastic().on "keyup", _.debounce(questionPreviewUpdater, 1000)

  if $("#question-list").length
    questionList = new App.V.QuestionList(el:$("#question-list"))
    questionList.load()
