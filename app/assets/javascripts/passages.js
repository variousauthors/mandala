
$(function() {
  $('.passage a.title').on('click', function(e) {
    e.preventDefault();

    $.get($(this).attr('href'), function(data) {
      $('.passage').html(data);

    });
  });

  $('.passage a.keyword').on('click', function(e) {
    e.preventDefault();
    var that = this;

    if ( $(this).hasClass('clicked') ) {
      console.log($(this).children())
      $(this).siblings('p').remove();

    } else {
      $.get("/details" + $(this).attr('href'), function(data) {
          $(that).parent().append(data);
      });
    }

    $(this).toggleClass('clicked');
  });
});
