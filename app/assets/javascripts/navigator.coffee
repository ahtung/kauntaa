class @Navigator
  # Constructor
  constructor: () ->
    # Vars
    @duration = 300
    @counter_data = []
    @svg = d3.select("#chart").append("svg").attr("class", 'svg')
    @user_id = $('#chart').data('user-id')
    _this = @

    # Events
    d3.select(window).on('resize', () ->
      _this.updateWindow(_this)
    )

    $('#chart').on 'click', '.edit-counter', (event) ->
      _this.edit(@)
      _this.redraw()
      event.stopPropagation()
      event.preventDefault()

    # Init
    ## Add Add button
    @svg.append("g")
      .attr('class', 'add-counter')
      .append("foreignObject")
      .attr('class', 'html')
      .append("xhtml:body")
      .html(content('/counter/new'))
    ## Counters
    d3.json("api/v1/users/#{@user_id}/counters.json", (resp) ->
      _this.counter_data = resp
      _this.redraw()
    )

  # Update window
  updateWindow: (diz) ->
    x = window.innerWidth || e.clientWidth || g.clientWidth
    y = window.innerHeight|| e.clientHeight|| g.clientHeight
    # diz.svg.attr("width", x).attr("height", y)
    diz.redraw()

  # Redraws counters
  redraw: () ->
    _this = @
    console.log('redraw')
    @counters = @svg.selectAll(".counter").data(@counter_data)
    counter = @counters.enter().append("g").attr('class', 'counter')
    counter.insert("rect")
      .attr("fill", (d) -> d.palette.background_color)
    counter.append('text')
      .text( (d) -> d.value )
      .attr("x", 40)
      .attr("y", 40)
      .attr("font-family", "sans-serif")
      .attr("font-size", "40px")
      .attr("fill", (d) -> d.palette.foreground_color)
    counter.append('text')
      .text( (d) -> "#{d.nae} since #{'TODO'}" )
      .attr("x", 40)
      .attr("y", 80)
      .attr("class", "edit-counter")
      .attr("font-family", "sans-serif")
      .attr("font-size", "20px")
      .attr("fill", (d) -> d.palette.foreground_color)

    @counters.transition()
      .duration(@duration)
      .ease('elastic')
      .attr("transform", (d, i) ->
        if _this.counter_data.length > 1
          "translate(#{((i + 1) % 4) * (window.innerWidth / 4)}, #{parseInt((i + 1) / 4) * (window.innerHeight / 4)})"
        else
          "translate(0, 0)"
      )
    @counters.select('rect').transition()
      .duration(@duration)
      .ease('elastic')
      .attr("width", (d) ->
        if _this.counter_data.length > 1
          (window.innerWidth / 4)
        else
          window.innerWidth
      )
      .attr("height", (d) ->
        if _this.counter_data.length > 1
          (window.innerHeight / 4)
        else
          window.innerHeight
      )

    @svg.select(".add-counter").select('foreignobject').attr("width", (d) -> window.innerWidth / 4).attr("height", (d) -> window.innerHeight / 4)

    @counters.exit().transition()
        .duration(@duration)
        .attr("transfor", "translate(0, 0)")
        .remove()

  #
  # # Go back
  # back: (elem) ->
  #   form_elem = $(elem).closest('.html')[0]
  #   form = d3.select(form_elem)
  #   form.remove()
  #   @counter.transition()
  #     .duration(@fade_duration)
  #     .select('.add-icon')
  #     .style('opacity', 1)
  #   @counter.transition()
  #     .duration(@fade_duration)
  #     .selectAll('a')
  #     .style('opacity', 1)
  #   @counter.transition()
  #     .duration(@fade_duration)
  #     .select('.edit-counter')
  #     .style('opacity', 1)
  #   @counter.transition()
  #     .duration(@fade_duration)
  #     .select('.counter')
  #     .style('opacity', 1)
  #   @counter.select('.html').transition().duration(@duration).ease('back').attr("x",@last_pos[0]).attr("y",@last_pos[1]).attr('width', ($('body').width() / @col)).attr('height', ($('body').height() / @row))
  #
  # moveToFront = () ->
  #   this.parentNode.parentNode.appendChild(this.parentNode)
  #
  # # New counter
  # add: (elem) ->
  #   link = $(elem).find('a').attr('href')
  #   @counter = d3.select(elem)
  #   counter_html = @counter.select(".html")
  #   @last_pos = [counter_html.attr('x'), counter_html.attr('y')]
  #   palette_id = $('.new-counter').data('palette-id')
  #
  #   @counter.transition()
  #     .duration(@fade_duration)
  #     .select('.add-icon')
  #     .style('opacity', 0)
  #   @counter.transition()
  #     .duration(@fade_duration)
  #     .selectAll('a')
  #     .style('opacity', 0)
  #
  #   counter_html.each(moveToFront)
  #     .transition()
  #     .duration(@duration)
  #     .ease('elastic')
  #     .attr("x",0)
  #     .attr("y",0)
  #     .attr('width', window.innerWidth)
  #     .attr('height', window.innerHeight)
  #     .each("end", () ->
  #       d3.select('svg')
  #         .append("foreignObject")
  #         .attr('class', 'html')
  #         .attr("x", '0')
  #         .attr("y", '0')
  #         .attr("width", '100%')
  #         .attr("height", '100%')
  #         .append("xhtml:body")
  #         .html((d) ->
  #           content(link + "?palette_id=#{palette_id}")
  #         )
  #     )
  #
  # Edit counter
  edit: (counter) ->
    counter = $(counter).closest('.counter')[0]
    # link = $(counter).find('a').attr('href')
    # @counter = d3.select(counter)
    # counter_html = @counter.select(".html")
    # @last_pos = [counter_html.attr('x'), counter_html.attr('y')]
    @counter_data = [@counter_data[3]]
    @redraw()

    # counter_html.transition()
