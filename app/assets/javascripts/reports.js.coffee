$ ->
  $('.report').each ->
    report = $ this
    dataUrl = report.data 'report'
    $.getJSON dataUrl, (data) ->
      table = $('<table></table>').appendTo(report)
      thead = $('<thead></thead>').appendTo(table)
      tbody = $('<tbody></tbody>').appendTo(table)
      c = thead
      t = 'th'
      for row in data
        cols = ("<#{t}>#{x||''}</#{t}>" for x in row).join('')
        c.append $("<tr>#{cols}</tr>")
        c = tbody
        t = 'td'
