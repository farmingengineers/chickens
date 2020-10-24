// Generated by CoffeeScript 2.5.1
(function() {
  window.reportRenderers || (window.reportRenderers = {});

  reportRenderers.table = function(report, data) {
    var i, len, ref, renderRow, renderTd, renderTh, results, row, table, tbody, thead;
    table = $('<table></table>').appendTo(report);
    thead = $('<thead></thead>').appendTo(table);
    tbody = $('<tbody></tbody>').appendTo(table);
    renderRow = function(tag) {
      var after, before, between;
      before = `<tr><${tag}>`;
      between = `</${tag}><${tag}>`;
      after = `</${tag}></tr>`;
      return function(row) {
        return before + row.join(between) + after;
      };
    };
    renderTh = renderRow('th');
    renderTd = renderRow('td');
    thead.html(renderTh(data.column_names));
    ref = data.rows;
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      row = ref[i];
      results.push(tbody.append(renderTd(row)));
    }
    return results;
  };

}).call(this);