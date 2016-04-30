$(document).ready(function() {
  $("#tabla tbody tr a").on("click",function() {
    var tr = $(this).closest('tr');
    tr.fadeOut(550, function(){
      tr.remove();
    });
    return false;
  });
});