App.i18n =
  init: ->
    i18n.locale = App.bootstrapData('locale')
    i18n.default_locale = 'en'


@i18n =
  locale: null #this value has to be initialized
  default_locale: null #this value has to be initialized
  _template_in_case_of_error: (keys) ->
    lastKey = _.last(keys.split('.'))
    lastKey.split('_').join(' ').capitalize()
  _isNumber: (n) -> !isNaN(parseFloat(n)) && isFinite(n)
  _pluralize: (key, vars={}) ->
    if 'count' of vars and @_isNumber(vars.count)
      if vars.count == 1 then "#{key}.one" else "#{key}.others"
    else
      key

  _multiIndexArr: (obj, path) ->
    if path.length
      @_multiIndexArr(obj?[path[0]],path.slice(1))
    else
      obj
  _multiIndexStr: (obj, path) ->
    @_multiIndexArr obj, path.split('.')
  locate: (locale, path) ->
    @_multiIndexStr(App.i18n[locale], path)

  t: (key, vars = {}) ->
    template_in_case_of_error = @_template_in_case_of_error(key)
    key = @_pluralize(key, vars)
    template = @locate(@locale, key)
    unless _.isString(template)
      template = @locate(@default_locale, key)
      console.log("WARNING i18n: missing translation for [#{@locale}] : '#{key}'")
      console.log("              falling back to default locale [#{@default_locale}]")
    unless _.isString(template)
      template = template_in_case_of_error
      console.log("WARNING i18n: '#{key}' key references something other than a string")
    _.template(template, vars)
