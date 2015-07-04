#= require jquery
#= require jquery_ujs
#= require foundation
#= require d3
#= require fittext
#= require underscore
#= require counter
#= require navigator

$(document).ready ->
  #D3
  @user_id = $('#chart').data('user-id')
  if @user_id.length > 0
    navigator = new Navigator

  # Foundation
  $(document).foundation()
