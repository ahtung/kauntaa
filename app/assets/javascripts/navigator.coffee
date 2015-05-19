class @Navigator
  constructor: (options, value = 0) ->
    counters = []
    des_width = 320
    des_height = 240
    row= 0
    col= 0
    svg = d3.select("#chart").append("svg").attr("class", 'svg').attr('preserveAspectRatio', "xMinYMin")
    k = ($('body').width() / $('body').height()) * (des_width / des_height)
    col = Math.floor(Math.sqrt(k * (5 + 1)))
    row = Math.ceil(Math.sqrt((5 + 1) / k))

    svg.append("g")
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

  init: () ->

  draw: () ->
    margin = {top: 20, right: 0, bottom: 0, left: 0}
    formatNumber = d3.format("d")

    d3.json("api/v1/counters.json", (root) ->
      counters = root
      k = ($('body').width() / $('body').height()) * (des_width / des_height)
      col = Math.floor(Math.sqrt(k * (root.length + 1)))
      row = Math.ceil(Math.sqrt((root.length + 1) / k))

      svg.selectAll(".counter").data(root)
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
          content(true)
        )
      )

  resize: () ->
    k = ($('body').width() / $('body').height()) * (des_width / des_height)
    col = Math.floor(Math.sqrt(k * (counters.length + 1)))
    row = Math.ceil(Math.sqrt((counters.length + 1) / k))
    svg.selectAll(".counter").selectAll(".html").transition()
      .attr("x", (d) ->
        ((counters.indexOf(d) + 1) % col) * ($('body').width() / col)
      )
      .attr("y", (d) ->
        ((counters.indexOf(d) + 1) % row) * ($('body').height() / row)
      )
      .attr("width", ($('body').width() / col))
      .attr("height", ($('body').height() / row))

  content: (first = false) ->
    $.ajax(
      url: (first ? '/counter/new' : "/users/1/counters/#{d['id']}"),
      async: false
    ).done((data) ->
      content = data
    )
    content
