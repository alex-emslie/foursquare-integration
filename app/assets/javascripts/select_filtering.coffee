replace_select = (context, clone) ->
  value = context.val()
  details = context.siblings('.details_select')
  details.replaceWith(clone.clone())

  context.siblings('.details_select').find('option').each (index) ->
    if !$(this).hasClass(value)
      $(this).remove()

$ ->
  if $('.details_select').length
    clone = $('.details_select').clone()
    $('.type_select').each (index) ->
      replace_select($(this), clone)
    $('.type_select').on 'change', (e) ->
      replace_select($(this), clone)
