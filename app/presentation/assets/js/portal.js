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

    if (selectedStationName == '桃園') {
      updateStationInfo('https://i.imgur.com/CBgoTja.jpg', '桃園高鐵站', '航空城青埔人');
    } else if (selectedStationName == '新竹') {
      updateStationInfo('https://storage.googleapis.com/smiletaiwan-cms-cwg-tw/article/201808/article-5b7a9d363047d.jpg', '新竹高鐵站', '微笑台灣');
    } else if (selectedStationName == '苗栗') {
      updateStationInfo('https://m.thsrc.com.tw/ArticleContent/e8fc2123-2aaf-46ff-ad79-51d4002a1ef3/assets/639935cc-b08d-4efe-86a9-3dd9f68a0eb2.jpg', '苗栗高鐵站', '台灣高鐵');
    } else if (selectedStationName == '台中') {
      updateStationInfo('https://www.rb.gov.tw/public/files/artsinfo/1576133676-m3.jpg', '台中高鐵站', '交通部鐵道局');
    } else if (selectedStationName == '彰化') {
      updateStationInfo('https://i.ytimg.com/vi/9R3uYZWlyJc/maxresdefault.jpg', '彰化高鐵站', 'BENNY BABU');
    } else if (selectedStationName == '雲林') {
      updateStationInfo('https://photo.travelking.com.tw/scenery/41FB8DDA-5243-45B9-8AA8-72DE25928422_e.jpg', '雲林高鐵站', 'Travek King');
    } else if (selectedStationName == '嘉義') {
      updateStationInfo('https://www.thsrc.com.tw/ArticleContent/60831846-f0e4-47f6-9b5b-46323ebdcef7/assets/36c8f9a3-ebc6-4949-aa03-ec05626aef8b.jpg', '嘉義高鐵站', '台灣高鐵');
    } else if (selectedStationName == '台南') {
      updateStationInfo('https://s.newtalk.tw/album/news/132/5b4d8ed78ed34.jpg', '台南高鐵站', '頭殼網');
    } else if (selectedStationName == '高雄') {
      updateStationInfo('https://upload.wikimedia.org/wikipedia/commons/c/cb/HSR_Zuoying_Station.JPG', '高雄高鐵站', '維基百科');
    }


    // $.ajax(
    //   {
    //       url: "/get_city",
    //       type: 'GET',
    //       data: {
    //           "city_name": selectedStationName,
    //       },
    //       success: function (city_data)
    //       {
    //         city_data = JSON.parse(city_data);
    //         updateStationInfo(city_data['img_src'], city_data['name']+'高鐵站', city_data['credit']);
    //       }
    //   });
  });

  
  // click search btn
  $('.thsr-station-section .content-action .action-btn').click(function(event) {
    var text = $('.content-text').text();
    text = text.replace('高鐵站', '');
    baseUrl = '/result/city?city_name=';
    window.location.href = baseUrl + text;
  });
});