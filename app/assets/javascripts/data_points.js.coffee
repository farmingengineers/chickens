$ ->
  dataPointContainer = $('.data-point-entry')

  addDataPoint = ->
    n = dataPointContainer.children().length + 1
    lastDate = dataPointContainer.children().last().find('.js-data-point-date').val()
    html = """
           <div class="data-point">
             <input type="date" placeholder="2012-01-01" name="points[#{n}][date]" class="js-data-point-date" />
             <input type="number" step="0.001" placeholder="1" name="points[#{n}][quantity]" data-last-row="yes" class="js-data-point-quantity" />
           </div>
           """
    newPoint = $(html)
    if lastDate
      newPoint.find('.js-data-point-date').val(nextDate(lastDate))
    newPoint.hide().appendTo(dataPointContainer).slideDown()

  day = 1000 * 60 * 60 * 24
  week = day * 7
  nextDate = (date) ->
    try
      t = Date.parse(date)
      t += (if $('.js-frequency').val() == 'weekly' then week else day)
      d = new Date()
      d.setTime(t)
      "#{d.getUTCFullYear()}-#{zpad 1+d.getUTCMonth(), 2}-#{zpad d.getUTCDate(), 2}"
    catch e
      null
  zpad = (number, width) ->
    ((new Array(1 + width).join('0')) + number).slice(-width)

  dataPointContainer.on 'focus', 'input', (e) ->
    input = $ this
    if input.data('last-row') == 'yes'
      addDataPoint()
      input.data('last-row', 'no')

  dataPointContainer.on 'blur', '.js-data-point-quantity', (e) ->
    # If a quantity is filled in, require a date, too.
    q = $ this
    d = q.parent().find('.js-data-point-date')
    if q.val()
      d.attr('required', 'yes')
    else
      d.removeAttr('required')

  addDataPoint()
