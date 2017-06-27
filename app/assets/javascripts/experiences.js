alert("Entering Dropzone Javascript!!!!")

$(document).ready(function(){
  // disable auto discover
  Dropzone.autoDiscover = false;

  alert("Entering Dropzone function!!!!")
  var dropzone = new Dropzone (".dropzone", {
    maxFilesize: 256, // set the maximum file size to 256 MB
    paramName: "image[image_file_name]", // Rails expects the file upload to be something like model[field_name]
    addRemoveLinks: false // don't show remove links on dropzone itself.
  });

  dropzone.on("success", function(file) {
    this.removeFile(file);
    $.getScript("/images");
  })
});