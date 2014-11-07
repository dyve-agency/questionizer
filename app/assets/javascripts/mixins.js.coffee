App.Mixins =
  ## ARGUMENTABLE: ###########################################################################################################################
  # A mixin to specify arguments lists, its defaults value, and errors that should be thrown in case thy are not passed
  # arguments:
  #   * argumentList [object]: typically the options hash passed in the initialize function of a Backbone.View
  #   * specs        [object]: a hash where the keys are the name of the arguments the function can possibly have,
  #     and the value is an [object] with the following valid options
  #         * mandatory  [boolean]: specifies wether an argument has to be present when invoking the function. If expectation is not fullfilled it will throw an error
  #         * default    [any]    : specifies the default value of an argument if it was not present when invoking the function. It will be ignored if mandatory is `true`
  #         * instanceOf [string] : specifies the class that the object has to belong to. If expectation is not fullfilled it will throw an error
  #
  # example:
  #   initialize: (options={}) ->
  #     @_setArguments options,
  #       'showToolbar'  : { mandatory: false, default: true }
  #       'modelAttrName': { mandatory: true , errorMessage: 'You have to specify the name of the attribute you want the text to sync into your model' }
  #       'model'        : { mandatory: true , errorMessage: 'You have to specify a Backbone model', instanceOf: 'Backbone.Model' }
  # This will set the instance variables
  #   @showToolbar to options['showToolbar'] or to true if it was not defined in the options hash
  #   @modelAttrName to options['modelAttrName'] or throw an error if it was not defined
  #   @model to options['model'] if it is an instance of Backbone.Model
  Argumentable:
    _setArguments: (argumentList, specs) ->
      for argName, spec of specs
        if spec.mandatory
          @[argName] = argumentList[argName] || @_argumentError("missing argument '#{argName}' in #{@constructor.name}: #{spec.errorMessage}")
        else
          @[argName] = if argumentList[argName]? then argumentList[argName] else spec.default
        if spec.instanceOf?
          isInstancesOf = switch spec.instanceOf
            when 'String'  then _.isString(@[argName])
            when 'Boolean' then _.isBoolean(@[argName])
            when 'Number'  then _.isNumber(@[argName])
            else @[argName] instanceof eval(spec.instanceOf)
          unless isInstancesOf
            @_argumentError("wrong type for '#{argName}' in #{@constructor.name}: got '#{@[argName].constructor.name}' but '#{spec.instanceOf}' was expected")
    _argumentError: (message) ->
      throw("[ArgumentError] #{message}")

Cocktail.mixins =
  argumentable: App.Mixins.Argumentable


Cocktail.patch(Backbone)
Cocktail.mixin(Backbone.View, 'argumentable')
