class @Counter
  constructor: (options) ->
    @odometer = new Odometer(options)
    @odometer.render()
