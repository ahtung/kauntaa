$("[data-counter-id='<%= @counter.id %>'] .counter").html("<%= @counter.value %>")

window.counters.each (index) ->
  this.odometer.update()