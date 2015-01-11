class @Pages
  constructor: (initial) ->
    @clock = $(".counter").FlipClock(initial,clockFace: "Counter")
