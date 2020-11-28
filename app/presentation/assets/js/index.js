$(function() {
  // header logo
  $(".header-logo").click(() => {
    window.location.href = '/';
  });

  // search dropdown
  $('.ui.dropdown.label').dropdown('setting', 'onChange', function(){
    // clean search text
    $('.content-action input.action-input').val('');

    let modeText = $('.ui.dropdown.label .text').text();
    console.log(modeText);
    if (modeText == 'Park Id') {
      $('.content-action input.action-input').attr("placeholder", "e.g. 2500");
    } else if (modeText == 'City Name') {
      $('.content-action input.action-input').attr("placeholder", "e.g. 新竹");
    }
  });

  // go search
  // let modeMapper = (text) => {
  //   if (text == 'Park Id') {
  //     return 'by_park_id'
  //   } else if (text == 'City Name') {
  //     return 'by_city_name'
  //   }
  // }

  // $('.action-btn').click(() => {
  //   let modeText = $('.ui.dropdown.label .text').text(); // Park Id or City Name
  //   let mode = modeMapper(modeText);
  //   console.log(mode);

  //   let searchText = $('.content-action input.action-input').val();
  //   if (mode == 'by_park_id') {
  //     baseUrl = '/result/park?park_id=';
  //     window.location.href = baseUrl + searchText;
  //   } else if (mode == 'by_city_name') {
  //     baseUrl = '/result/city?city_name=';
  //     window.location.href = baseUrl + searchText;
  //   }
  // });

  // result page click card func
  $(".thsr-park-result-card").click(function(event) {
    park_id = event.currentTarget.id;
    baseUrl = '/detail?park_id=';
    window.location.href = baseUrl + park_id;
  });

  // detail page - rating
  // $('.ui.rating').each(function() {
  //   $(this).rating('disable');
  // });
  $('.ui.rating').rating('disable');

  $('.message .close')
  .on('click', function() {
    $(this)
      .closest('.message')
      .transition('fade')
    ;
  });
});