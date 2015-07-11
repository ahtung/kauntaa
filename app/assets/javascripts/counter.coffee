class @Counter
  constructor: (id, nav, value = 0) ->
    # Vars
    @nav = nav
    @id = id
    @svg = d3.select("#chart").select(".svg")
    @elem = $("*[data-counter-id='#{id}']")
    _this = @
    @counter = d3.selectAll(@elem.toArray())

    # Odometer
    # od = new Odometer({selector: "*[data-counter-id='#{id}'] .counter-value"})

    # FitText
    # @elem.find(".counter-value").fitText(3, { minFontSize: '30px', maxFontSize: '50px' });
    # @elem.find(".edit-counter").fitText(1.2, { minFontSize: '20px', maxFontSize: '25px' });

    # Events
    @counter.select('.edit-counter').on('click', () ->
      _this.edit()
    )

    @counter.select('rect').on('click', () ->
      _this.increment()
    )

  # Functions
  edit: () ->
    console.log("edit")
    x = window.innerWidth || e.clientWidth || g.clientWidth
    y = window.innerHeight|| e.clientHeight|| g.clientHeight
    @svg.attr("width", x).attr("height", y)
    @addEditWindow()

  addEditWindow: () ->
    _this = @
    $.ajax({
      url: "/users/" + @user_id + "/counters/" + @id + "/edit",
      success: (result) ->
        view = result
        _this.svg.append("foreignObject").attr("id", "html").html(view)
          .attr("transform", _this.elem.attr("transform"))
          .attr("width", _this.elem.find("rect").attr("width"))
          .attr("height", _this.elem.find("rect").attr("height"))
          .transition(300)
          .attr("transform", "translate(0, 0)")
          .attr("width", $(window).width())
          .attr("height", $(window).height())
        $('#chart').on 'ajax:success', () ->
          _this.removeEditWindow()

        $('#chart').on 'ajax:error', () ->
          console.log('error')

        $('#chart').on 'click', '.back-button', (e) ->
          _this.removeEditWindow()
          e.preventDefault()

        setTimeout(() ->
          _this.svg.selectAll(".add-counter").remove()
          _this.svg.selectAll(".counter").remove()
        , _this)
    })

  removeEditWindow: () ->
    @svg.select("#html")
      .transition(300)
      .attr("transform", "translate(#{@elem.find("rect").attr("width")}, 0)")
      .attr("style", "width:#{@elem.find("rect").attr("width")};height:#{@elem.find("rect").attr("height")}")
    @nav.appendAdd()
    @nav.fetchCounters()
    setTimeout () ->
      $("foreignObject").remove()
    , 300

  increment: () ->
    $.getJSON @elem.data('increment-url'), ( data ) ->
      d3.select("[data-counter-id='" + data.id + "'] .counter-value")
      .text(data.value)
      .transition()
        .duration(200)
        .style('font-size', '50px')
        .attr('transform', "rotate(0 90 0)")
      .transition()
        .duration(200)
        .style('font-size', '2.5em')
        .attr('transform', "rotate(0 0 0)")
    , "script"
