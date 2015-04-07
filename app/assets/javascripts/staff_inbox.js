$(document).ready(function () {
  $('.inbox-item-ok').click(function (e) {
    e.preventDefault();
    var rowId = $(e.target).attr('line_item_id');
    $("#" + rowId).animate({
        height: '0px'
    }, {
        duration: 200,
        complete: function() {
            $(this).remove();
        }
    });
  });
});