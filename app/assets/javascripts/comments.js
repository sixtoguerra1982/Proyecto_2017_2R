document.addEventListener('turbolinks:before-cache', function(){
    $('#rating-form').raty('destroy');
    $('.comment-rating').raty('destroy');
});

document.addEventListener('turbolinks:load', function(){
    $('#rating-form').raty({
      path: '/assets/',
      scoreName: 'comment[rating]'
    });

    $('.comment-rating').raty({
      readOnly: true,
      score: function(){
        return $(this).attr('data-score');
      },
      path: '/assets/'
    });
});
