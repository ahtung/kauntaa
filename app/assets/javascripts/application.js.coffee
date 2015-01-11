#= require jquery
#= require jquery_ujs
#= require foundation
#= require FlipClock
#= require pages

$(document).ready ->
  $(document).foundation()
  initial = parseInt($(".counter").text())
  window.test = new Pages(initial)
