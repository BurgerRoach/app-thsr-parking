$(function() {
  $(".restaurant-card").click((event) => {
    let target = event.currentTarget;
    let dataDom = $(target).find('.card-data')[0];

    // get lat
    let latDom = $(dataDom).find('.latitude')[0];
    let latValue = $(latDom).text();
    
    // get lng
    let lngDom = $(dataDom).find('.longtitude')[0];
    let lngValue = $(lngDom).text();

    // mark on googlemap
    const marker = new google.maps.Marker({
      map,
      position: { lat: latValue, lng: lngValue },
      animation: google.maps.Animation.DROP,
    });
  });
});