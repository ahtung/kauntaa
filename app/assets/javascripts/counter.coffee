class @Counter
  constructor: (id, options, value = 0) ->
    # Vars
    @elem = $("*[data-counter-id='#{id}']")
    _this = @

    # Odometer
    # od = new Odometer({selector: "*[data-counter-id='#{id}'] .counter-value"})

    # FitText
    # @elem.find(".counter-value").fitText(3, { minFontSize: '30px', maxFontSize: '50px' });
    # @elem.find(".edit-counter").fitText(1.2, { minFontSize: '20px', maxFontSize: '25px' });

    # Events
    d3.select("*[data-counter-id='#{id}']").on('click', () ->
      _this.increment()
    )

    # TODO(dunykirkali) edit

  # Functions
  increment: () ->
    $.get @elem.data('increment-url'), ( data ) ->
      console.log(  )
      # window.navigator.fetchCounters()
      # window.navigator.redraw()
    , "script"
