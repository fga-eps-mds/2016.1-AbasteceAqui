// initialize the map
function initMap() {

	const directionsDisplay = new google.maps.DirectionsRenderer;
	const directionsService = new google.maps.DirectionsService;  
  const brazilCoords = new google.maps.LatLng(-13, -55);

  // create a map centered in brazil  
	const map = new google.maps.Map(document.getElementById('map-container'), {
    center: brazilCoords,
    zoom: 4
  });

  // reference to how directions renderer works
  // https://developers.google.com/maps/documentation/javascript/directions#RenderingDirections
  directionsDisplay.setMap(map);

  // callback to when the user type a origin and a destination
  const onChangeHandler = function() {
    calculateAndDisplayRoute(directionsService, directionsDisplay, map);
  };

  // create the search boxes and link them to the UI elements.
  const origin = document.getElementById('origin');
  const originBox = new google.maps.places.SearchBox(origin);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(origin);

  const destination = document.getElementById('destination');
  const destinationBox = new google.maps.places.SearchBox(destination);
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(destination);

  // updated boxes limits
  map.addListener('bounds_changed', function() {
    originBox.setBounds(map.getBounds());
    destinationBox.setBounds(map.getBounds());
  });

  originBox.addListener('places_changed', onChangeHandler);
  destinationBox.addListener('places_changed', onChangeHandler);
}


// calculate and display a route
function calculateAndDisplayRoute(directionsService, directionsDisplay, map) {

	var origin = document.getElementById('origin').value;
  var destination = document.getElementById('destination').value;

  // check if user typed a origin and a destination
  if (origin.length === 0 || destination.length === 0) {
  	return;
  }

  // calc and display the route
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