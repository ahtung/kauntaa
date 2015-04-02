$("[data-counter-id='<%= @counter.id %>'] .counter").html("<%= @counter.clean_value %>")

window.counters.each (index) ->
  this.odometer.update()