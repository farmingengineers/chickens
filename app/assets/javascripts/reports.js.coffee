$ ->
  $('.report').each ->
    $.getJSON $(this).data('report'), (data) =>
      for reportType in this.classList
        if renderer = reportRenderers[reportType]
          renderer this, data
