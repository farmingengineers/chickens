$ ->
  enableButtons = -> $('.delete-submit').attr('disabled', $('form.edit-activities-form :checked').length == 0)

  $(document).on 'click', '.edit-activities', (e) ->
    $('.not-editing').removeClass('not-editing').addClass('editing')
    enableButtons()

  $(document).on 'click', '.done-editing-activities', (e) ->
    $('.editing').addClass('not-editing').removeClass('editing')
    $(':checked').attr('checked', false)

  $(document).on 'click', ':checkbox.editing', (e) ->
    enableButtons()
