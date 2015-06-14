$("[data-counter-id='<%= @counter.id %>'] .counter-value").html("<%= @counter.clean_value %>")