#       .duration(@fade_duration)
#       .select('.edit-counter')
#       .style('opacity', 0)
#     counter_html.transition()
#       .duration(@fade_duration)
#       .select('.counter')
#       .style('opacity', 0)
#     counter_html.each(moveToFront)
#       .transition()
#       .duration(@duration)
#       .ease('elastic')
#       .attr("x",0)
#       .attr("y",0)
#       .attr('width', window.innerWidth)
#       .attr('height', window.innerHeight)
#       .each("end", () ->
#         d3.select('svg')
#           .append("foreignObject")
#           .attr('class', 'html')
#           .attr("x", '0')
#           .attr("y", '0')
#           .attr("width", '100%')
#           .attr("height", '100%')
#           .append("xhtml:body")
#           .html((d) ->
#             content(link)
#           )
#         )
  #
  # # return row an col count
  # get_dimensions: (n) ->
  #   if $('body').width() < 640
  #     num_cols = 1
  #     num_rows = Math.ceil(n / parseFloat(num_cols))
  #   else
  #     num_cols = Math.ceil(Math.sqrt(n))
  #     num_rows = Math.ceil(n / parseFloat(num_cols))
  #   return [num_cols, num_rows]
  #
  # # Helper function
  # range: (n) ->
  #   Array.apply(null, Array(n)).map((_, i) ->
  #     i
  #   )
  #
  # resize: () ->
  #   k = ($('body').width() / $('body').height()) * (@des_width / @des_height)
  #   dimensions = @get_dimensions(@counters.length + 1)
  #   @col = dimensions[0]
  #   @row = dimensions[1]
  #   dit = @
  #   @svg.selectAll(".add-counter")
  #     .selectAll(".html")
  #     .transition()
  #     .attr("x", 0)
  #     .attr("y", 0)
  #     .attr("width", @col_width())
  #     .attr("height", @row_height())
  #
  #   @svg.selectAll(".counter").selectAll(".html").transition()
  #     .attr("x", (d) ->
  #       ((dit.counters.indexOf(d) + 1) % dit.col) * $('body').width() / dit.col
  #     )
  #     .attr("y", (d) ->
  #       parseInt((dit.counters.indexOf(d) + 1) / dit.col) * ($('body').height() / dit.row)
  #     )
  #     .attr("width", dit.col_width())
  #     .attr("height", dit.row_height())
  #
  # col_width: () ->
  #   $('body').width() / @col
  #
  # row_height: () ->
  #   $('body').height() / @row
  #
  content = (url) ->
    content_data = ''
    $.ajax(
      url: url
      async: false
    ).done((data) ->
      content_data = data
    )
    content_data
