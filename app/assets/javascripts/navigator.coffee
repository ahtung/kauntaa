class @Navigator
  #
  # Constructor
  #
  constructor: () ->
    # Vars
    @duration = 500
    @elem = $('#navigator')
    @navigator = d3.select("#navigator")
    @user_id = @elem.data('user-id')
    @palette_id = @elem.data('new-palette-id')
    @mode = "index"
    @position = { x:0, y:0 }
    @count = 0

    if @user_id
      @appendHeader()
      @appendCounters()

    # Events
    _this = @
    d3.select(window).on('resize', () ->
      _this.resize()
    )

  #
  #
  #
  setMode: (mode, position) ->
    if position
      @position = position
    if mode == "edit"
      @removeCounters()
      @removeHeader()
      @appendEdit()
    else if mode == "add"
      @removeCounters()
      @removeHeader()
      @appendAdd()
    else if mode == "index"
      @removeAdd()
      @appendHeader()
      @appendCounters()

    @mode = mode
    # @resize()
  #
  #
  #
  colCount: () ->
    row = Math.floor(Math.sqrt(@count))
    col = row
    (if row == col then row++ else col++) while (row * col) < @count
    col

  #
  #
  #
  rowCount: () ->
    row = Math.floor(Math.sqrt(@count))
    col = row
    (if row == col then row++ else col++) while (row * col) < @count
    row

  #
  # Col width
  #
  colWidth: () ->
    parseInt(window.innerWidth / @colCount())


  #
  # Col heigth
  #
  colHeight: () ->
    parseInt(window.innerHeight / @rowCount())

  #
  #
  #
  removeHeader: () ->
    @navigator.select(".new-counter").remove()

  #
  #
  #
  appendHeader: () ->
    _this = @
    @navigator.append("div")
      .attr("class", "new-counter")
      .style("width", () -> _this.colWidth())
      .style("height", () -> _this.colHeight())
    _this = @
    $.ajax({
      url: "/counters/add?palette_id=#{_this.palette_id}",
      success: (result) ->
        view = result
        $(".new-counter").html(view)

        $('.add-counter-link').on 'click', (e) ->
          _this.setMode("add")
          e.preventDefault()
    })

  #
  # Append '.add-counter' div
  #
  appendAdd: () ->
    @navigator.append("div").attr("class", "add-counter")
    _this = @
    $.ajax({
      url: "/counters/new?palette_id=#{_this.palette_id}"
      success: (result) ->
        view = result
        $(".add-counter").html(view)
        $('.add-counter').on 'ajax:success', () ->
          _this.setMode("index")

        @elem.on 'ajax:error', (a,b) ->
          $("#error_explanation").text(b.responseText)

        $('.back-button').on 'click', (e) ->
          _this.setMode("index")
          e.preventDefault()
    })

  removeAdd: () ->
    @navigator.select(".add-counter").remove()

  #
  # Append '.counters' div
  #
  appendCounters: () ->
    counters = @navigator.append("div").attr("class", "counters")
    _this = @
    if @user_id
      d3.json("api/v1/me/counters.json", (resp) ->
        _this.count = resp.length + 1
        counters.selectAll(".counter")
          .data(resp)
          .enter()
          .append("div")
          .attr("class", "counter")
          .attr("data-counter-id", (d) -> d.id)
          .style("background-color", (d) -> d.palette.background_color)
          .style("top", () -> _this.position.y)
          .style("left", () -> _this.position.x)
          .style("width", () -> _this.colWidth())
          .style("height", () -> _this.colHeight())
          .each((d,i) -> new Counter(d.id, _this, i,d.value))
        _this.resize()
      )

  #
  # Remove '.counters' div
  #
  removeCounters: () ->
    _this = @
    d3.selectAll(".counter")
      .data([])
      .exit()
      .transition()
      .duration(@duration)
      .ease('elastic')
      .style("top", 0)
      .style("left", 0)
      .style("width", () -> _this.colWidth())
      .style("height", () -> _this.colHeight())
      .remove()
    d3.select(".counters").remove()

  #
  # Append '.edit-counter' div
  #
  appendEdit: () ->
    _this = @
    @navigator.append("div")
      .attr("class", "edit-counter")
      .style("top", @position.x)
      .style("left", @position.y)
      .style("width", () -> _this.colWidth())
      .style("height", () -> _this.colHeight())

  #
  # Resize
  #
  windowWidth: () ->
    window.innerWidth

  windowHeight: () ->
    window.innerHeight

  resize: () ->
    _this = @
    if @windowWidth() < 640
      @resizeForSmall()
    else
      @resizeForNotSmall()

  resizeForSmall: () ->
    if(@mode != "index")
      d3.select(".#{@mode}-counter")
        .transition()
        .duration(@duration)
        .ease('elastic')
        .attr("width", "#{@windowWidth()}px")
        .attr("height", "#{@windowHeight()}px")
    else
      _this = @
      d3.select(".new-counter")
        .transition()
        .duration(@duration)
        .ease('elastic')
        .attr("style", (d, i) -> "width:100%;height:50%;top:0px;left:0px;")
      d3.selectAll(".counter")
        .transition()
        .duration(@duration)
        .ease('elastic')
        .attr("style", (d, i) -> "width:100%;height:50%;top:#{(i + 1) * _this.windowHeight() / 2}px;left:0px;background-color:#{d.palette.background_color}")

  resizeForNotSmall: () ->
    if(@mode != "index")
      d3.select(".#{@mode}-counter")
        .attr("width", "#{@windowWidth()}px")
        .attr("height", "#{@windowHeight()}px")
    else
      _this = @
      d3.select(".new-counter")
        .transition()
        .duration(@duration)
        .ease('elastic')
        .attr("style", (d, i) -> "width:#{_this.colWidth()}px;height:#{_this.colHeight()}px;top:0px;left:0;")
      d3.selectAll(".counter")
        .transition()
        .duration(@duration)
        .ease('elastic')
        .attr("style", (d, i) -> "width:#{_this.colWidth()}px;height:#{_this.colHeight()}px;top:#{parseInt((i + 1) / _this.colCount()) * _this.colHeight()}px;left:#{((i + 1) % _this.colCount()) * _this.colWidth()}px;background-color:#{d.palette.background_color}")
