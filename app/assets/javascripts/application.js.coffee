#= require jquery
#= require jquery_ujs
#= require foundation
#= require d3
#= require fittext
#= require underscore
#= require counter
#= require navigator

$(document).ready ->
  #D3
  navigator = new Navigator

  # Resize D3
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

  # Draw
  navigator.draw()

  # Foundation
  $(document).foundation()

  # # Counters
  # $('.counter').map (index) ->
  #   options = {
  #     el: $(this)[0]
  #     format: ''
  #   }
  #   window.counters = []
  #   window.counters.push new Counter(options, parseInt($(this).text()))

