
$(function() {
  $('.passage a').on('click', function(e) {
    e.preventDefault();

    $.get($(this).attr('href'), { async: true }, function(data) {
      $('.passage').html(data);

    });
  });
});
