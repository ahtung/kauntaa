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
  counters = []
  des_width = 320
  des_height = 240
  row= 0
  col= 0
  svg = d3.select("#chart").append("svg").attr("class", 'svg').attr('preserveAspectRatio', "xMinYMin")
  svg.append("g")
    .append("rect")
    .attr("x", 0)
    .attr("y", 0)
    .attr("width", des_width)
    .attr("height", des_height)
    .append('text')
    .text('add')

  resize_svg = () ->
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

  draw = () ->
    margin = {top: 20, right: 0, bottom: 0, left: 0}
    formatNumber = d3.format("d")

    d3.json("api/v1/counters.json", (root) ->
      counters = root
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
          ((root.indexOf(d) + 1) % col) * ($('body').width() / col)
        )
        .attr("y", (d) ->
          ((root.indexOf(d) + 1) % row) * ($('body').height() / row)
        )
        .attr("width", ($('body').width() / col))
        .attr("height", ($('body').height() / row))
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
      resize_svg();
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

  link = ''
  counter = ''
  counter_elem = ''
  counter_html = ''
  content = ''
  last_pos = []
  moveToFront = () ->
    this.parentNode.parentNode.appendChild(this.parentNode)

  $('body').on 'click', '.edit-counter', (event) ->
    link = $(this).attr('href')
    counter_elem = $(this).closest('.counter')[0]
    counter = d3.select(counter_elem)
    counter_html = counter.select(".html")
    last_pos = [counter_html.attr('x'), counter_html.attr('y')]

    counter_html.each(moveToFront).transition().duration(200).ease('elastic').attr("x",0).attr("y",0).attr('width', window.innerWidth).attr('height', window.innerHeight).each("end", () ->
      d3.select('svg')
        .append("foreignObject")
        .attr('class', 'html')
        .attr("x", '0')
        .attr("y", '0')
        .attr("width", '100%')
        .attr("height", '100%')
        .append("xhtml:body")
        .html((d) ->
          $.ajax(
            url: link,
            async: false
          ).done((data) ->
            content = data
          )
          content
        )
    )
    event.stopPropagation()
    event.preventDefault()

  $('body').on 'click', '#back_from_new_counter', () ->
    form_elem = $(this).closest('.html')[0]
    form = d3.select(form_elem)
    form.remove()
    counter.select('.html').transition().duration(200).ease('back').attr("x",last_pos[0]).attr("y",last_pos[1]).attr('width', ($('body').width() / col)).attr('height', ($('body').height() / row))
    event.stopPropagation()
    event.preventDefault()

  $('body').on 'click', '.increment-button', () ->
    $.get $(this).data('increment-url'), ( data ) ->
      console.log( "Load was performed." )
    , "script"

  $('body').on 'click', '.decrement-button', () ->
    $.get $(this).data('decrement-url'), ( data ) ->
      console.log( "Load was performed." )
    , "script"