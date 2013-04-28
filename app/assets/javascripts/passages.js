
$(function() {
  $(document).on('click', '.passage a.title', function(e) {
    e.preventDefault();

    $.get('/' + $(this).attr('href'), function(data) {
      $('.passage').parent().html(data);

    });
  });

  $(document).on('click', '.passage a.keyword',  function(e) {
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
