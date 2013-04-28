
$(function() {
  $('.passage a.title').on('click', function(e) {
    e.preventDefault();

    $.get('/' + $(this).attr('href'), function(data) {
      $('.passage').html(data);

    });
  });

  $('.passage a.keyword').on('click', function(e) {
    e.preventDefault();
    var that = this;
    var keyword = $(this).attr("href");

    if ( $(this).hasClass('clicked') ) {
      $(this).siblings('p.' + keyword).remove();

    } else {
      $.get("/details" + '/' + $(this).attr('href'), function(data) {
        var hey = $(that).parent().append(data);
      });
    }

    $(this).toggleClass('clicked');
  });
});
