App.Triggers =
  init: ->
    $("body").on "change", "[rel='auto-submit'] select, [rel='auto-submit'] input", ->
      $(this).closest("form").submit()
