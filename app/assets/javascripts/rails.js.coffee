$(document).on 'page:change', ->
  for el in $('.select2')
    $(el).select2()
  # $('select.buttons').buttons()
  $('.datepicker').daterangepicker
    singleDatePicker: true


$(document).on 'click', 'form .remove_fields', (event) ->
  $(this).prev('input[type=hidden]').val('1')
  $(this).closest('fieldset').hide()
  event.preventDefault()

$(document).on 'click', 'form .add_fields', (event) ->
  time = new Date().getTime()
  regexp = new RegExp($(this).data('id'), 'g')
  $(this).before($(this).data('fields').replace(regexp, time))
  event.preventDefault()




## VUE PATH EXPOSE EXTENSION: TODO: EXTRACT THIS
changeUrl = (paramName, paramValue) ->
  url = window.location.toString()
  pattern = new RegExp('\\b('+paramName+'=).*?(&|$)')
  if (url.search(pattern) >= 0)
    url.replace(pattern,'$1' + paramValue + '$2')
  else
    url + (if url.indexOf('?') > 0 then '&' else '?') + paramName + '=' + paramValue

findParam = (paramName) ->
  url = window.location.toString()
  pattern = new RegExp('\\b'+paramName+'=(.*?)(&|$)')
  result = pattern.exec(url)
  if result?.length >= 1
    return decodeURIComponent(result[1])

Vue.prototype.$expose = (path, param) ->
  self = this
  duringPopState = false
  newValue = findParam(param)
  self.$set(path, newValue) if newValue
  $(window).on 'popstate', ->
    duringPopState = true
    newValue = findParam(param)
    self.$set(path, newValue) if newValue
    self.$nextTick -> duringPopState = false
  this.$watch path, (val1, val2) ->
    return if duringPopState
    newUrl = changeUrl(param, val1)
    history.pushState(null, '', newUrl)
