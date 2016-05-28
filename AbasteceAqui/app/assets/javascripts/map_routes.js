let routeCoords;
let routeCities = new Set();

// initialize the map
function initMap() {

	const directionsDisplay = new google.maps.DirectionsRenderer;
	const directionsService = new google.maps.DirectionsService;  
  const geocoder = new google.maps.Geocoder;
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
    calculateAndDisplayRoute(directionsService, directionsDisplay, map, function(){
      findCitiesOfRoute(geocoder,map, routeCoords);
    });
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

  var addPinsButton = document.getElementById("add-pins");
  addPinsButton.addEventListener("click", function() {
    alert('Not finished');
  });

}

// calculate and display a route
function calculateAndDisplayRoute(directionsService, directionsDisplay, map, findCities) {

	const origin = document.getElementById('origin').value;
  const destination = document.getElementById('destination').value;

  // check if user typed a origin and a destination
  // duplicated, refactor
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
      routeCoords = response.routes[0].overview_path;
      findCities();
    } else {
      window.alert('Directions request failed due to ' + status);
    }
  });

}

// find the address of a coord
function geocodeLatLng(geocoder, map, latlng) {

  // start reverse geocoder with the given coords
  geocoder.geocode({'location': latlng}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      if (results[0]) {
        var address_components = results[0].address_components;

        // for each address_components
        for (var i = 0; i < address_components.length; i++) {

          if (address_components[i].types[0] === "locality" || 
              address_components[i].types[0] === "administrative_area_level_2") {

            let city = address_components[i].long_name;

            for (var j = 0; j < address_components.length; j++) {

              if (address_components[j].types[0] == "administrative_area_level_1") {

                city = city + ", " + address_components[j].long_name;

                if (!routeCities.has(city)){
                  routeCities.add(city);
                }
              }
            }
          }
        }
      } else {
        window.alert('No results found');
      }
    } else {
      if (status === google.maps.GeocoderStatus.OVER_QUERY_LIMIT) {
        // if over query limit, try again in 200ms
        setTimeout(geocodeLatLng, 200, geocoder, map, latlng);
      } else {
        window.alert('Geocoder failed due to: ' + status);
      }
    }
  });
  console.log(".");
}

// Find cities of a route
function findCitiesOfRoute(geocoder, map, routeCoords) {

  const origin = document.getElementById('origin').value;
  const destination = document.getElementById('destination').value;

  // check if user typed a origin and a destination
  // duplicated, refactor
  if (origin.length === 0 || destination.length === 0) {
    return;
  }

  // 5% of routecoords lenght rounded down
  const adder = Math.floor(routeCoords.length * 0.05);

  for (var i = 0; i < routeCoords.length; i += adder) {
    setTimeout(geocodeLatLng, 200 * i, geocoder, map, routeCoords[i]);
  }
}