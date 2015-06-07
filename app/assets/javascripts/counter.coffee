class @Counter
  constructor: (options, value = 0) ->
    # Odometer
    @odometer = new Odometer(options)
    @odometer.update(value)

    # FitText
    $(".counter #count").fitText(0.3);
    $(".counter .description, .new-counter .description").fitText(1);

    # Events
    # $('#chart').on 'click', '.increment-button', () ->
    #   increment()
    # $('body').on 'click', '.decrement-button', () ->
    #   decrement()

  # Functions
  increment: () ->
      $.get $(this).data('increment-url'), ( data ) ->
        console.log( "Incremented." )
      , "script"
