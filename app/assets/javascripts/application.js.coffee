#= require jquery
#= require jquery_ujs
#= require foundation
#= require odometer
#= require counter

$(document).ready ->
  # Foundation
  $(document).foundation()

  # Counters
  $('.counter').map (index) ->
    options = {
      el: $(this)[0],
      value: parseInt($(this).text()),
      format: '(ddd)',
      duration: 200
    }
    new Counter(options)