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
  # Col width
  #
  colWidth: () ->
    if @counter_data.length > 1
      (window.innerWidth / @cols())
    else
      window.innerWidth

  #
  # Col heigth
  #
  colHeight: () ->
    if @counter_data.length > 1
      (window.innerHeight / @cols())
    else
      window.innerHeight

  #
  # Calculate cols
  #
  cols: () ->
    if $(window).width() <= 640
      2
    else
      if $(window).width() > 640 && $(window).width() <= 1024
        4
      else
        6

  #
  # Append 'Add' button
  #
  appendAdd: () ->
    _this = @
    add_counter = @svg.append("g").attr('class', 'add-counter')
    # counter.each(moveToFront)
    add_counter.insert("rect")
      .attr("fill", 'red')
    add_counter.append('text')
      .text( 'Add' )
      .attr("text-anchor", "middle")
      .attr('alignment-baseline', "middle")
      .attr("class", 'add-text')
      .attr("fill", 'blue')
      .attr("font-size", "35px")
    add_counter.append('text')
      .text( "Sign out" )
      .attr("text-anchor", "middle")
      .attr('alignment-baseline', "middle")
      .attr("class", 'sign-out')
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
    width = (window.innerWidth / _this.cols())
    height = (window.innerHeight / _this.cols())
    @counters = @svg.selectAll(".counter").data(@counter_data)
    counter = @counters.enter().append("g").attr('class', 'counter').attr('data-counter-id', (d) -> d.id)
    # counter.each(moveToFront)
    counter.insert("rect")
      .attr("fill", (d) -> d.palette.background_color)
    counter.append('text')
      .text( (d) -> d.value )
      .attr("text-anchor", "middle")
      .attr('alignment-baseline', "middle")
      .attr('class', 'counter-value')
      .attr("fill", (d) -> d.palette.foreground_color)
    counter.append('text')
      .text( (d) -> "#{d.name} since #{'TODO'}" )
      .attr("class", "edit-counter")
      .attr("text-anchor", "middle")
      .attr('alignment-baseline', "middle")
      .attr("fill", (d) -> d.palette.text_color)
    @counters.each((d) -> new Counter(d.id))

    @counters.transition()
      .duration(@duration)
      .ease('elastic')
      .attr("transform", (d, i) ->
        if _this.counter_data.length > 1
          "translate(#{((i + 1) % _this.cols()) * (window.innerWidth / _this.cols())}, #{parseInt((i + 1) / _this.cols()) * (window.innerHeight / _this.cols())})"
        else
          "translate(0, 0)"
      )
    @counters.select('rect').transition()
      .duration(@duration)
      .ease('elastic')
      .attr("width", @colWidth())
      .attr("height", @colHeight())

    @counters.select('.counter-value').transition()
      .duration(@duration)
      .ease('elastic')
      .attr("x", @colWidth() / 2)
      .attr("y", @colHeight() / 4)

    @counters.select('.edit-counter').transition()
      .duration(@duration)
      .ease('elastic')
      .attr("x", @colWidth() / 2)
      .attr("y", @colHeight() / 4 * 3)


    @svg.selectAll(".add-counter").select('.add-text').transition()
      .duration(@duration)
      .ease('elastic')
      .attr("x", @colWidth() / 2)
      .attr("y", @colHeight() / 4)

    @svg.selectAll(".add-counter").select(".sign-out").transition()
      .duration(@duration)
      .ease('elastic')
      .attr("x", @colWidth() / 2)
      .attr("y", @colHeight() / 4 * 3)

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


