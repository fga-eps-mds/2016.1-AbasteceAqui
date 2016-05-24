var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -33.7217175, lng: -55.0783226},
    zoom: 4
  });
}