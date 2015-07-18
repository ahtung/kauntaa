class @Navigator
  #
  # Constructor
  #
  constructor: () ->
    # Vars
    @duration = 500
    @chart = d3.select("#chart")
    @user_id = $('#chart').data('user-id')
    @mode = "index"

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
  setMode: (mode) ->
    if mode == "edit"
      @removeCounters()
      @removeHeader()
      @appendEdit()
    else if mode == "index"
      @removeEdit()
      @appendHeader()
      @appendCounters()

    @mode = mode
    @resize()
  #
  #
  #
  colCount: () ->
    n=10
    row = Math.floor(Math.sqrt(n))
    col = row
    (if row == col then row++ else col++) while (row * col) < n
    col

  #
  #
  #
  rowCount: () ->
    n=10
    row = Math.floor(Math.sqrt(n))
    col = row
    (if row == col then row++ else col++) while (row * col) < n
    row

  #
  # Col width
  #
  colWidth: () ->
    if @windowWidth() < 640
      window.innerWidth
    else
      parseInt(window.innerWidth / @colCount())


  #
  # Col heigth
  #
  colHeight: () ->
    if @windowWidth() < 640
      window.innerHeight / 2
    else
      parseInt(window.innerHeight / @rowCount())

  #
  #
  #
  removeHeader: () ->
    @chart.select(".new-counter").remove()


  #
  #
  #
  appendHeader: () ->
    palette_id = $('#chart').data('new-palette-id')
    @chart.append("div").attr("class", "new-counter")
    $.ajax({
      url: "/counters/add?palette_id=#{palette_id}",
      success: (result) ->
        view = result
        $(".new-counter").html(view)
    })

  #
  # Append '.add-counter' div
  #
  appendAdd: () ->
    @chart.append("div").attr("class", "add-counter")

  #
  # Append '.counters' div
  #
  appendCounters: () ->
    counters = @chart.append("div").attr("class", "counters")
    _this = @
    if @user_id
      d3.json("api/v1/me/counters.json", (resp) ->
        counters.selectAll(".counter")
          .data(resp)
          .enter()
          .append("div")
          .attr("class", "counter")
          .attr("data-counter-id", (d) -> d.id)
          .attr("style", (d) -> "background-color:#{d.palette.background_color}")
          .each((d) -> new Counter(d.id, _this))
        _this.resize()
      )

  #
  # Remove '.counters' div
  #
  removeCounters: () ->
    d3.selectAll(".counter")
      .data([])
      .exit()
      .remove()
    d3.select(".counters").remove()

  #
  # Append '.edit-counter' div
  #
  appendEdit: () ->
    @chart.append("div").attr("class", "edit-counter")

  #
  # Append '.edit-counter' div
  #
  removeEdit: () ->
    @chart.select(".edit-counter").remove()

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
  #
  # #
  # # Append Add Window
  # #
  # appendAddWindow: () ->
  #   _this = @
  #   palette_id = $('#chart').data('new-palette-id')
  #   $.ajax
  #     url: "/users/#{@user_id}/counters/new?palette_id=#{palette_id}"
  #     success: (data) ->
  #       _this.svg.select('#add_form_window')
  #       .attr({
  #         'x': 0,
  #         'y': 0,
  #         'width': 0,
  #         'height': 0,
  #       })
  #       .append('xhtml:html')
  #       .append('xhtml:body')
  #       .append('xhtml:div')
  #       .html(data)
  #       .attr({
  #         'style': 'display:none;'
  #       })
  #       $('#chart').on 'ajax:success', '#new_counter', () ->
  #         _this.appendAddWindow()
  #         _this.fetchCounters()
  #       $('#chart').on 'ajax:error', '#new_counter', (xhr, ajaxOptions, thrownError) ->
  #         $('#error_explanation').text(ajaxOptions.responseText)
  # #
  # # Open add window
  # #
  # openAddWindow: () ->
  #   _this = @
  #   @svg.select("#add_form_window")
  #     .attr({
  #       'width': '100%',
  #       'height': '100%',
  #     }).select('div')
  #     .attr({
  #       'style': 'display:block; height:100vh;'
  #     })
