class @Counter
  constructor: (id, options, value = 0) ->
    # Vars
    @elem = $("*[data-counter-id='#{id}']")
    _this = @

    # Odometer
    # TODO
    
    # FitText
    @elem.find(".counter-value").fitText(3, { minFontSize: '30px', maxFontSize: '50px' });
    @elem.find(".edit-counter").fitText(1.2, { minFontSize: '20px', maxFontSize: '25px' });

    # Events
    @elem.on 'click', () ->
      _this.increment()

  # Functions
  increment: () ->
    $.get @elem.data('increment-url'), ( data ) ->
      console.log( "Incremented." )
    , "script"
