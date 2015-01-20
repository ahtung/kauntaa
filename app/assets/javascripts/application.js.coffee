#= require jquery
#= require jquery_ujs
#= require foundation
#= require odometer
#= require jquery.transit
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

  $('body').on 'click tap', '.increment-button', () ->
    $.get $(this).data('increment-url'), ( data ) ->
      console.log( "Load was performed." )
    , "script"
  $('body').on 'click tap', '.decrement-button', () ->
    $.get $(this).data('decrement-url'), ( data ) ->
      console.log( "Load was performed." )
    , "script"