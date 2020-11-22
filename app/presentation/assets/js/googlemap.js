function initMap(){
  let map = new google.maps.Map(document.getElementById("map"), {
    center: { lat: 24.7961217, lng: 120.9966699 },
    zoom: 15
  });

  const marker = new google.maps.Marker({
    map,
    position: { lat: 24.7961217, lng: 120.9966699 },
    animation: google.maps.Animation.DROP,
  });
}