# TODO: Use js templates and make it more backbone style

class App.V.QuestionList extends Backbone.View
  initialize: ->
    @questions = []
    for question in @$(".question")
      @questions.push new App.V.Question(el:question)

  events: ->
    "submit #question-list-notify-form" : "submit"

  load: ($el) ->
    @setElement($el) if $el?
    for question in @questions
      question.on "changed", =>
        @updateCounter()
        @updateSubmit()
      question.load()
    @$counter = $(".question-list-counter")
    @render()
    this

  render: ->
    @updateCounter()
    @updateSubmit()
    this

  updateCounter: ->
    @$counter.find(".answered").html(@totalAnswered())
    @$counter.find(".progress-bar").css("width", "#{@percentAnswered()}%")

  totalAnswered: ->
    @$(".question[data-answered=true]").length

  percentAnswered: ->
    Math.round(100*@totalAnswered()/@questions.length)

  updateSubmit: ->
    $submit = $("#question-list-submit")
    $hint =   $("#question-list-submit-hint")
    if @totalAnswered() == @questions.length
      $submit.removeAttr('disabled')
      $hint.addClass("hidden")
    else
      $submit.prop('disabled', "disabled")
      $hint.removeClass("hidden")

  submit: (e)->
    # No need to override this as of now
    # e.preventDefault()


class App.V.Question extends Backbone.View
  initialize: ->
    @answered = @$el.data("answered") == "true"
  events: ->
    "keyup textarea" : "replyChanged"

  render: ->
    @$("textarea").elastic()

  replyChanged: _.debounce(
      ->
        @updateReply()
      , 800
    )

  updateReply: ->
    $form = @$("form")
    that = @
    $.ajax
      type: $form.attr("method")
      url:  $form.attr("action")
      data: $form.serialize()
      success: (data) ->
        that.answered = data.answered == "true"
        that.updateStatus()

  updateStatus: ->
    @$el.attr("data-answered", @answered)
    @$("h3").toggleClass("text-success", @answered)
    @$(".fa-check-square").toggleClass("hidden", !@answered)
    @$(".fa-square").toggleClass("hidden", @answered)
    @.trigger("changed")

