$(document).on('click', '.flash__close', function() {
  $('.flash').slideUp(200, function() {
    $(this).remove();
  });
  return false;
});
