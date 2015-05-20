class @Counter
  constructor: (options, value = 0) ->
    @odometer = new Odometer(options)
    @odometer.update(value)
    $('body').on 'click', '.increment-button', () ->
      increment()
    $('body').on 'click', '.decrement-button', () ->
      decrement()
  increment: () ->
      $.get $(this).data('increment-url'), ( data ) ->
        console.log( "Load was performed." )
      , "script"
  decrement: () ->
      $.get $(this).data('decrement-url'), ( data ) ->
        console.log( "Load was performed." )
      , "script"