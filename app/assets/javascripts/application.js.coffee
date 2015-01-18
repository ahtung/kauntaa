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
      theme: 'minimal'
    }
    new Counter(options, parseInt($(this).text()))

  $('body').on 'click', '.increment-button', () ->
    $.get $(this).data('increment-url'), ( data ) ->
      alert( "Load was performed." )
    , "script"
  $('body').on 'click', '.decrement-button', () ->
    $.get $(this).data('decrement-url'), ( data ) ->
      alert( "Load was performed." )
    , "script"