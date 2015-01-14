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
      format: '',
      duration: 200,
      theme: 'car'
    }
    new Counter(options, parseInt($(this).text()))