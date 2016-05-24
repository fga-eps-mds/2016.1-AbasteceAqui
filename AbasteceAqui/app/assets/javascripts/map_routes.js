function initMap() {
	var directionsDisplay = new google.maps.DirectionsRenderer;
	var directionsService = new google.maps.DirectionsService;  

	var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -33.7217175, lng: -55.0783226},
    zoom: 4
  });
  directionsDisplay.setMap(map);

  var onChangeHandler = function() {
    calculateAndDisplayRoute(directionsService, directionsDisplay);
  };

  var origin = document.getElementById('origin');
  var destination = document.getElementById('destination');

  var originBox = new google.maps.places.SearchBox(origin);
  var destinationBox = new google.maps.places.SearchBox(destination);

  map.controls[google.maps.ControlPosition.TOP_LEFT].push(origin);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(destination);

  map.addListener('bounds_changed', function() {
    searchBox.setBounds(map.getBounds());
  });

  originBox.addListener('places_changed', onChangeHandler);
  destinationBox.addListener('places_changed', onChangeHandler);
}


function calculateAndDisplayRoute(directionsService, directionsDisplay) {

	var origin = document.getElementById('origin').value;
  var destination = document.getElementById('destination').value;

  if (origin.length === 0 || destination.length === 0) {
  	return;
  }

  directionsService.route({
    origin: origin,
    destination: destination,
    travelMode: google.maps.TravelMode.DRIVING
  }, function(response, status) {
    if (status === google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });
}