  #= require jquery
#= require jquery_ujs
#= require foundation
#= require odometer
#= require jquery.transit
#= require FitText
#= require counter
#= require d3

$(document).ready ->
  #D3
  des_width = 320
  des_height = 240
  margin = {top: 20, right: 0, bottom: 0, left: 0}
  formatNumber = d3.format("d")
  svg = d3.select("#chart").append("svg").attr("class", 'svg')

  d3.json("api/v1/counters.json", (root) ->
    console.log($('body').width(), $('body').height())
    k = ($('body').width() / $('body').height()) * (des_width / des_height)
    col = Math.floor(Math.sqrt(k * (root.length + 1)))
    row = Math.ceil(Math.sqrt((root.length + 1) / k))
    console.log(row, col)
    p = svg.append("g")
      .append("rect")
      .attr("x", 0)
      .attr("y", 0)
      .attr("width", des_width)
      .attr("height", des_height)
      .append('text')
      .text('add')

    content = ''
    $.get( "/users/1/counters/3", (d)->
      content = d
      svg.selectAll(".counter").data(root)
        .enter()
        .append("g")
        .attr('class', 'counter')
        .append("rect")
        .attr('opacity', 0.0)
        .attr("x", (d) ->
          ((root.indexOf(d) + 1) % col) * des_width
        )
        .attr("y", (d) ->
          ((root.indexOf(d) + 1) % row) * des_height
        )
        .attr("width", des_width)
        .attr("height", des_height)
        .append("foreignObject")
          .attr("width", '50%')
          .attr("height", '50%')
        .append("xhtml:body")
          .style("font", "14px 'Helvetica Neue'")
          .html(content)
    )
  )

  # Foundation
  $(document).foundation()

  # FitText
  # $(".responsive-text").fitText(1.0)

  # Counters
  $('.counter').map (index) ->
    options = {
      el: $(this)[0]
      format: ''
    }
    window.counters = []
    window.counters.push new Counter(options, parseInt($(this).text()))

  $('body').on 'click', '.edit-counter', (event) ->
    event.stopPropagation();

  $('body').on 'click', '.increment-button', () ->
    $.get $(this).data('increment-url'), ( data ) ->
      console.log( "Load was performed." )
    , "script"

  $('body').on 'click', '.decrement-button', () ->
    $.get $(this).data('decrement-url'), ( data ) ->
      console.log( "Load was performed." )
    , "script"