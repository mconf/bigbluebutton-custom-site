$(document).ready(function() {

  isModeratorSelected = function() {
    return $("#role option:selected").val() === "moderator";
  };

  $("#role").on("change", function() {
    return $("#password").toggle(isModeratorSelected());
  });
  $("#role").trigger("change");

});
