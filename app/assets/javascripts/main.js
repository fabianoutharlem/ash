/**
 * Created by menno on 15/02/16.
 */
$(document).ready(function () {


    //homepage
    var section_header = $('section.header');

    $("li[data-submenu]", section_header).mouseenter(function() {
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
    $('.merk_dropdown').select2({
        minimumResultsForSearch: Infinity
    });

    //filter
    $('.cars_filter_select').select2({
        minimumResultsForSearch: Infinity
    });

    //homepage price slider
    var showLabel = function (event, ui) {
        var curValue = ui.value || $(this).slider("option", "value");
        var target = ui.handle || $('.ui-slider-handle');
        var tooltip = '<div id="tooltip">€' + curValue + ',- p.m.</div>';
        $(target).html(tooltip);
    };

    $("#slider_maand_financieren").slider({
        min: 0,
        max: 2000,
        range: "min",
        value: 200,
        slide: showLabel,
        create: showLabel
    });


    $("#slider_buy_financieren").slider({
        min: 0,
        max: 2000,
        range: "min",
        value: 200,
        slide: showLabel,
        create: showLabel
    });

    $("#slider_maand_kopen").slider({
        min: 0,
        max: 2000,
        range: "min",
        value: 200,
        slide: showLabel,
        create: showLabel
    });

    $("#slider_buy_kopen").slider({
        min: 0,
        max: 2000,
        range: "min",
        value: 200,
        slide: showLabel,
        create: showLabel
    });

    //voorraad_pagina price sliders
    $("#slider_prijs_tot").slider({
        min: 0,
        max: 50000,
        range: "min",
        value: 21000,
        slide: showLabel,
        create: showLabel
    });

    $("#slider_prijs_maand_tot").slider({
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
                slideBy:1,
                dots: false
            },
            700: {
                items: 2,
                slideBy:2
            },
            1040: {
                items: 3,
                slideBy:3
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


    //detail pagina

    //model slider
    $('.auto_uitgelicht .car_slider').unslider({
        autoplay: false,
        delay: 5000,
        arrows: false,
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

    $('section.auto_uitgelicht div.model .afspraak_btn').click(function () {
        afspraak_overlay.addClass('bounceInUp active');
    });

    $('section.auto_uitgelicht div.overlay_afspraak img.cross').click(function () {
        afspraak_overlay.removeClass('active bounceInUp');
    });

    //financier button click overlay visible
    var financier_overlay = $('section.auto_uitgelicht .overlay_financier');

    $('section.auto_uitgelicht div.model .green_btn').click(function () {
        financier_overlay.addClass('active');
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
                slideBy:1,
                dots: false
            },
            700: {
                items: 2,
                slideBy:2,
            },
            1040: {
                items: 3,
                slideBy:3,
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

       //left menu filters tab active
    var tab_btn = $('section.all_cars div.left div.tab');
    tab_btn.click(function () {
        $(this).addClass('active');
        tab_btn.not($(this)).removeClass('active');
    });

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
                slideBy:1,
            },
            700: {
                items: 2,
                slideBy:2
            },
            1040: {
                items: 3,
                slideBy:3
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
    $('section.merk_uitgelicht p.first_alinea span').click( function () {
        $('section.merk_uitgelicht p.second_alinea').toggleClass('active');
    });

    //exclusief
       //lees meer button
    $('section.info_blok span.lees_meer').click( function () {
        $('section.info_blok p.small_not_visible').toggleClass('active');
    });
});
