class @Counter
  constructor: (elem, options, value = 0) ->
    # Vars
    @elem = elem
    
    # FitText
    @elem.find(".counter-value").fitText(0.3);
    @elem.find(".edit-counter").fitText(1);

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
