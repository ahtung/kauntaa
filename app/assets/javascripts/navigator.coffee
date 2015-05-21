class @Navigator
  @des_width
  @des_height
  @svg
  @col
  @row
  @counter
  @last_pos
  constructor: (options, value = 0) ->
    counters = []
    row= 0
    col= 0
    @des_width = 640
    @des_height = 480
    @svg = d3.select("#chart").append("svg").attr("class", 'svg').attr('preserveAspectRatio', "xMinYMin")
    k = ($('body').width() / $('body').height()) * (@des_width / @des_height)
    col = Math.ceil(Math.sqrt(k * (1)))
    row = Math.ceil(Math.sqrt((1) / k))
    @col = 0

    @svg.append("g")
      .attr('class', 'add-counter')
      .append("foreignObject")
      .attr('class', 'html')
      .attr("x", 0)
      .attr("y", 0)
      .attr("width", ($('body').width() / col))
      .attr("height", ($('body').height() / row))
      .append("xhtml:body")
      .html(content())

    dit = @
    $('body').on 'click', '#back_from_new_counter', () ->
      dit.back(this)
      event.stopPropagation()
      event.preventDefault()

  back: (elem) ->
    form_elem = $(elem).closest('.html')[0]
    form = d3.select(form_elem)
    form.remove()
    @counter.select('.html').transition().duration(200).ease('back').attr("x",@last_pos[0]).attr("y",@last_pos[1]).attr('width', ($('body').width() / @col)).attr('height', ($('body').height() / @row))

  draw: () ->
    margin = {top: 20, right: 0, bottom: 0, left: 0}
    formatNumber = d3.format("d")

    svg = @svg
    des_width = @des_width
    des_height = @des_height
    dit = @

    d3.json("api/v1/counters.json", (root) ->
      dit.counters = root
      k = ($('body').width() / $('body').height()) * (des_width / des_height)
      col = Math.ceil(Math.sqrt(k * (root.length + 1)))
      row = Math.ceil(Math.sqrt((root.length + 1) / k))
      console.log root
      svg.selectAll(".counter").data(root)
        .enter()
        .append("g")
        .attr('class', 'counter')
        .append("foreignObject")
        .attr('class', 'html')
        .append("xhtml:body")
        .html((d) ->
          content(d)
        )
      dit.resize()
    )

  row_and_col: () ->
    console.log('TODO')

  resize: () ->
    k = ($('body').width() / $('body').height()) * (@des_width / @des_height)
    @col = Math.floor(Math.sqrt(k * (@counters.length + 1)))
    @row = Math.ceil(Math.sqrt((@counters.length + 1) / k))
    dit = @

    @svg.selectAll(".add-counter")
      .selectAll(".html")
      .transition()
      .attr("x", 0)
      .attr("y", 0)
      .attr("width", @col_width())
      .attr("height", @row_height())

    @svg.selectAll(".counter").selectAll(".html").transition()
      .attr("x", (d) ->
        ((dit.counters.indexOf(d) + 1) % dit.col) * $('body').width() / dit.col
      )
      .attr("y", (d) ->
        parseInt((dit.counters.indexOf(d) + 1) / dit.col) * ($('body').height() / dit.row)
      )
      .attr("width", dit.col_width())
      .attr("height", dit.row_height())

  col_width: () ->
    $('body').width() / @col

  row_height: () ->
    $('body').height() / @row

  content = (d) ->
    content_data = ''
    if d
      url = "/users/1/counters/#{d['id']}"
    else
      url = '/counter/new'

    $.ajax(
      url: url
      async: false
    ).done((data) ->
      content_data = data
    )
    content_data
