class @Pages
  constructor: (initial) ->
    @clocks = $(".counter").FlipClock(initial,clockFace: "Counter")
