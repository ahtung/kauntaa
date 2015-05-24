class @Navigator
  @des_width
  @des_height
  @svg
  @col
  @row
  @counter
  @last_pos

  constructor: (options, value = 0) ->
    @duration = 300
    @fade_duration = 150
    counters = []
    row= 0
    col= 0
    @des_width = 1
    @des_height = 1
    @svg = d3.select("#chart").append("svg").attr("class", 'svg').attr('preserveAspectRatio', "xMinYMin")
    dit = @
    @svg.append("g")
      .attr('class', 'add-counter')
      .append("foreignObject")
      .attr('class', 'html')
      .append("xhtml:body")
      .html(content('/counter/new'))

    $('body').on 'click', '#back_from_new_counter', (event) ->
      dit.back(@)
      event.stopPropagation()
      event.preventDefault()

    $('body').on 'click', '.edit-counter', (event) ->
      dit.edit(@)
      event.stopPropagation()
      event.preventDefault()

    $('body').on 'click', '.add-counter', (event) ->
      dit.add(@)
      event.stopPropagation()
      event.preventDefault()

  # Go back
  back: (elem) ->
    form_elem = $(elem).closest('.html')[0]
    form = d3.select(form_elem)
    form.remove()
    @counter.transition()
      .duration(@fade_duration)
      .select('.add-icon')
      .style('opacity', 1)
    @counter.transition()
      .duration(@fade_duration)
      .selectAll('a')
      .style('opacity', 1)
    @counter.transition()
      .duration(@fade_duration)
      .select('.edit-counter')
      .style('opacity', 1)
    @counter.transition()
      .duration(@fade_duration)
      .select('.counter')
      .style('opacity', 1)
    @counter.select('.html').transition().duration(@duration).ease('back').attr("x",@last_pos[0]).attr("y",@last_pos[1]).attr('width', ($('body').width() / @col)).attr('height', ($('body').height() / @row))

  # Draw
  draw: () ->
    margin = {top: 20, right: 0, bottom: 0, left: 0}
    formatNumber = d3.format("d")

    svg = @svg
    des_width = @des_width
    des_height = @des_height
    dit = @
    user_id = $('#chart').data('user-id')
    d3.json("api/v1/users/#{user_id}/counters.json", (root) ->
      dit.counters = root
      svg.selectAll(".counter").data(root)
        .enter()
        .append("g")
        .attr('class', 'counter')
        .append("foreignObject")
        .attr('class', 'html')
        .append("xhtml:body")
        .html((d) ->
          content("/users/1/counters/#{d['id']}")
        )
      dit.resize()
    )

  moveToFront = () ->
    this.parentNode.parentNode.appendChild(this.parentNode)

  # New counter
  add: (elem) ->
    link = $(elem).find('a').attr('href')
    @counter = d3.select(elem)
    counter_html = @counter.select(".html")
    @last_pos = [counter_html.attr('x'), counter_html.attr('y')]
    palette_id = $('.new-counter').data('palette-id')

    @counter.transition()
      .duration(@fade_duration)
      .select('.add-icon')
      .style('opacity', 0)
    @counter.transition()
      .duration(@fade_duration)
      .selectAll('a')
      .style('opacity', 0)

    counter_html.each(moveToFront)
      .transition()
      .duration(@duration)
      .ease('elastic')
      .attr("x",0)
      .attr("y",0)
      .attr('width', window.innerWidth)
      .attr('height', window.innerHeight)
      .each("end", () ->
        d3.select('svg')
          .append("foreignObject")
          .attr('class', 'html')
          .attr("x", '0')
          .attr("y", '0')
          .attr("width", '100%')
          .attr("height", '100%')
          .append("xhtml:body")
          .html((d) ->
            content(link + "?palette_id=#{palette_id}")
          )
      )

  # Edit counter
  edit: (counter) ->
    counter = $(counter).closest('.counter')[0]
    link = $(counter).find('a').attr('href')
    @counter = d3.select(counter)
    counter_html = @counter.select(".html")
    @last_pos = [counter_html.attr('x'), counter_html.attr('y')]

    counter_html.transition()
      .duration(@fade_duration)
      .select('.edit-counter')
      .style('opacity', 0)
    counter_html.transition()
      .duration(@fade_duration)
      .select('.counter')
      .style('opacity', 0)
    counter_html.each(moveToFront)
      .transition()
      .duration(@duration)
      .ease('elastic')
      .attr("x",0)
      .attr("y",0)
      .attr('width', window.innerWidth)
      .attr('height', window.innerHeight)
      .each("end", () ->
        d3.select('svg')
          .append("foreignObject")
          .attr('class', 'html')
          .attr("x", '0')
          .attr("y", '0')
          .attr("width", '100%')
          .attr("height", '100%')
          .append("xhtml:body")
          .html((d) ->
            content(link)
          )
      )

  # return row an col count
  get_dimensions: (n) ->
    # preferred_ratio = 1.2
    # desired_aspect = ($('body').width() / $('body').height()) / preferred_ratio
    num_cols = Math.ceil(Math.sqrt(n))
    num_rows = Math.ceil(n / parseFloat(num_cols))
    return [num_rows, num_cols]

  # Helper function
  range: (n) ->
    Array.apply(null, Array(n)).map((_, i) ->
      i
    )

  resize: () ->
    k = ($('body').width() / $('body').height()) * (@des_width / @des_height)
    dimensions = @get_dimensions(@counters.length + 1)
    @col = dimensions[0]
    @row = dimensions[1]
    dit = @
    @svg.selectAll(".add-counter")
      .selectAll(".html")
      .transition()
      .attr("x", 0)
      .attr("y", 0)
      .attr("width", @col_width())
      .attr("height", @row_height())

    @svg.selectAll(".counter").selectAll(".html").transition()
      .attr("x", (d) ->
        ((dit.counters.indexOf(d) + 1) % dit.col) * $('body').width() / dit.col
      )
      .attr("y", (d) ->
        parseInt((dit.counters.indexOf(d) + 1) / dit.col) * ($('body').height() / dit.row)
      )
      .attr("width", dit.col_width())
      .attr("height", dit.row_height())

  col_width: () ->
    $('body').width() / @col

  row_height: () ->
    $('body').height() / @row

  content = (url) ->
    content_data = ''
    $.ajax(
      url: url
      async: false
    ).done((data) ->
      content_data = data
    )
    content_data
