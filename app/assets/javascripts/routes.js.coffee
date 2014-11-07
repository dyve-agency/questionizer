App.routes =
  parametrize: (params) ->
    params = _.compactObject(params)
    if params?
      "?" + $.param(params)
    else
      ""
  # Example
  # clipboard:
  #   path: -> "/clipboard"
  #   copy_inside: (entry_id, target_id)->
  #     params = {id:entry_id, target_id: target_id}
  #     "entries/copy_inside" + App.routes.parametrize(params)
