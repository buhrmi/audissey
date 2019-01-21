
positionBookingArea = ->
  scrollPosition = $(window).scrollTop()
  bookingColTop = $('.booking_col').offset()?.top;
  if $(window).width() > 768 && bookingColTop
    if scrollPosition >= bookingColTop
      $('.booking_area').css('top', scrollPosition - bookingColTop)
    else $('.booking_area').css('top', 0)
  else
    $('.booking_area').css('top', 0)

$(window).on 'scroll', positionBookingArea
$(window).on 'resize', positionBookingArea
