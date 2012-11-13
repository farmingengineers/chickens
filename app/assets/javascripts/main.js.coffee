$ ->
  $('textarea').TextAreaExpander()

  $(document).on 'click', '.js-start-editing', (e) ->
    $(this).closest('.not-editing').addClass('editing').removeClass('not-editing')

  $(document).on 'click', '.js-finish-editing', (e) ->
    $(this).closest('.editing').addClass('not-editing').removeClass('editing')

  $(document).on 'click', '.delete-button', (e) ->
    $(this).closest('.deletable').addClass('deleting')

  $(document).on 'ajax:complete', '.delete-button', (e) ->
    $(this).closest('.deletable').removeClass('deleting')

  $(document).on 'ajax:success', '.delete-button', (e) ->
    $(this).closest('.deletable').addClass('deleted')
