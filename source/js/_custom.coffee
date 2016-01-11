#Loader =============================================================================
do ->
  $(window).load ->
    $(".loader").delay(1000).fadeOut("slow")


#Redirect ===========================================================================
do ->
  if $(window).width() <= 1200
    window.location = "http://www.apple.com/itunes/"


#Parralexjs custom ====================================================================
do ->
  $('.scene').parallax
    calibrateX: true,
    calibrateY: true,
    invertX: false,
    invertY: true,
    limitX: false,
    limitY: false,
    scalarX: 2,
    scalarY: 10,
    frictionX: 0.5,
    frictionY: 0.5,
    originX: 0.0,
    originY: 1.0

  $('.scene--left').parallax
    calibrateX: true,
    calibrateY: true,
    invertX: true,
    invertY: true,
    limitX: false,
    limitY: false,
    scalarX: 2,
    scalarY: 10,
    frictionX: 1,
    frictionY: 1,
    originX: 0.0,
    originY: 1.0


#Fullpagejs custom ===========================================================================
do ->
  $(document).ready ->
    $('#fullpage').fullpage
      menu: '#myMenu'
      lockAnchors: false
      navigation: false
      anchors: [ '' ]
      navigationPosition: 'right'
      navigationTooltips: [
        'firstSlide'
        'secondSlide'
        'thirdSlide'
        '4thSlide'
      ]
      showActiveTooltip: false
      slidesNavigation: true
      slidesNavPosition: 'bottom'
      css3: true
      scrollingSpeed: 700
      autoScrolling: true
      fitToSection: true
      scrollBar: false
      easing: 'easeInOutCubic'
      easingcss3: 'ease'
      loopBottom: false
      loopTop: false
      loopHorizontal: false
      continuousVertical: false
      normalScrollElements: '#element1, .element2'
      scrollOverflow: false
      touchSensitivity: 15
      normalScrollElementTouchThreshold: 5
      keyboardScrolling: true
      animateAnchor: true
      recordHistory: true
      controlArrows: false
      verticalCentered: true
      resize: false
      sectionsColor: []
      paddingTop: '3em'
      paddingBottom: '10px'
      fixedElements: '#header, .footer'
      responsiveWidth: 1200
      responsiveHeight: 0
      sectionSelector: '.section'
      slideSelector: '.slide'
      onLeave: (index, nextIndex, direction) ->
      afterLoad: (anchorLink, index) ->
      afterRender: ->

        #horizontal movement with mousewheel
        if $(window).width() > 1200
          $('body').on 'DOMMouseScroll mousewheel', (e) ->
            if e.originalEvent.detail > 0 or e.originalEvent.wheelDelta < 0
        #alternative options for wheelData: wheelDeltaX & wheelDeltaY
        #scroll down
              $.fn.fullpage.moveSlideRight()
            else
        #scroll up
              $.fn.fullpage.moveSlideLeft()
            #prevent page fom scrolling vertical
            false
        #interval between page slides to the right

        ###setInterval(function () {
            $.fn.fullpage.moveSlideRight();
        }, 30000);
        ###

        return
      afterResize: ->
      afterSlideLoad: (anchorLink, index, slideAnchor, slideIndex) ->

        ###"phone" videos are changing with slides###

        $('.mobile div video').eq(slideIndex).addClass('opacity--1').attr('autoplay', '').siblings().removeClass('opacity--1').removeAttr('autoplay').load()
        if slideIndex == 1

          ###scene class elements animating in###

          $('[data-load="slide2"]').each (i) ->
            setTimeout (->
              $('[data-load="slide2"]').eq(i).css
                'margin-top': 0
                'opacity': 1
              return
            ), 75 * (i + 1)
            return
        if slideIndex == 2
          $('#vbg1').fadeOut 'fast'
          $('#vbg2').fadeIn 'fast'
          $('[data-load="slide3"]').each (i) ->
            setTimeout (->
              $('[data-load="slide3"]').eq(i).css
                'margin-top': 0
                'opacity': 1
              return
            ), 75 * (i + 1)
            return
        if slideIndex == 3
          $('.mobile').addClass('opacity--0').css 'z-index': '0'
          $('#vbg2').fadeIn 'slow'
          $('#vbg1').fadeOut 'slow'
          $('div.subscribe [data-load]').each (i) ->
            setTimeout (->
              $('div.subscribe [data-load]').eq(i).css 'transform': 'translateY(0)'
              return
            ), 100 * (i + 1)
            return
        return
      onSlideLeave: (anchorLink, index, slideIndex, direction, nextSlideIndex) ->
        if slideIndex == 0 and direction == 'right' or slideIndex == 2 and direction == 'left'
          $('[data-load="slide2"]').each (i) ->
            setTimeout (->
              $('[data-load="slide2"]').eq(i).css
                'margin-top': 0
                'opacity': 1
              return
            ), 75 * (i + 1)
            return
        if slideIndex == 1 and direction == 'right'
          $('#vbg2').fadeIn 'fast'
          $('#vbg1').fadeOut 'fast'
          $('[data-load="slide3"]').each (i) ->
            setTimeout (->
              $('[data-load="slide3"]').eq(i).css
                'margin-top': 0
                'opacity': 1
              return
            ), 75 * (i + 1)
            return
        else if slideIndex == 2 and direction == 'right'
          $('.mobile').css 'transform': 'translateX(-1500px)'
          $('div.subscribe [data-load]').each (i) ->
            setTimeout (->
              $('div.subscribe [data-load]').eq(i).css 'transform': 'translateY(0)'
              return
            ), 100 * (i + 1)
            return
        else if slideIndex == 2 and direction == 'left'
          $('#vbg2').fadeOut 'fast'
          $('#vbg1').fadeIn 'fast'
        else if slideIndex == 3 and direction == 'left'
          setTimeout (->
            $('.mobile').css(
              'transform': 'translateX(0)'
              'z-index': '20').removeClass 'opacity--0'
            return
          ), 500
          $('[data-load="slide3"]').each (i) ->
            setTimeout (->
              $('[data-load="slide3"]').eq(i).css
                'margin-top': 0
                'opacity': 1
              return
            ), 75 * (i + 1)
            return
        return
    return


#Form validation =====================================================================================================
do ->
  $('[data-submit="submit"]').click ->
    emailField = $('[data-mail="input"]').val()
    emailFilter = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
    if $.trim(emailField) == ''
      swal 'Error!', 'Please fill out email field!', 'error'
      false
    else if !emailFilter.test(emailField)
      swal 'Error!', 'Please enter a valid email address!', 'error'
      false
    else
      swal 'Success!', 'Email sent!', 'success'
      true


#Form sending =====================================================================================================
do ->
  $('.form').on 'submit', ->
    data = {}
    $(this).find('[name]').each (index, value) ->
      name = $(this).attr('name')
      value = $(this).val()
      data[name] = value
      return
    $.ajax
      url: '//formspree.io/' + 'info' + '@' + 'mindpeace' + '.' + 'eu'
      method: 'POST'
      data: data
      dataType: 'json'
    $('.form').trigger 'reset'
    false