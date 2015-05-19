#= require jquery
#= require jquery_ujs
#= require foundation
#= require d3
#= require counter
#= require navigator

$(document).ready ->
  #D3
  navigator = new Navigator

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
      navigator.resize()

  navigator.draw()

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