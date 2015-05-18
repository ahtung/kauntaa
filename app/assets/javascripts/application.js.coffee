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
  d3.selection.prototype.moveToFront = () ->
    this.each(() ->
      this.parentNode.appendChild(this)
    )


  des_width = 320
  des_height = 240
  svg = d3.select("#chart").append("svg").attr("class", 'svg')
  svg.append("g")
    .append("rect")
    .attr("x", 0)
    .attr("y", 0)
    .attr("width", des_width)
    .attr("height", des_height)
    .append('text')
    .text('add')

  draw = () ->
    margin = {top: 20, right: 0, bottom: 0, left: 0}
    formatNumber = d3.format("d")

    d3.json("api/v1/counters.json", (root) ->
      k = ($('body').width() / $('body').height()) * (des_width / des_height)
      col = Math.floor(Math.sqrt(k * (root.length + 1)))
      row = Math.ceil(Math.sqrt((root.length + 1) / k))
      content = ''
      svg.selectAll(".counter").data(root)
        .enter()
        .append("g")
        .attr('class', 'counter')
        .append("foreignObject")
        .attr('class', 'html')
        .attr("x", (d) ->
          ((root.indexOf(d) + 1) % col) * des_width
        )
        .attr("y", (d) ->
          ((root.indexOf(d) + 1) % row) * des_height
        )
        .attr("width", des_width)
        .attr("height", des_height)
        .append("xhtml:body")
        .html((d) ->
          $.ajax(
            url: "/users/1/counters/#{d['id']}",
            async: false
          ).done((data) ->
            content = data
          )
          content
        )
      )

  timeout = false
  delta = 200
  rtime = new Date(1, 1, 2000, 12,0,0)
  $(window).resize(() ->
    rtime = new Date()
    unless timeout
      timeout = true;
      setTimeout(resizeend, delta)
  )
  resizeend = () ->
    if (new Date() - rtime < delta)
      setTimeout(resizeend, delta)
    else
      timeout = false
      draw()
  draw()
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
    counter_elem = $(this).closest('.counter')[0]
    counter = d3.select(counter_elem).select(".html")
    counter.moveToFront().transition().attr("x",0).attr("y",0).attr('width', '100%').attr('height', '100%')
    event.stopPropagation()
    # event.preventDefault()

  $('body').on 'click', '.increment-button', () ->
    $.get $(this).data('increment-url'), ( data ) ->
      console.log( "Load was performed." )
    , "script"

  $('body').on 'click', '.decrement-button', () ->
    $.get $(this).data('decrement-url'), ( data ) ->
      console.log( "Load was performed." )
    , "script"