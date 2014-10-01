// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

L.mapbox.accessToken = 'pk.eyJ1IjoiYWxleGVtc2xpZSIsImEiOiJLdjVSNFdBIn0.S95Ij0SopDQ_HjrDTb5KxQ';
map = L.mapbox.map('map', 'alexemslie.jl5lobkp').setView([37.792808, -122.402047], 15);

// Create a Foursquare developer account: https://developer.foursquare.com/
// NOTE: CHANGE THESE VALUES TO YOUR OWN:
// Otherwise they can be cycled or deactivated with zero notice.
var CLIENT_ID = '4FZWHTRM1SVKTMQBLAX5S2JTS0PA4PF15TKWYL2GZ45XJ0PW';
var CLIENT_SECRET = '4XAWGSX2WJXT250235S14U2EI0DEOM40V5GHUMD1P4W52YHZ';

// https://developer.foursquare.com/start/search
var API_ENDPOINT = 'https://api.foursquare.com/v2/venues/search' +
  '?client_id=CLIENT_ID' +
  '&client_secret=CLIENT_SECRET' +
  '&v=20130815' +
  '&ll=LATLON' +
  '&query=coffee' +
  '&callback=?';

// Keep our place markers organized in a nice group.
var foursquarePlaces = L.layerGroup().addTo(map);

// Use jQuery to make an AJAX request to Foursquare to load markers data.
$.getJSON(API_ENDPOINT
    .replace('CLIENT_ID', CLIENT_ID)
    .replace('CLIENT_SECRET', CLIENT_SECRET)
    .replace('LATLON', map.getCenter().lat +
        ',' + map.getCenter().lng), function(result, status) {

    if (status !== 'success') return alert('Request to Foursquare failed');

    // Transform each venue result into a marker on the map.
    for (var i = 0; i < result.response.venues.length; i++) {
      var venue = result.response.venues[i];
      var latlng = L.latLng(venue.location.lat, venue.location.lng);
      var marker = L.marker(latlng, {
          icon: L.mapbox.marker.icon({
            'marker-color': '#BE9A6B',
            'marker-symbol': 'cafe',
            'marker-size': 'large'
          })
        })
      .bindPopup('<strong><a href="https://foursquare.com/v/' + venue.id + '">' +
        venue.name + '</a></strong>')
        .addTo(foursquarePlaces);
    }

});
