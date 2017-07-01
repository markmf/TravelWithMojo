$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link)
  false
 
$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click')
 
$.rails.showConfirmDialog = (link) ->
  message = link.attr 'data-confirm'
  swal(
    title: "#{message}"
    type: 'warning'
    showCancelButton: true
    confirmButtonColor: '#4caf50'
    cancelButtonColor: '#f44336'
    confirmButtonText: 'Yes'
    cancelButtonText: 'Cancel').then (e) ->
      $.rails.confirmed link
      return