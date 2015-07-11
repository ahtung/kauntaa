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
    @row_and_col = []
    @svg = d3.select("#chart").append("svg").attr("class", 'svg')
    @user_id = $('#chart').data('user-id')
    _this = @

    # Events
    d3.select(window).on('resize', () ->
      _this.updateWindow()
    )

    @appendAdd()
    @appendAddWindow()
    @fetchCounters()

  # Returns the number of rows and columns given N
  rowCol: (n) ->
    row = Math.floor(Math.sqrt(n))
    col = row
    (if row == col then row++ else col++) while (row * col) < n
    @row_and_col = [row, col]


  fetchCounters: () ->
    _this = @
    if @user_id
      d3.json("api/v1/users/#{@user_id}/counters.json", (resp) ->
        _this.counter_data = resp
        _this.rowCol(_this.counter_data.length + 1)
        _this.updateWindow()
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
      if window.innerWidth < 640
        window.innerWidth
      else
        (window.innerWidth / @row_and_col[1])
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
      if window.innerWidth < 640
        window.innerHeight / 2
      else
        (window.innerHeight / @row_and_col[0])
    else
      if @mode == 'edit' && @selectedCounter == counter
        window.innerHeight
      else
        0

  #
  # Remove 'Add'
  #
  removeAdd: () ->
    d3.select('.add-counter').remove()
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
      .attr("class", 'add-text')
      .attr("fill", 'blue')
      .attr("font-size", "2.5em")
      .on 'click', () ->
        _this.openAddWindow()
    add_counter.append('text')
      .text( "Sign out" )
      .attr("class", 'sign-out')
      .attr("font-size", "1.3em")
      .attr("fill", 'green')
      .on 'click', () ->
        window.location = '/users/sign_out'

  #
  # Append Add Window
  #
  appendAddWindow: () ->
    _this = @
    palette_id = $('#chart').data('new-palette-id')
    $.ajax
      url: "/users/#{@user_id}/counters/new?palette_id=#{palette_id}"
      success: (data) ->
        _this.svg.append('foreignObject')
        .attr({
          'x': 0,
          'y': 0,
          'width': 0,
          'height': 0,
          'id': 'add_form_window'
        })
        .append('xhtml:html')
        .append('xhtml:body')
        .append('xhtml:div')
        .html(data)
        .attr({
          'style': 'display:none;'
        })


  #
  # Update window
  #
  updateWindow: () ->
    _this = @
    x = window.innerWidth || e.clientWidth || g.clientWidth
    y = window.innerHeight|| e.clientHeight|| g.clientHeight
    if x < 640
      @svg.attr("width", x).attr("height", (d) -> (_this.counter_data.length + 1) * _this.colHeight(d))
    else
      @svg.attr("width", x).attr("height", y)
    @redraw()

  #
  # Redraws counters
  #
  redraw: () ->
    _this = @
    @counters = @svg.selectAll(".counter").data(@counter_data)
    counter = @counters.enter().append("g").attr('class', 'counter odometer').attr('data-counter-id', (d) -> d.id).attr('data-increment-url', (d) -> d.increment_url)
    counter.append("rect")
      .attr("fill", (d) -> d.palette.background_color)
      .attr("width", (d) -> _this.colWidth(d))
      .attr("height", (d) -> _this.colHeight(d))
    counter.append('text')
      .text( (d) -> d.value )
      .attr('class', 'counter-value')
      .attr("fill", (d) -> d.palette.foreground_color)
    counter.append('text')
      .text( (d) -> "#{d.name} since #{d.active_since}" )
      .attr("class", "edit-counter")
      .attr("fill", (d) -> d.palette.text_color)
    @counters.each((d) -> new Counter(d.id))

    @svg.selectAll(".counter , .add-counter")
      .attr("text-anchor", "middle")
      .attr('alignment-baseline', "middle")
    @counters.transition()
      .duration(@duration)
      .ease('elastic')
      .attr("transform", (d, i) ->
        if _this.mode == 'index'
          if window.innerWidth < 640
            "translate(0, #{parseInt((i + 1) * _this.colHeight(d))})"
          else
            "translate(#{((i + 1) % _this.row_and_col[1]) * _this.colWidth(d)}, #{parseInt((i + 1) / _this.row_and_col[1]) * _this.colHeight(d)})"
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
        .attr("width", 0)
        .attr("height", 0)
        .remove()

  #
  # Edit counter
  #
  # edit: (counter) ->
  #   @mode = 'edit'
  #   counter = $(counter).closest('.counter')[0]
  #   id = $(counter).data('counter-id')
  #   @selectedCounter = null
  #   for counter_data in @counter_data
  #     if counter_data.id == id
  #       @selectedCounter = counter_data
  #       break
  #   # @counter_data = [@selectedCounter]
  #   @redraw()

  #
  # Open add window
  #
  openAddWindow: () ->
    palette_id = $('#chart').data('new-palette-id')
    window.location.assign("/users/#{@user_id}/counters/new?palette_id=#{palette_id}")
      .attr({