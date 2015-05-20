class @Navigator
  @des_width
  @des_height
  @svg
  constructor: (options, value = 0) ->
    counters = []
    row= 0
    col= 0
    @des_width = 320
    @des_height = 240
    @svg = d3.select("#chart").append("svg").attr("class", 'svg').attr('preserveAspectRatio', "xMinYMin")
    k = ($('body').width() / $('body').height()) * (@des_width / @des_height)
    col = Math.floor(Math.sqrt(k * (1)))
    row = Math.ceil(Math.sqrt((1) / k))

    @svg.append("g")
      .attr('class', 'add-counter')
      .append("foreignObject")
      .attr('class', 'html')
      .attr("x", 0)
      .attr("y", 0)
      .attr("width", ($('body').width() / col))
      .attr("height", ($('body').height() / row))
      .append("xhtml:body")
      .html(() ->
        content(true)
      )

  back: () ->
    $('body').on 'click', '#back_from_new_counter', () ->
      form_elem = $(this).closest('.html')[0]
      form = d3.select(form_elem)
      form.remove()
      counter.select('.html').transition().duration(200).ease('back').attr("x",last_pos[0]).attr("y",last_pos[1]).attr('width', ($('body').width() / col)).attr('height', ($('body').height() / row))
      event.stopPropagation()
      event.preventDefault()

  draw: () ->
    margin = {top: 20, right: 0, bottom: 0, left: 0}
    formatNumber = d3.format("d")

    d3.json("api/v1/counters.json", (root) ->
      counters = root
      k = ($('body').width() / $('body').height()) * (@des_width / @des_height)
      col = Math.floor(Math.sqrt(k * (root.length + 1)))
      row = Math.ceil(Math.sqrt((root.length + 1) / k))

      @svg.selectAll(".counter").data(root)
        .enter()
        .append("g")
        .attr('class', 'counter')
        .append("foreignObject")
        .attr('class', 'html')
        .attr("x", (d) ->
          ((root.indexOf(d) + 1) % col) * ($('body').width() / col)
        )
        .attr("y", (d) ->
          ((root.indexOf(d) + 1) % row) * ($('body').height() / row)
        )
        .attr("width", ($('body').width() / col))
        .attr("height", ($('body').height() / row))
        .append("xhtml:body")
        .html((d) ->
          content(false)
        )
      )

  resize: () ->
    k = ($('body').width() / $('body').height()) * (des_width / des_height)
    col = Math.floor(Math.sqrt(k * (counters.length + 1)))
    row = Math.ceil(Math.sqrt((counters.length + 1) / k))
    @svg.selectAll(".counter").selectAll(".html").transition()
      .attr("x", (d) ->
        ((counters.indexOf(d) + 1) % col) * ($('body').width() / col)
      )
      .attr("y", (d) ->
        ((counters.indexOf(d) + 1) % row) * ($('body').height() / row)
      )
      .attr("width", ($('body').width() / col))
      .attr("height", ($('body').height() / row))

  content = (first = false) ->
    content_data = ''
    if first
      url = '/counter/new'
    else
      url = "/users/1/counters/#{d['id']}"
    $.ajax(
      url: url
      async: false
    ).done((data) ->
      content_data = data
    )
    content_data
