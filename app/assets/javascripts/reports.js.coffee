$ ->
  $('.report').each ->
    margin =
      top    : 20
      bottom : 30
      left   : 50
      right  : 80
    width  = 960 - margin.left - margin.right
    height = 500 - margin.top  - margin.bottom

    parseDate = d3.time.format('%Y-%m-%d').parse
    x = d3.time.scale().range([0, width])
    y = d3.scale.linear().range([height, 0])
    color = d3.scale.category10()
    xAxis = d3.svg.axis().scale(x).orient('bottom')
    yAxis = d3.svg.axis().scale(y).orient('left')

    line = d3.svg.line()
      .interpolate('basis')
      .x((d) -> x(d.week))
      .y((d) -> y(d.value))

    svg = d3.select(this).append('svg')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
      .append('g')
      .attr('transform', "translate(#{margin.left}, #{margin.top})")

    d3.csv $(this).data('report'), (error, data) ->
      console.log error

      dataColumns = d3.keys(data[0]).filter((key) -> key != 'week')

      for row in data
        row.week = parseDate row.week

      lines =
        for column in dataColumns
          name   : column
          values :
            for row in data
              week  : row.week
              value : +row[column]

      color.domain dataColumns
      x.domain     d3.extent(data, (row) -> row.week)
      y.domain     [
        d3.min(lines, (line) -> d3.min(line.values, (point) -> point.value)),
        d3.max(lines, (line) -> d3.max(line.values, (point) -> point.value)),
      ]

      svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis)

      svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
        .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")

      series = svg.selectAll('.series')
        .data(lines)
        .enter().append('g')
        .attr('class', 'series')

      series.append('path')
        .attr('class', 'line')
        .attr('d', (d) -> line(d.values))
        .style('stroke', (d) -> color(d.name))

      series.append('text')
        .datum((d) -> {name: d.name, value: d.values[0]})
        .attr('transform', (d) -> "translate(#{x d.value.week}, #{y d.value.value})")
        .attr('x', 3)
        .attr('dy', '.35em')
        .text((d) -> d.name)
