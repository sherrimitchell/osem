/** 
* Will call osem_update_room_events at the end of the current event
**/

$document.ready(function () {
  if ($('#current-event-info').length > 0) {
    setInterval(updateRoomEvents, 10000);
  }
});

function updateComments() {
  var article_id = $('#article').attr('data-id');
  if ($('.comment').length > 0) {
    var after = $('.comment:last').attr('data-time');
  }
  else {
    var after = 0;
  }
  
  $.getScript('/comments.js?article_id=' + article_id + "&after=" + after);
  setTimeout(updateComments, 10000);
}
There are other improvements we could make to th