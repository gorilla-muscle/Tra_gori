document.addEventListener("turbo:load", function() {
  if (window.Chartkick) {
    Chartkick.eachChart(function(chart) {
      chart.redraw();
    });
  }
});