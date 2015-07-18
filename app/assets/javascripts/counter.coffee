class @Counter
  constructor: (id, nav, i) ->
    # Vars
    @id = id
    @index = i
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
        _this.addEvents()

  position: ()->
    {
      x: ((@index + 1) % @nav.colCount()) * @nav.colWidth(),
      y: parseInt((@index + 1) / @nav.colCount()) * @nav.colHeight()
    }

  addEvents: () ->
    _this = @
    # edit
    @elem.find('.edit-counter-link')
      .on 'click', (e) ->
        _this.nav.setMode("edit", _this.position())
        _this.edit()
        e.stopPropagation()
        e.preventDefault()
    # increment
    @counter
      .select('.increment-button')
      .on 'click', () ->
        _this.increment()
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
        editView = $(".edit-counter")
        d3EditView = d3.selectAll(editView.toArray())
        d3EditView
          .transition()
          .duration(_this.nav.duration)
          .ease('elastic')
          .style("top", 0)
          .style("left", 0)
          .style("width", () -> "#{window.innerWidth}px")
          .style("height", () -> "#{window.innerHeight}px")

        $('.edit-counter').on 'ajax:success', () ->
          _this.nav.setMode("index")

        $('#chart').on 'ajax:error', (a,b) ->
          $("#error_explanation").text(b.responseText)

        $('.back-button').on 'click', (e) ->
          _this.nav.setMode("index")
          d3EditView
            .transition()
            .duration(_this.nav.duration)
            .ease('elastic')
            .style("left", () -> "#{_this.position().x}px")
            .style("top", () -> "#{_this.position().y}px")
            .style("width", () -> "#{_this.nav.colWidth()}px")
            .style("height", () -> "#{_this.nav.colHeight()}px")
            .each("end", () -> d3EditView.remove())
          e.preventDefault()
    })


  increment: () ->
    _this = @
    $.getJSON @elem.find(".increment-button").data('increment-url'), ( data ) ->
      _this.elem.find(".number h2").html(data.value)
    , "script"
