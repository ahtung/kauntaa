class @Counter
  constructor: (id, options, value = 0) ->
    # Vars
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
    @addEditWindow()

  addEditWindow: () ->
    _this = @
    $.ajax({
      url: "/users/" + @user_id + "/counters/" + @id + "/edit",
      success: (result) ->
        view = result
        _this.svg.append("foreignObject").html(view)
          .attr("transform", _this.elem.attr("transform"))
          .attr("width", _this.elem.find("rect").attr("width"))
          .attr("height", _this.elem.find("rect").attr("height"))
          .transition(500)
          .attr("transform", "translate(0, 0)")
          .attr("width", $(window).width())
          .attr("height", $(window).height())
        setTimeout(500, () ->
          _this.svg.selectAll(".add-counter").remove()
          _this.svg.selectAll(".counter").remove()
        )
    })

  removeEditWindow: () ->
    console.log("TODO")

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
