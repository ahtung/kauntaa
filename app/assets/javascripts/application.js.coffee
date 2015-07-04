#= require jquery
#= require jquery_ujs
#= require foundation
#= require d3
#= require fittext
#= require underscore
#= require counter
#= require navigator
#= require odometer

$(document).ready ->
  #D3
  navigator = new Navigator

  # Foundation
  $(document).foundation()
