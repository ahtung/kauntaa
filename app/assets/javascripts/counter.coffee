class @Counter
  constructor: (id, nav) ->
    # Vars
    @id = id
    @nav = nav
    @elem = $("*[data-counter-id='#{id}']")
    @counter = d3.selectAll(@elem.toArray())

    @fetchView()

  # Functions
  fetchView: () ->
    _this = @
    $.ajax
      url: "/counters/#{@id}"
      success: (data) ->
        _this.counter.html(data)
        _this.elem.find('.edit-counter-link')
          # .on("mousedown", () -> d3.event.stopPropagation())
          # .on("mouseup", () ->
          #   d3.event.preventDefault();
          # )
          .on('click', (e) ->
            e.stopPropagation()
            e.preventDefault()
            _this.nav.setMode("edit")
            _this.edit()
          )

        _this.counter.select('.increment-button').on('click', () ->
          _this.increment()
        )

        # Odometer
        # od = new Odometer({selector: "*[data-counter-id='#{id}'] .number h2"})

        # FitText
        # _this.elem.find(".number h2").fitText(0.1, { minFontSize: '20px', maxFontSize: '80px' });
        # @elem.find(".edit-counter").fitText(1.2, { minFontSize: '20px', maxFontSize: '25px' });

  edit: () ->
    _this = @
    $.ajax({
      url: "/counters/" + @id + "/edit",
      success: (result) ->
        view = result
        $(".edit-counter").html(view)
        $('.edit-counter').on 'ajax:success', () ->
          _this.nav.setMode("index")

        $('#chart').on 'ajax:error', (a,b) ->
          $("#error_explanation").text(b.responseText)

        $('.back-button').on 'click', (e) ->
          console.log("as")
          _this.nav.setMode("index")
          e.preventDefault()
    })


  increment: () ->
    _this = @
    $.getJSON @elem.find(".increment-button").data('increment-url'), ( data ) ->
      _this.elem.find(".number h2").html(data.value)
    , "script"
