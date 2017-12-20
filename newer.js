document.addEventListener("DOMContentLoaded", function() {

  recurse(100);

});


function recurse(times) {
  if (times > 0) {
    console.log("I am recursing!");
    recurse(times - 1);
  }
}
