class @Counter
  constructor: (options, value = 0) ->
    @odometer = new Odometer(options)
    @odometer.update(value)