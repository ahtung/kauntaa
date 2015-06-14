class @Counter
  constructor: (id, options, value = 0) ->
    # Vars
    @elem = $("[data-counter-id=#{id}]")
    _this = @
    
    # FitText
    # @elem.find(".counter-value").fitText(0.3);
    # @elem.find(".edit-counter").fitText(1);

    # Events
    @elem.on 'click', () ->
      _this.increment()
    # $('body').on 'click', '.decrement-button', () ->
    #   decrement()

  # Functions
  increment: () ->
      console.log('increment')
      $.get $(this).data('increment-url'), ( data ) ->
        console.log( "Incremented." )
      , "script"
