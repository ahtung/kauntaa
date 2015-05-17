  #= require jquery
#= require jquery_ujs
#= require foundation
#= require odometer
#= require jquery.transit
#= require FitText
#= require counter
#= require d3

$(document).ready ->
  #D3
  margin = {top: 20, right: 0, bottom: 0, left: 0}
  width = 960
  height = 500 - margin.top - margin.bottom
  formatNumber = d3.format("d")

  x = d3.scale.linear().domain([0, width]).range([0, width])
  y = d3.scale.linear().domain([0, height]).range([0, height])
  treemap = d3.layout.treemap().children((d, depth) ->
    depth ? null : d._children
  ).sort((a, b) ->
    a.value - b.value
  ).ratio(height / width * 0.5 * (1 + Math.sqrt(5))).round(false)

  svg = d3.select("#chart").append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.bottom + margin.top)
      .style("margin-left", -margin.left + "px")
      .style("margin.right", -margin.right + "px")
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
      .style("shape-rendering", "crispEdges");

  grandparent = svg.append("g")
      .attr("class", "grandparent");

  grandparent.append("rect")
      .attr("y", -margin.top)
      .attr("width", width)
      .attr("height", margin.top);

  grandparent.append("text")
      .attr("x", 6)
      .attr("y", 6 - margin.top)
      .attr("dy", ".75em");

#   d3.json("flare.json", ->(root) {
#     initialize(root);
#     accumulate(root);
#     layout(root);
#     display(root);
#
#     -> initialize(root) {
#       root.x = root.y = 0;
#       root.dx = width;
#       root.dy = height;
#       root.depth = 0;
#     }
#
#     -> accumulate(d) {
#       return (d._children = d.children)
#           ? d.value = d.children.reduce(->(p, v) { return p + accumulate(v); }, 0)
#           : d.value;
#     }
#
#     -> layout(d) {
#       if (d._children) {
#         treemap.nodes({_children: d._children});
#         d._children.forEach(->(c) {
#           c.x = d.x + c.x * d.dx;
#           c.y = d.y + c.y * d.dy;
#           c.dx *= d.dx;
#           c.dy *= d.dy;
#           c.parent = d;
#           layout(c);
#         });
#       }
#     }
#
#     -> display(d) {
#       grandparent
#           .datum(d.parent)
#           .on("click", transition)
#         .select("text")
#           .text(name(d));
#
#       g1 = svg.insert("g", ".grandparent")
#           .datum(d)
#           .attr("class", "depth");
#
#       g = g1.selectAll("g")
#           .data(d._children)
#         .enter().append("g");
#
#       g.filter(->(d) { return d._children; })
#           .classed("children", true)
#           .on("click", transition);
#
#       g.selectAll(".child")
#           .data(->(d) { return d._children || [d]; })
#         .enter().append("rect")
#           .attr("class", "child")
#           .call(rect);
#
#       g.append("rect")
#           .attr("class", "parent")
#           .call(rect)
#         .append("title")
#           .text(->(d) { return formatNumber(d.value); });
#
#       g.append("text")
#           .attr("dy", ".75em")
#           .text(->(d) { return d.name; })
#           .call(text);
#
#       -> transition(d) {
#         if (transitioning || !d) return;
#         transitioning = true;
#
#         g2 = display(d)
#         t1 = g1.transition().duration(750)
#         t2 = g2.transition().duration(750)
#
#         x.domain([d.x, d.x + d.dx]);
#         y.domain([d.y, d.y + d.dy]);
#
#         svg.style("shape-rendering", null);
#
#         svg.selectAll(".depth").sort(->(a, b) { return a.depth - b.depth; });
#
#         g2.selectAll("text").style("fill-opacity", 0);
#
#         t1.selectAll("text").call(text).style("fill-opacity", 0);
#         t2.selectAll("text").call(text).style("fill-opacity", 1);
#         t1.selectAll("rect").call(rect);
#         t2.selectAll("rect").call(rect);
#
#         t1.remove().each("end", ->() {
#           svg.style("shape-rendering", "crispEdges");
#           transitioning = false;
#         });
#       }
#
#       return g;
#     }
#
#     -> text(text) {
#       text.attr("x", ->(d) { return x(d.x) + 6; })
#           .attr("y", ->(d) { return y(d.y) + 6; });
#     }
#
#     -> rect(rect) {
#       rect.attr("x", ->(d) { return x(d.x); })
#           .attr("y", ->(d) { return y(d.y); })
#           .attr("width", ->(d) { return x(d.x + d.dx) - x(d.x); })
#           .attr("height", ->(d) { return y(d.y + d.dy) - y(d.y); });
#     }
#
#     -> name(d) {
#       return d.parent
#           ? name(d.parent) + "." + d.name
#           : d.name;
#     }
#   });

  # Foundation
  $(document).foundation()

  # FitText
  # $(".responsive-text").fitText(1.0)

  # Counters
  $('.counter').map (index) ->
    options = {
      el: $(this)[0]
      format: ''
    }
    window.counters = []
    window.counters.push new Counter(options, parseInt($(this).text()))

  $('body').on 'click', '.edit-counter', (event) ->
    event.stopPropagation();

  $('body').on 'click', '.increment-button', () ->
    $.get $(this).data('increment-url'), ( data ) ->
      console.log( "Load was performed." )
    , "script"

  $('body').on 'click', '.decrement-button', () ->
    $.get $(this).data('decrement-url'), ( data ) ->
      console.log( "Load was performed." )
    , "script"