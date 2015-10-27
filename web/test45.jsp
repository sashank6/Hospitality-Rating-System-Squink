<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">
    function calc(lat1,lon1,lat2,lon2)
    {
var origin = new google.maps.LatLng(lat1, lon1),
  destination = new google.maps.LatLng(lat2, lon2),
    service = new google.maps.DistanceMatrixService();

service.getDistanceMatrix(
    {
        origins: [origin],
        destinations: [destination],
        travelMode: google.maps.TravelMode.DRIVING,
        avoidHighways: false,
        avoidTolls: false
    }, 
    callback
);

function callback(response, status) {
    
    if(status=="OK") {
       alert( response.rows[0].elements[0].distance.text);
    } else {
        alert("Error: " + status);
    }
}
    }
    calc(17.7204096,83.3127108,17.7833319,83.3783304);
</script>
</head>
<body>
    <br>
    
</body>
</html>