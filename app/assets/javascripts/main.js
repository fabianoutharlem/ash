/**
 * Created by menno on 15/02/16.
 */
$(document).ready(function () {

    //header overlays & popups
    //newsletter_popup ->show
    var content_box = $('div.popup_newsletter div.content');
    var overlay = $('div.popup_newsletter');
    var registered_massege = $('div.popup_newsletter div.registered');

    $('.newsletter_form').click(function () {
        overlay.addClass('active animated fadeIn');
        var t = setTimeout(function () {
            content_box.addClass('active animated fadeInUp');
        }, 700);
    });

    //newsletter_popup ->show
    $('div.popup_newsletter div.cross').click(function () {

        content_box.removeClass('fadeInUp').addClass('fadeOutDown');

        var t = setTimeout(function () {
            content_box.removeClass('active fadeOutDown');
        }, 700);

        var t2 = setTimeout(function () {
            overlay.removeClass('fadeIn').addClass('fadeOut');

            var t3 = setTimeout(function () {
                overlay.removeClass('active fadeOut');
            }, 700);
        }, 700);
    });

    //newsletter_popup -> registerd message
    $('div.popup_newsletter .send_btn').click(function () {
        content_box.removeClass('fadeInUp').addClass('fadeOutDown');

        var tr1 = setTimeout(function () {
            registered_massege.addClass('active animated fadeInUp');
            content_box.removeClass('active fadeOutDown')
        }, 700);

        var tr2 = setTimeout(function () {
            registered_massege.removeClass('fadeInUp').addClass('fadeOutDown');

            var t3 = setTimeout(function () {
                registered_massege.removeClass('active fadeOutDown');
                content_box.addClass('fadeInUp active');
            }, 700);
        }, 4500);
    });


    //homepage
    var section_header = $('section.header');

    $("li[data-submenu]", section_header).mouseenter(function () {
        if ($(this).hasClass('active')) return;

        $(this).addClass('active');

        var sub_menu_class = $(this).data('submenu');
        $('div.sub_menu.' + sub_menu_class).addClass('active');
    });

    $("ul.menu li, ul.search li", section_header).mouseleave(function (event) {
        var toElem = $(event.toElement);
        console.log(toElem);
        var sub_menu_class = $(this).data('submenu');
        if (toElem.closest('.' + sub_menu_class).hasClass(sub_menu_class)) return; // Prob nicer way to do this...point is to check if mouse enters a submenu, and if so stay open.
        // Close all open submenues, e.g.
        $('div.sub_menu, li[data-submenu]', section_header).removeClass('active');
    });

    $('div.sub_menu', section_header).mouseleave(function (event) {
        var toElem = $(event.toElement);
        var menu_name = $(this).data('menu');
        console.log(toElem, toElem.closest("ul.menu, ul.search"));
        if (toElem.closest("ul.menu li[data-submenu], ul.search li[data-submenu]").data('submenu') == menu_name) return; // Check if entering main menu
        // Close all open submenues, e.g.
        $('div.sub_menu, li[data-submenu]', section_header).removeClass('active');
    });


    //smartphone_menu
    $('section.header div.smartphone_menu, section.header ul.search').click(function () {
        $('section.header div.smartphone_menu').toggleClass('active');
        $('section.header div.smartphone').toggleClass('active');

    });

    //smartphone_menu expand menus
    $('section.header div.smartphone li.smartmenu').click(function () {
        $(this).toggleClass('active');
        $(this).find('div.expand').toggleClass('active');
    });

    //$('section.header ul.search li').click(function () {
    //    $('section.header div.smartphone').addClass('active');
    //
    //    var smart_menu_id = $(this).data('smartmenus');
    //    $('section.header div.smartphone li').filter('.' + smart_menu_id).toggleClass('active');
    //});


    //footer_menu
    //smartphone footer_menu
    $('section.footer section.footer_smart ul.menu li.expand_menu').click(function () {
        $(this).toggleClass('active');
        $(this).find('div.expand').toggleClass('active');
    });


    //homepage main_slider  //exclusief main slider //budget slider
    $('.my-slider').unslider({
        arrows: {
            //  Unslider default behaviour
            prev: '<a class="unslider-arrow prev"><img src="assets/nav_prev_carousel.png" alt=""></a>',
            next: '<a class="unslider-arrow next"><img src="assets/main_slider_next.png" alt=""></a>',
        },

        autoplay: false,
        delay: 5000,
        nav: true,
        infinite: true
    });

    //homepage main_slider > ticker
    $('.marquee').marquee({
        duplicated: true,
        pauseOnHover: true,
        speed: 15000,
        startVisible: true
    });

    //homepage select2
    $('.search_dropdown').select2({
        minimumResultsForSearch: Infinity
    });

    //filter
    $('.cars_filter_select').select2({
        minimumResultsForSearch: Infinity
    });

    //homepage price slider
    var showLabel = function (event, ui) {
        var target = $(this).parents('.slider_col').find('small.label');
        var input = $(this).parents('.slider_col').find('input.amount');
        if (input.val()) {
            $(this).slider('value', input.val());
        }
        var curValue = ui.value || $(this).slider("option", "value");
        var tooltip = '€' + curValue + ',- p.m.';
        $(target).html(tooltip);
        input.val(curValue).trigger('change');
    };

    $(".slider_maand_financieren").slider({
        min: 0,
        max: 2000,
        range: "min",
        value: 200,
        step: 10,
        slide: showLabel,
        create: showLabel
    });

    $(".slider_buy_financieren").slider({
        min: 0,
        max: 75000,
        range: "min",
        value: 15000,
        step: 500,
        slide: showLabel,
        create: showLabel
    });

    $(".slider_maand_kopen").slider({
        min: 0,
        max: 2000,
        range: "min",
        value: 200,
        step: 10,
        slide: showLabel,
        create: showLabel
    });

    $(".slider_buy_kopen").slider({
        min: 0,
        max: 75000,
        range: "min",
        value: 15000,
        step: 500,
        slide: showLabel,
        create: showLabel
    });

    //homepage overlay taxeren
    var overlay = $('section.like_ons div.overlay_taxation');

    $('section.like_ons .taxation_btn').click(function () {
        overlay.addClass('active fadeIn');
    });

    $('section.like_ons div.overlay_taxation div.cross').click(function () {
        overlay.removeClass('fadeIn')
        overlay.addClass('fadeOut');

        var t = setTimeout( function() {
            overlay.removeClass('active fadeOut');
        }, 500);
    });

    //homepage banner carousel

    //voorraad_pagina price sliders
    $("#buy_slider_to").slider({
        min: 0,
        max: 50000,
        range: "min",
        value: 21000,
        slide: showLabel,
        create: showLabel
    });

    $("#buy_slider_month").slider({
        min: 0,
        max: 2000,
        range: "min",
        value: 219,
        slide: showLabel,
        create: showLabel
    });

    $("#finance_slider_to").slider({
        min: 0,
        max: 50000,
        range: "min",
        value: 21000,
        slide: showLabel,
        create: showLabel
    });

    $("#finance_slider_month").slider({
        min: 0,
        max: 2000,
        range: "min",
        value: 219,
        slide: showLabel,
        create: showLabel
    });

    //homepage carousel
    var owl = $('#owl2row-plugin');
    owl.owlCarousel({
        nav: true,
        owl2row: true, // enable plugin
        owl2rowTarget: 'item',    // class for items in carousel div
        owl2rowContainer: 'owl2row-item', // class for items container
        owl2rowDirection: 'utd', // ltr : directions
        dots: true,
        //items: 4,
        navText: [' ', ' '],
        slideBy: 4,
        items: 4,
        navContainer: '.nav_container',
        responsive: {
            0: {
                items: 1,
                slideBy: 1,
                dots: false
            },
            700: {
                items: 2,
                slideBy: 2
            },
            1040: {
                items: 3,
                slideBy: 3
            },
            1281: {
                items: 4
            },
        }
    });

    owl.on('changed.owl.carousel', function (event) {
        if (event.item.count - event.page.size == event.item.index)
            $(event.target).find('.owl-dots div:last')
                .addClass('active').siblings().removeClass('active');
    });

    //homepage _article_car slider
    $('.article_car .car_slider').unslider({
        autoplay: false,
        nav: false,
        arrows: false,
        infinite: true
    });

    //homepage banner slider
    $('#banner_carousel').lightSlider({
        item: 1,
        slideMove: 1,
        auto: true,
        pauseOnHover: true,
        loop: true,
        speed: 400,
        pause: 5000
    });


    //detail pagina

    //model slider
    $('.auto_uitgelicht .car_slider').unslider({
        autoplay: false,
        delay: 5000,
        arrows: {
            prev: '<a class="unslider-arrow prev"><img src="../assets/nav_prev_carousel.png" alt=""></a>',
            next: '<a class="unslider-arrow next"><img src="../assets/main_slider_next.png" alt=""></a>',
        },
        nav: false,
        infinite: true
    });

    //afspraak_car_slider
    $('.car_slider_afspraak').unslider({
        autoplay: false,
        delay: 5000,
        arrows: false,
        infinite: true
    });

    //afspraak_maken button click overlay visible
    var afspraak_overlay = $('section.auto_uitgelicht .overlay_afspraak');

    $('section.auto_uitgelicht div.model .appointment_btn, section.auto_uitgelicht a.appointment_btn').click(function () {
        afspraak_overlay.addClass('fadeIn active');
    });

    $('section.auto_uitgelicht div.overlay_afspraak img.cross').click(function () {
        afspraak_overlay.removeClass('fadeIn');
        afspraak_overlay.addClass('fadeOut');

        var timeOut = setTimeout(function () {
            afspraak_overlay.removeClass('active fadeOut');
        }, 600);
    });

    //financier button click overlay visible
    var financier_overlay = $('section.auto_uitgelicht .overlay_financier');

    $('section.auto_uitgelicht div.model .finance_btn').click(function () {
        financier_overlay.addClass('active fadeIn');
    });

    $('section.auto_uitgelicht .overlay_financier img.cross').click(function () {
        financier_overlay.addClass('fadeOut');
        financier_overlay.removeClass('fadeIn');

        var timeOut = setTimeout(function () {
            financier_overlay.removeClass('active fadeOut');
        }, 600);
    });


    //specificaties tabs
    var section_spec_tabs = $('section.spec_tabs'),
        spec_tabs_items = $('div[data-submenu]', section_spec_tabs);

    spec_tabs_items.on('click', function () {
        spec_tabs_items.not($(this)).removeClass('active');
        $(this).addClass('active');

        var submenu_id = $(this).data('submenu'),
            submenus = $('div.tabs', section_spec_tabs),
            active_submenu = submenus.filter('.' + submenu_id);

        submenus.not(active_submenu).removeClass('active');
        active_submenu.addClass('active');
    });

    //zoek_nu tabs
    var select_tabs_items = $('section.zoek_nu div.tab');

    select_tabs_items.on('click', function () {
        select_tabs_items.not(this).removeClass('active');
        $(this).addClass('active');

        var submenu_id = $(this).data('submenu'),
            submenus = $('section.car_search'),
            active_submenus = submenus.filter('.' + submenu_id);

        submenus.not(active_submenus).removeClass('active');
        active_submenus.addClass('active');
    });

    //meer opties (orange) button 360 formaat tab acessoires
    var more_btn = $('section.spec_tabs div.accesoires div.more');
    more_btn.click(function () {
        $('section.spec_tabs div.accesoires li').addClass('active');
        more_btn.hide();
    });

    //alle fotos (tab photos)
    var more_btn = $('section.spec_tabs div.photos div.more');
    more_btn.click(function () {
        $('section.spec_tabs div.photos li').toggleClass('show_all');
        $('section.spec_tabs div.photos div.more span.plus, section.spec_tabs div.photos div.more span.min').toggleClass('active');
    });

    //overlay_photo_selection slider
    var car_thumb_slider = $('#lightSlider').lightSlider({
        item: 1,
        gallery: true,
        enableTouch: true,
        enableDrag: true,
        adaptiveHeight: true,
        speed: 250,
        galleryMargin: 20,
        pager: true,
        responsive: [
            {
                breakpoint: 880,
                settings: {
                    thumbItem: 7
                }
            },

            {
                breakpoint: 600,
                settings: {
                    thumbItem: 5
                }
            }
        ],
        onSliderLoad: function (el) {
            el.lightGallery({
                selector: '#lightSlider'
            });
        }
    });

    //overlay_photo_selection vissible
    $('section.spec_tabs div.photos li').click(function () {
        car_thumb_slider.goToSlide($(this).index());

        var timer = setTimeout(function () {
            $('section.spec_tabs div.overlay_photo_selection').addClass('active fadeIn');
        }, 250);
    });
    //overlay_photo_selection hide
    $('section.spec_tabs div.overlay_photo_selection div.cross').click(function () {
        $('section.spec_tabs div.overlay_photo_selection').addClass('fadeOut')
        $('section.spec_tabs div.overlay_photo_selection').removeClass('fadeIn');

        var t = setTimeout(function() {
            $('section.spec_tabs div.overlay_photo_selection').removeClass('fadeOut active');
        }, 500);
    });


    //detail page carousel  //exclusief smartphone carousel
    var owl = $('#owl2row-plugin1');
    owl.owlCarousel({
        nav: true,
        owl2row: false, // enable plugin
        owl2rowTarget: 'item',    // class for items in carousel div
        owl2rowContainer: 'owl2row-item', // class for items container
        owl2rowDirection: 'utd', // ltr : directions
        dots: true,
        //items: 4,
        navText: [' ', ' '],
        slideBy: 4,
        items: 4,
        navContainer: '.nav_container',
        responsive: {
            0: {
                items: 1,
                slideBy: 1,
                dots: false
            },
            700: {
                items: 2,
                slideBy: 2,
            },
            1040: {
                items: 3,
                slideBy: 3,
            },
            1281: {
                items: 4
            },
        }
    });

    owl.on('changed.owl.carousel', function (event) {
        if (event.item.count - event.page.size == event.item.index)
            $(event.target).find('.owl-dots div:last')
                .addClass('active').siblings().removeClass('active');
    });

    //voorraad

    //voorraad_pagina compare section
    var compare_section =  $('section.select_compare div.compare_selection');

    $('section.select_compare div.compare_btn').click( function() {
        compare_section.toggleClass('active fadeIn');
        $('article.article_car').toggleClass('compare_active');
    });

    $('section.select_compare div.start_compare div.remove_cross').click(function() {
        compare_section.removeClass('fadeIn');
        $('article.article_car').removeClass('compare_active');
        compare_section.addClass('fadeOut');

        setTimeout(function() {
            compare_section.removeClass('active fadeOut');
        }, 200);
    });

          //compare remove cars from list
    $('section.select_compare div.compare_selection li div.remove_cross').click(function () {
        var list_item =  $(this).parent('li');

        list_item.remove();
    });

    //left menu filters tab active
    var data_searchfield = $(this).data('searchfield'),
        searchfield = $('section.all_cars div.search_fields');

    $('section.all_cars div.left div.tab').click(function () {
        $('section.all_cars div.left div.tab').removeClass('active');
        $(this).addClass('active');

        searchfield.removeClass('active');
        searchfield.filter('.' + $(this).data('searchfield')).addClass('active');
    });

    //left menu tab search _field koppeling

    //partial zekerheden carousel
    var owl = $('.owl_carousel_zekerheden');
    owl.owlCarousel({
        nav: true,
        owl2row: false, // enable plugin
        owl2rowTarget: 'item',    // class for items in carousel div
        owl2rowContainer: 'owl2row-item', // class for items container
        owl2rowDirection: 'utd', // ltr : directions
        dots: true,
        //items: 4,
        navText: [' ', ' '],
        slideBy: 4,
        items: 4,
        navContainer: '.nav_container',
        responsive: {
            0: {
                items: 1,
                slideBy: 1,
            },
            700: {
                items: 2,
                slideBy: 2
            },
            1040: {
                items: 3,
                slideBy: 3
            },
            1281: {
                items: 4
            },
        }
    });

    owl.on('changed.owl.carousel', function (event) {
        if (event.item.count - event.page.size == event.item.index)
            $(event.target).find('.owl-dots div:last')
                .addClass('active').siblings().removeClass('active');
    });

    //merken_pagina
    //lees meer button
    $('section.merk_uitgelicht p.first_alinea span').click(function () {
        $('section.merk_uitgelicht p.second_alinea').toggleClass('active');
    });

    //exclusief
    //lees meer button
    $('section.info_blok span.lees_meer').click(function () {
        $('section.info_blok p.small_not_visible').toggleClass('active');
    });

    //review page
    $('#input_star_rating').barrating({
        theme: 'fontawesome-stars-o'
    });

    //chat functie
    $('.open_chat').click(function (e) {
        e.preventDefault();
        setTimeout(function () {
            $('.loquendo-chat-label').trigger('click');
        }, 200);
    });

    //homepage car sale sell_car_form

    var sell_car_form = $('#sell_car_form');
    sell_car_form.steps({
        headerTag: "h3",
        bodyTag: "section",
        transitionEffect: "slideLeft",
        autoFocus: true
    });
});