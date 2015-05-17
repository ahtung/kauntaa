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
  margin = {top: 20, right: 0, bottom: 0, left: 0}
  formatNumber = d3.format("d")
  svg = d3.select("#chart").append("svg").attr("class", 'svg')
  svg.append("g")
    .append("rect")
    .attr("x", 0)
    .attr("y", 0)
    .attr("width", '50%')
    .attr("height", '50%')
    .append('text')
    .text('add')

  $.get( "/users/1/counters/3", ( data ) ->
    svg.append("foreignObject")
      .attr("width", '50%')
      .attr("height", '50%')
    .append("xhtml:body")
      .style("font", "14px 'Helvetica Neue'")
      .html(data);
  )
  d3.json("api/v1/counters.json", (root) ->

    p = svg.selectAll("g")
      .data(root)
      .enter()
      .append("g")
      .append("rect")
      .attr("x", 0)
      .attr("y", 0)
      .attr("width", '50%')
      .attr("height", '50%')
      .append('text')
      .text((d)-> d['name'])
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