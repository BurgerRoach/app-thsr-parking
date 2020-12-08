$(function() {
  $(".thsr-jumbotron .content-action .action-btn").click(function (e){
    e.preventDefault();

    $('html, body').animate({
        scrollTop: $('.thsr-station-section').offset().top
    }, 1000, 'swing');
  });



  // station menu
  $('.thsr-station-menu').on('click', '.item', function() {
    $(this).addClass('active');
    $(this).siblings('.item').removeClass('active');

    var selectedStationName = $(this).text();
    // baseUrl = '/?city_name=';
    // window.location.href = baseUrl + selectedStationName;

    let updateStationInfo = (imgSrc, stationName, photoBy) => {
      // update img
      var imageDom = $('.station-img');
      imageDom.fadeOut(200, function () {
        imageDom.attr('src', imgSrc);
        imageDom.fadeIn('fast');
      });

      // update text
      var textDom = $('.content-text');
      textDom.text(stationName)

      // update sub-text
      var subTextDom = $('.content-sub-text');
      subTextDom.text('photo by ' + photoBy)
    }

    $.ajax(
      {
          url: "/get_city",
          type: 'GET',
          data: {
              "city_name": selectedStationName,
          },
          success: function (city_data)
          {
            city_data = JSON.parse(city_data);
            updateStationInfo(city_data['img_src'], city_data['name']+'高鐵站', city_data['credit']);
          }
      });
  });

  
  // click search btn
  $('.thsr-station-section .content-action .action-btn').click(function(event) {
    var text = $('.content-text').text();
    text = text.replace('高鐵站', '');
    baseUrl = '/result/city?city_name=';
    window.location.href = baseUrl + text;
  });
});