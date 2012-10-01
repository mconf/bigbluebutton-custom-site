$(document).ready(function() {

  isModeratorSelected = function() {
    return $("#role option:selected").val() === "moderator";
  };

  $("#role").on("change", function() {
    return $("#password").toggle(isModeratorSelected());
  });
  $("#role").trigger("change");

  $("#join-submit").on("click", function(e) {
    e.preventDefault();
    $("#mobile").val(0);
    $(this).parent().submit();
  });

  $("#join-submit-mobile").on("click", function(e) {
    e.preventDefault();
    $("#mobile").val(1);
    $(this).parent().submit();
  });

});
