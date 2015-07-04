class @Navigator
  #
  # Constructor
  #
  constructor: () ->
    # console.log('constructor')
    # Vars
    @mode = 'index'
    @duration = 500
    @counter_data = []
    @svg = d3.select("#chart").append("svg").attr("class", 'svg')
    @user_id = $('#chart').data('user-id')
    _this = @

    # Events
    d3.select(window).on('resize', () ->
      _this.updateWindow(_this)
    )

    $('#chart').on 'click', '.add-text', () ->
      _this.openAddWindow()

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
      _this.counter_data = resp
      _this.redraw()
    )

  #
  # Back
  #
  back: () ->
    @mode = 'index'
    @selectedCounter = null

  #
  # Col width
  #
  colWidth: (counter) ->
    if @mode == 'index'
      (window.innerWidth / @cols())
    else
      if @mode == 'edit' && @selectedCounter == counter
        window.innerWidth
      else
        0

  #
  # Col heigth
  #
  colHeight: (counter) ->
    if @mode == 'index'
      (window.innerHeight / @cols())
    else
      if @mode == 'edit' && @selectedCounter == counter
        window.innerHeight
      else
        0

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
  # Remove 'Add'
  #
  removeAdd: () ->
    # console.log('asd')
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
    return if @counter_data.length == 0
    @counters = @svg.selectAll(".counter").data(@counter_data)
    counter = @counters.enter().append("g").attr('class', 'counter odometer').attr('data-counter-id', (d) -> d.id).attr('data-increment-url', (d) -> d.increment_url).each((d) -> new Counter(d.id))
    # counter.each(moveToFront)
    counter.append("rect")
      .attr("fill", (d) -> d.palette.background_color)
      .attr("width", (d) -> _this.colWidth(d))
      .attr("height", (d) -> _this.colHeight(d))
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

    @counters.transition()
      .duration(@duration)
      .ease('elastic')
      .attr("transform", (d, i) ->
        if _this.mode == 'index'
          "translate(#{((i + 1) % _this.cols()) * (window.innerWidth / _this.cols())}, #{parseInt((i + 1) / _this.cols()) * (window.innerHeight / _this.cols())})"
        else
          "translate(0, 0)"
      )
      .select('rect')
        .ease('elastic')
        .attr("width", (d) -> _this.colWidth(d))
        .attr("height", (d) -> _this.colHeight(d))

    @counters.select('.counter-value').transition()
      .duration(@duration)
      .ease('elastic')
      .attr("x", (d) -> _this.colWidth(d) / 2)
      .attr("y", (d) -> _this.colHeight(d) / 4)

    @counters.select('.edit-counter').transition()
      .duration(@duration)
      .ease('elastic')
      .attr("x", (d) -> _this.colWidth(d) / 2)
      .attr("y", (d) -> _this.colHeight(d) / 4 * 3)

    @svg.selectAll(".add-counter").select('.add-text').transition()
      .duration(@duration)
      .ease('elastic')
      .attr("x", (d) -> _this.colWidth(d) / 2)
      .attr("y", (d) -> _this.colHeight(d) / 4)

    @svg.selectAll(".add-counter").select(".sign-out").transition()
      .duration(@duration)
      .ease('elastic')
      .attr("x", (d) -> _this.colWidth(d) / 2)
      .attr("y", (d) -> _this.colHeight(d) / 4 * 3)

    @counters.exit().transition()
        .duration(@duration)
        .attr("transform", "translate(#{window.innerWidth / 2}, #{window.innerHeight / 2})")
        .remove()

  #
  # Edit counter
  #
  edit: (counter) ->
    @mode = 'edit'
    counter = $(counter).closest('.counter')[0]
    id = $(counter).data('counter-id')
    @selectedCounter = null
    for counter_data in @counter_data
      if counter_data.id == id
        @selectedCounter = counter_data
        break
    # @counter_data = [@selectedCounter]
    @redraw()

  #
  # Open add window
  #
  openAddWindow: () ->
    palette_id = $('#chart').data('new-palette-id')
    window.location.assign("/users/#{@user_id}/counters/new?palette_id=#{palette_id}")
