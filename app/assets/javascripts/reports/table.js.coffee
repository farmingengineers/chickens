window.reportRenderers ||= {}
reportRenderers.table = (report, data) ->
  table = $('<table></table>').appendTo(report)
  thead = $('<thead></thead>').appendTo(table)
  tbody = $('<tbody></tbody>').appendTo(table)
  renderRow = (tag) ->
    before  = "<tr><#{tag}>"
    between = "</#{tag}><#{tag}>"
    after   = "</#{tag}></tr>"
    (row) -> before + row.join(between) + after
  renderTh = renderRow('th')
  renderTd = renderRow('td')
  thead.html renderTh(data.column_names)
  for row in data.rows
    tbody.append renderTd(row)
