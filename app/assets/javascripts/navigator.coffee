class @Navigator
  #
  # Constructor
  #
  constructor: () ->
    # Vars
    @duration = 300
    @counter_data = []
    @svg = d3.select("#chart").append("svg").attr("class", 'svg')
    @user_id = $('#chart').data('user-id')
    _this = @


    # Events
    d3.select(window).on('resize', () ->
      _this.updateWindow(_this)
    )

    $('#chart').on 'click', '.edit-counter', (event) ->
      _this.edit(@)
      _this.redraw()
      event.stopPropagation()
      event.preventDefault()

    @appendAdd()
    @fetchCounters()

  fetchCounters: () ->
    _this = @
    d3.json("api/v1/users/#{@user_id}/counters.json", (resp) ->
      console.log resp
      _this.counter_data = resp
      _this.redraw()
    )

  #
  # Append 'Add' button
  #
  appendAdd: () ->
    add_counter = @svg.append("g").attr('class', 'add-counter')
    # counter.each(moveToFront)
    add_counter.insert("rect")
      .attr("fill", 'red')
    add_counter.append('text')
      .text( 'Add' )
      .attr("x", 40)
      .attr("y", 40)
      .attr("font-family", "sans-serif")
      .attr("font-size", "40px")
      .attr("fill", 'blue')
    add_counter.append('text')
      .text( "Sign out" )
      .attr("x", 40)
      .attr("y", 80)
      .attr("font-family", "sans-serif")
      .attr("font-size", "20px")
      .attr("fill", 'green')

  #
  # Update window
  #
  updateWindow: (diz) ->
    x = window.innerWidth || e.clientWidth || g.clientWidth
    y = window.innerHeight|| e.clientHeight|| g.clientHeight
    # diz.svg.attr("width", x).attr("height", y)
    diz.redraw()

  #
  # Redraws counters
  #
  redraw: () ->
    _this = @
    # console.log('redraw')
    @counters = @svg.selectAll(".counter").data(@counter_data)
    counter = @counters.enter().append("g").attr('class', 'counter')
    # counter.each(moveToFront)
    counter.insert("rect")
      .attr("fill", (d) -> d.palette.background_color)
    counter.append('text')
      .text( (d) -> d.value )
      .attr("x", 40)
      .attr("y", 40)
      .attr("font-family", "sans-serif")
      .attr("font-size", "40px")
      .attr("fill", (d) -> d.palette.foreground_color)
    counter.append('text')
      .text( (d) -> "#{d.name} since #{'TODO'}" )
      .attr("x", 40)
      .attr("y", 80)
      .attr("class", "edit-counter")
      .attr("font-family", "sans-serif")
      .attr("font-size", "20px")
      .attr("fill", (d) -> d.palette.text_color)

    @svg.selectAll(".add-counter").select('.html').transition()
      .duration(@duration)
      .ease('elastic')
      .attr("width", (d) ->
        if _this.counter_data.length > 1
          (window.innerWidth / 4)
        else
          window.innerWidth
      )
      .attr("height", (d) ->
        if _this.counter_data.length > 1
          (window.innerHeight / 4)
        else
          window.innerHeight
      )
    @counters.transition()
      .duration(@duration)
      .ease('elastic')
      .attr("transform", (d, i) ->
        if _this.counter_data.length > 1
          "translate(#{((i + 1) % 4) * (window.innerWidth / 4)}, #{parseInt((i + 1) / 4) * (window.innerHeight / 4)})"
        else
          "translate(0, 0)"
      )
    @counters.select('rect').transition()
      .duration(@duration)
      .ease('elastic')
      .attr("width", (d) ->
        if _this.counter_data.length > 1
          (window.innerWidth / 4)
        else
          window.innerWidth
      )
      .attr("height", (d) ->
        if _this.counter_data.length > 1
          (window.innerHeight / 4)
        else
          window.innerHeight
      )

    @svg.select(".add-counter").select('foreignobject').attr("width", (d) -> window.innerWidth / 4).attr("height", (d) -> window.innerHeight / 4)

    @counters.exit().transition()
        .duration(@duration)
        .attr("transfor", "translate(0, 0)")
        .remove()

  #
  # Edit counter
  #
  edit: (counter) ->
    counter = $(counter).closest('.counter')[0]
    @counter_data = [@counter_data[3]]
    @redraw()


