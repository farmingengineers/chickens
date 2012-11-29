window.reportRenderers ||= {}
reportRenderers.graph = (report, data) ->
  columns = ({index: i, name:name} for name, i in data.column_names)
  dataColumns = columns.slice(1)

  parseDate = d3.time.format('%Y-%m-%d').parse
  parsedDates = (parseDate(row[0]) for row in data.rows)

  margin =
    top    : 20
    bottom : 30
    left   : 50
    right  : 80
  width  = 960 - margin.left - margin.right
  height = 500 - margin.top  - margin.bottom

  # Set up some D3 things
  x = d3.time.scale().range([0, width])
  y = d3.scale.linear().range([height, 0])
  color = d3.scale.category10()
  xAxis = d3.svg.axis().scale(x).orient('bottom')
  yAxis = d3.svg.axis().scale(y).orient('left')

  line = d3.svg.line()
    .interpolate('basis')
    .x((d) -> x(d.week))
    .y((d) -> y(d.value))

  svg = d3.select(report).append('svg')
    .attr('width', width + margin.left + margin.right)
    .attr('height', height + margin.top + margin.bottom)
    .append('g')
    .attr('transform', "translate(#{margin.left}, #{margin.top})")

  # Draw it!
  color.domain(col.index for col in dataColumns)
  x.domain     d3.extent(parsedDates)
  y.domain(
    for agg in [d3.min, d3.max]
      agg(data.rows, (row) -> agg(row.slice(1), (v) -> +v))
  )

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
    .data(dataColumns)
    .enter().append('g')
    .attr('class', 'series')

  filterLine = (column) ->
    for row, i in data.rows when row[column.index]
      {week: parsedDates[i], value: row[column.index]}
  series.append('path')
    .attr('class', 'line')
    .attr('d', (d) -> line(filterLine(d)))
    .style('stroke', (d) -> color(d.index))

  last_point = (column) ->
    for row, i in data.rows when +row[column.index]
      return {week: parsedDates[i], value: +row[column.index]}
    {week: d3.max(parsedDates), value: 0}
  series.append('text')
    .datum((d) -> {name: d.name, value: last_point(d), color: color(d.index)})
    .attr('transform', (d) -> "translate(#{x d.value.week}, #{y d.value.value})")
    .attr('x', 3)
    .attr('dy', '.35em')
    .attr('stroke', (d) -> d.color)
    .text((d) -> d.name)
