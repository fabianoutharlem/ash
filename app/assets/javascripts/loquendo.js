/*!
 * Loquendo Chat (http://www.loquendo.nl)
 * @author Patrick Wever (patrick@xpos.nl)
 * @version 1.0
 * @copyright (c) 2013 XPOS Internet Solutions (http://www.xpos.nl)
 */
var Loquendo = (function() {
    var $, 											// our jQuery $
        _settings = {
            client_id: 1,								// client id
            site_id: 1,									// site id
            auto: 1,									// handle chat automatically?

            base_url: location.protocol+'//www.loquendo.nl',			// base url
            referer: document.referrer,					//

            //noConflict: 0,

            slider: {
                tabHandle: '.loquendo-chat-label',		// class of the element that will become the tab
                speed: 300,                             // animation speed
                action: 'click',                        // 'click' or 'hover' to show tab
                tabLocation: 'bottom',                  // location of tab: top, right, bottom, or left
                topPos: '10em',                        	// position from top if left/right
                leftPos: '-2em',                        // position from left if top/bottom (neg is from right)
                fixedPosition: true,                   	// true: make it stick (fixed position) on scroll
                end: 1
            },

            onReady: function(){
                //window.console&&console.log('onReady');
            },
            onRun: function(){
                //window.console&&console.log('onReady');
            },

            onSlideInit: function(){
                window.console&&console.log('onSlideInit');
            },
            onSlideInStart: function(){
                //window.console&&console.log('onSlideStart');
            },
            onSlideInEnd: function(){
                //window.console&&console.log('onSlideInEnd');
            },
            onSlideOutStart: function(){
                //window.console&&console.log('onSlideOutStart');
            },
            onSlideOutEnd: function(){
                //window.console&&console.log('onSlideOutEnd');
            },

            onNewMessages: function(){
                //window.console&&console.log('onNewMessages');
            },
            onPrintMessage: function(){
                //window.console&&console.log('onPrintMessage');
            },
            onNewMessage: function(){
                //window.console&&console.log('onNewMessage');
            },

            external_id: '',
            external_url: '',

            end: 1
        },
        _checkTimeout = 1,								// default check for messages time out (in sec)
        _checkTimeoutID = null,							// check timeout timer id
        _isChatting = 0,								// if chat is busy
        _isTyping = 0,									// user is typing?
        _isTypingText = '',								// user is typing what?
        _lastID = 0,									// last seen message id
        _chat_id = 0,									// current chat id
        _slider = null,
        _rule_action = '',
        _agent_img = '',
        _session_id = '',

    // private methods
        _log = function(msg) {
            window.console && console.log(msg);
        },

        _loquendoPlaceholderSupported = ('placeholder' in document.createElement('input'));
    _loquendoPlaceholderAdd = function(e) {
        if (_loquendoPlaceholderSupported) return;
        var $e = $(e);
        $e.find(':input[placeholder]').not(':password').each(function() {
            var placeholderText = $(this).attr('placeholder');
            if ($(this).val() === '' && !$(this).is(":focus")) {
                $(this).addClass('loquendo-placeholder-blur');
                $(this).val(placeholderText);
            }

            $(this).focus(function() {
                var input = $(this);
                var placeholderText = input.attr('placeholder');
                if (input.val() === placeholderText) input.val('');
                input.removeClass('loquendo-placeholder-blur');
            }).blur(function() {
                var input = $(this);
                var placeholderText = input.attr('placeholder');
                if (input.val() === '') {
                    input.val(placeholderText);
                    input.addClass('loquendo-placeholder-blur');
                }
            });

            $('form').submit(function(form) {
                form.find(':input[placeholder]').each(function() {
                    var input = $(this);
                    if (input.val() === input.attr('placeholder')) input.val('');
                });
            });
        });
    },
        _loquendoPlaceholderClear = function(e) {
            if (_loquendoPlaceholderSupported) return;
            var $e = $(e);
            $e.find(':input[placeholder]').not(':password').each(function() {
                if ($(this).val() === $(this).attr('placeholder')) $(this).val('');
            });
        },

        // https://gist.github.com/zachleat/2008932
        _loquendoCancelZoom = function() {
            return;
            var d = document,
                viewport,
                content,
                maxScale = ',maximum-scale=',
                maxScaleRegex = /,*maximum\-scale\=\d*\.*\d*/;

            // this should be a focusable DOM Element
            if(!this.addEventListener || !d.querySelector) {
                return;
            }

            viewport = d.querySelector('meta[name="viewport"]');
            content = viewport.content;

            function changeViewport(event)
            {
                // http://nerd.vasilis.nl/prevent-ios-from-zooming-onfocus/
                viewport.content = content + (event.type == 'blur' ? (content.match(maxScaleRegex, '') ? '' : maxScale + 10) : maxScale + 1);
            }

            // We could use DOMFocusIn here, but it's deprecated.
            this.addEventListener('focus', changeViewport, true);
            this.addEventListener('blur', changeViewport, false);
        },

        _getCookie = function(cookieName) {
            var search = cookieName + "=";
            if (document.cookie.length > 0) { // if there are any cookies
                var offset = document.cookie.indexOf(search);
                if (offset != -1) { // if cookie exists
                    offset += search.length;          // set index of beginning of value
                    var end = document.cookie.indexOf(";", offset);          // set index of end of cookie value
                    if (end == -1)
                        end = document.cookie.length;
                    return unescape(document.cookie.substring(offset, end));
                }
            }
            return "";
        },

        _setCookie = function(cookieName,cookieValue,cookieExp,cookieExpSecs) { //cookieExp in days
            if (cookieExp) {
                var expire = new Date();
                expire.setTime(expire.getTime() + 3600000*24*cookieExp);
                cookieExp = "expires="+expire.toGMTString();
            }
            if (cookieExpSecs) {
                var expire = new Date();
                expire.setTime(expire.getTime() + 1000*cookieExpSecs);
                cookieExp = "expires="+expire.toGMTString();
            }
            //PS: overige cookies blijven ongewijzigd, wijzigt eventueel bestaand cookie
            document.cookie = cookieName+"="+escape(cookieValue)+";path=/;"+cookieExp;
        },

        _deserialize = function(data) {
            if (jQuery.isPlainObject(data)) {
                return data;
            } else if (typeof data === "string") {
                var parts = data.split(/[&;]/);
                data = {};
                for (var i = 0, length = parts.length; i < length; i++) {
                    var kv = parts[i].split("=");
                    data[decodeURIComponent(kv[0])] = decodeURIComponent(kv[1].replace(/\+/g,"%20"));
                }
                return data;
            }
            return {};
        },

        _loquendoSlideOut = function() {
            $.fn.loquendoSlideOut = function(callerSettings) {
                var settings = $.extend({}, _settings.slider, callerSettings||{});

                settings.tabHandle = $(settings.tabHandle);
                var obj = this;
                if (settings.fixedPosition === true) {
                    settings.positioning = 'fixed';
                } else {
                    settings.positioning = 'absolute';
                }

                // ie6 doesn't do well with the fixed option
                if (document.all && !window.opera && !window.XMLHttpRequest) {
                    settings.positioning = 'absolute';
                }

                settings.tabHandle.css({
                    'position' : 'absolute'
                });

                obj.css({
                    'line-height' : '1',
                    'position' : settings.positioning
                });

                var getProperties = function() {
                    return {
                        containerWidth: parseInt(obj.outerWidth(), 10) + 'px',
                        containerHeight: parseInt(obj.outerHeight(), 10) + 'px',
                        tabWidth: parseInt(settings.tabHandle.outerWidth(), 10) + 'px',
                        tabHeight: parseInt(settings.tabHandle.outerHeight(), 10) + 'px'
                    }
                };

                // set calculated css
                if(settings.tabLocation === 'top' || settings.tabLocation === 'bottom') {
                    if (/^-/.test(settings.leftPos)) {
                        obj.css({'right' : settings.leftPos.replace(/-/,'')});
                    } else {
                        obj.css({'left' : settings.leftPos});
                    }
                    settings.tabHandle.css({'right' : 0});
                }

                var properties = getProperties();

                _settings.onSlideInit(settings);

                if(settings.tabLocation === 'top') {
                    obj.css({'top' : '-' + properties.containerHeight});
                    //settings.tabHandle.css({'bottom' : '-' + properties.tabHeight});
                    settings.tabHandle.animate({'bottom' : '-' + properties.tabHeight}, settings.speed);
                }

                if(settings.tabLocation === 'bottom') {
                    obj.css({'bottom' : '-' + properties.containerHeight, 'position' : 'fixed'});
                    //settings.tabHandle.css({'top' : '-' + properties.tabHeight});
                    settings.tabHandle.animate({'top' : '-' + properties.tabHeight}, settings.speed);
                }

                if(settings.tabLocation === 'left' || settings.tabLocation === 'right') {
                    obj.css({
                        'height' : properties.containerHeight,
                        'top' : settings.topPos
                    });
                    //settings.tabHandle.css({'top' : 0});
                    settings.tabHandle.animate({'top' : 0}, settings.speed);
                }

                if(settings.tabLocation === 'left') {
                    obj.css({ 'left': '-' + properties.containerWidth});
                    //settings.tabHandle.css({'right' : '-' + properties.tabWidth});
                    settings.tabHandle.animate({'right' : '-' + properties.tabWidth}, settings.speed);
                }

                if(settings.tabLocation === 'right') {
                    obj.css({ 'right': '-' + properties.containerWidth});
                    //settings.tabHandle.css({'left' : '-' + properties.tabWidth});
                    settings.tabHandle.animate({'left' : '-' + properties.tabWidth}, settings.speed);
                    $('html').css('overflow-x', 'hidden');
                }

                var slideIn = function(speed) {
                    properties = getProperties();
                    var prop = {};
                    if (settings.tabLocation === 'top') {
                        prop.top = '-' + properties.containerHeight;
                    } else if (settings.tabLocation === 'left') {
                        prop.left =  '-' + properties.containerWidth;
                    } else if (settings.tabLocation === 'right') {
                        prop.right =  '-' + properties.containerWidth;
                    } else if (settings.tabLocation === 'bottom') {
                        prop.bottom =  '-' + properties.containerHeight;
                    }
                    _settings.onSlideInStart();
                    obj.animate(prop, speed || settings.speed, null, function() {
                        obj.removeClass('loquendo-open');
                        _settings.onSlideInEnd();
                    });
                };

                var slideOut = function(speed) {
                    var prop = {};
                    if (settings.tabLocation == 'top') {
                        prop.top = '-3px';
                    } else if (settings.tabLocation == 'left') {
                        prop.left = '-3px';
                    } else if (settings.tabLocation == 'right') {
                        prop.right = '-3px';
                    } else if (settings.tabLocation == 'bottom') {
                        prop.bottom = '-3px';
                    }
                    _settings.onSlideOutStart();
                    obj.animate(prop, speed || settings.speed, null, function() {
                        _settings.onSlideOutEnd();
                    }).addClass('loquendo-open');
                };

                // choose which type of action to bind
                if (settings.action === 'hover') {
                    obj.hover(
                        function(){
                            slideOut();
                        },
                        function(){
                            slideIn();
                        });
                    settings.tabHandle.click(function(evt){
                        if (obj.hasClass('loquendo-open')) {
                            slideIn();
                        }
                    });
                } else {
                    // settings.action === 'click'
                    settings.tabHandle.click(function(evt){
                        if (obj.hasClass('loquendo-open')) {
                            slideIn();
                        } else {
                            slideOut();
                        }
                    });
                }

                // close tab on click anywhere on page
                obj.click(function(evt){
                    evt.stopPropagation();
                });
                $(document).click(function(){
                    slideIn();
                });

                this.slideIn = function(speed) {
                    slideIn(speed);
                }

                this.slideOut = function(speed) {
                    slideOut(speed);
                }

                return this;
            };
        },

        _isValidEmailAddress = function(emailAddress) {
            //var re = /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i;
            var re = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,})+$/i
            return re.test(emailAddress);
        },

        _doAjax = function(data, cb, errcb) {
            data.agent = _settings.agent;
            data.session_id = _session_id;
            $.ajax(_settings.base_url+'/loquendo/cgi/chat.cgi?jsoncallback=?', {
                dataType: 'json',
                type: 'GET',
                data: data,
                success: function(result, textStatus, jqXHR) {
                    cb && cb(result, textStatus, jqXHR);
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    //alert('Oops...');
                    errcb && errcb(jqXHR, textStatus, errorThrown);
                }
            });
        },

        _escapeHTML = function(str) {
            str = str.replace(/&/g, '&amp;');
            str = str.replace(/"/g, '&quot;');
            str = str.replace(/>/g, '&gt;');
            str = str.replace(/</g, '&lt;');
            str = str.replace(/'/g, '&#39;');
            return str;
        },

        _printMessage = function(data, print) {
            _settings.onPrintMessage(data);
            if (print || !data.type) { // Loquendo toont zelf geen type messages!
                if (data.user_name) {
                    $('.loquendo-messages table').append(
                        '<tr class="loquendo-message-'+data.from+'" id="message-'+data.message_id+'">'+
                        '<th>'+data.user_name+':</th>'+
                        '<td>'+data.message+'</td>'+
                        (_settings.agent && data.message_id ? '<td><a href="javascript:Loquendo.deleteMessage('+data.message_id+')">X</a></td>' : '')+
                        '<tr>'
                    );
                } else {
                    $('.loquendo-messages table').append(
                        '<tr class="loquendo-message-'+data.from+'" id="message-'+data.message_id+'">'+
                        '<td colspan="2">'+data.message+'</td>'+
                        (_settings.agent && data.message_id ? '<td><a href="javascript:Loquendo.deleteMessage('+data.message_id+')">X</a></td>' : '')+
                        '<tr>');
                }
                _scrollMessages();
            }
        },

        _deleteMessage = function(data) {
            //_settings.onDeleteMessage(data);
            $('.loquendo-messages table #message-'+(data.message_id || data.id)).remove();
            _scrollMessages();
        },

        _scrollMessages = function() {
            $('.loquendo-messages').animate({scrollTop: $('.loquendo-messages').prop("scrollHeight")}, 500);
        },

        _newMessages = function(data) {
            if (data && data.messages) {
                var ae = document.activeElement || window; // has focus
                var newMessages = 0; /// new messages or scroll done... might loose focus?
                _settings.onNewMessages(data);
                if (!data.messages.length && data.is_typing != "0" && data.is_typing) {
                    $('.loquendo-typing').show();
                    $('.loquendo-typing').text(data.is_typing+' is aan het typen...'+(data.is_typing_text?': '+data.is_typing_text:''));
                    _scrollMessages();
                    //newMessages = 1;
                } else {
                    $('.loquendo-typing').hide();
                }
                if (data.messages.length) {
                    _settings.onNewMessage();
                    newMessages = 1;
                    $.each(data.messages, function(i, e) {
                        e.deleted == '1' ? _deleteMessage(e) : _printMessage(e);
                    });
                }
                if (newMessages) {
                    if (!(window.opener && window.opener.windowsOpen && window.opener.windowsOpen(window))) {
                        ae.focus();
                    }
                }
            }
        },

        _checkForMessages = function(data, callback) {
            var this_callback = callback || _newMessages;
            _doAjax({
                    action: 'check',
                    client_id: _settings.client_id,
                    site_id: _settings.site_id,
                    chat_id: _chat_id,
                    lastID: _lastID,
                    isTyping: data ? data.is_typing : _isTyping,
                    isTypingText: data ? data.is_typing_text : _isTypingText,
                    agent_img: _agent_img ? 1 : 0
                },
                function(data) {
                    if (data) {
                        if (data.is_closed == null) {
                            data.is_cancelled = 1;
                        } else if (data.is_closed != '0000-00-00 00:00:00') {
                            data.is_closed = 1;
                        } else {
                            data.is_closed = 0;
                        }
                        //if (data.messages.length) {
                        //	_lastID = data.messages[data.messages.length-1].id;
                        //}
                        $.each(data.messages, function(i, e) {
                            if (e.deleted == '0') _lastID = e.id;
                        });
                        if (data.is_cancelled || data.is_closed) {
                            _isChatting = 0;
                            _setCookie('loquendo-chat-id', 0);
                        }
                        if (data.agent_img != '0') {
                            _agent_img = data.agent_img;
                            $('.loquendo-agent').toggle();
                            $('.agent-image').attr('src', _settings.base_url+'/75x75/loquendo/images/agents/'+_agent_img);
                            $('.loquendo-agent span').text(data.agent_name);
                        }
                        this_callback(data);
                    }
                    // if no callback its us...
                    if (data && !callback) {
                        if (data.is_cancelled) {
                            // chat is verwijderd...
                            _printMessage({
                                from: 'system',
                                user_name: '',
                                message: 'Chat is geannuleerd.'
                            });

                        } else if (data.is_closed) {
                            // chat is gesloten door tegenpartij
                            // melding tonen en chat venster sluiten...
                            _printMessage({
                                from: 'system',
                                user_name: '',
                                message: 'Chat is afgesloten.'
                            });
                        }

                        if (_isChatting) {
                            _checkTimeoutID = setTimeout(_checkForMessages, _checkTimeout*1000);
                        }
                    }
                },
                function() {
                    if (!callback && _isChatting) {
                        _checkTimeoutID = setTimeout(_checkForMessages, _checkTimeout*1000);
                    }
                }
            );
        },

        _isOnline = function(callback) {
            _doAjax({
                    action: 'online',
                    client_id: _settings.client_id,
                    site_id: _settings.site_id,
                    referer: _settings.referer,
                    rule_action: _rule_action
                },
                function(data) {
                    callback(data);
                }
            );
        },

        _isHidden = function(callback) {
            callback({
                hidden: _rule_action == 'chat-hide' ? 1 : 0
            });
        },

        _ready = function() { // called when jQuery available
            // set our $
            //$ = jQuery;

            // cancel zoom in iOS
            $.fn.cancelZoom = function() {
                return this.each(_loquendoCancelZoom);
            };

            // hide on printing...
            var beforePrint = function() {
                window.console&&console.log('Functionality to run before printing.');
                $('.loquendo-chat').hide();
            };
            var afterPrint = function() {
                window.console&&console.log('Functionality to run after printing');
                $('.loquendo-chat').show();
            };
            if (window.matchMedia) {
                var mediaQueryList = window.matchMedia('print');
                mediaQueryList.addListener(function(mql) {
                    if (mql.matches) {
                        beforePrint();
                    } else {
                        afterPrint();
                    }
                });
            }
            window.onbeforeprint = beforePrint;
            window.onafterprint = afterPrint;

            // run...
            $(document).ready(function() {
                // settings are now applied by init()
                _settings.onReady();

                // init slider/tab
                _loquendoSlideOut();

                // get rules
                _doAjax({
                    action: 'get-rules',
                    client_id: _settings.client_id,
                    site_id: _settings.site_id
                }, function(data) {
                    // save/process rules...
                    $.each(data, function(i, v) {
                        if (!_rule_action) {
                            if (v.operand == 'dom-element') {
                                if ($(v.value).length) {
                                    v.status = /^!/.test(v.operator) ? '0' : '1';
                                }
                            } else if (v.operand == 'dom-text') {
                                if ($('body:contains("'+v.value+'")').length) {
                                    v.status = /^!/.test(v.operator) ? '0' : '1';
                                }
                            }
                            if (v.status == '1') {
                                _rule_action = v.action;
                            }
                        }
                    });

                    // start!
                    if (_settings.auto) {
                        _run(); // call our run
                    } else {
                        _settings.init_cb && _settings.init_cb(); // call external run/init func
                        _settings.init_cb = null; // clear...
                    }
                });
            });
        },

        _init = function(settings, callback) {
            // copy passed settings...
            if (settings) {
                for (var setting in settings) {
                    if (typeof settings[setting] === 'object') {
                        for (var subsetting in settings[setting]) {
                            _settings[setting][subsetting] = settings[setting][subsetting];
                        }
                    } else {
                        _settings[setting] = settings[setting];
                    }
                }
            }
            // save init callback
            _settings.init_cb = callback;
            if (_settings.agent) {
                _chat_id = _settings.chat_id;
                _lastID = _settings.lastID;
            }
        },

        _chat = function(e) {
            var $e = $(e); // get jQuery object of element holding chat area
            _loquendoPlaceholderAdd($e);
            $e.find('input:text,select,textarea').cancelZoom();

            $e.find('button[type="submit"]').click(function(evt) {
                evt.preventDefault();
                if (_isChatting) {
                    _isTyping = 0; // on submit we stopped typing...
                    // get form data
                    var $form = $(this).parent('form');
                    _loquendoPlaceholderClear($form);
                    var data = {};
                    $.each($form.serializeArray(), function(_, kv) {
                        data[kv.name] = kv.value;
                    });
                    data.isTyping = _isTyping;
                    // print our message
                    _printMessage({
                        from: _settings.agent ? 'agent' : 'user',
                        user_name: _escapeHTML(data.user_name),
                        message: _escapeHTML(data.message)
                    });
                    // post message
                    _doAjax(data);
                    // clear message field
                    $form.find('textarea').val('');
                    _loquendoPlaceholderAdd($form);
                }
            });

            $e.find('button[type="reset"]').click(function(evt) {
                evt.preventDefault();
                // als chatten gesloten door tegenpartij... dan meteen door...
                if (!_isChatting || confirm('Weet u zeker dat u de chat wenst te sluiten?')) {
                    _close($e);
                }
            });

            // handle enter/submit in textarea...
            var $t = $e.find('textarea').keyup(function(evt) {
                // Shift-enter = newline in textarea...? for markdown with multiple lines
                if (evt.which == 13) {
                    $e.find('button[type="submit"]').trigger('click');
                    return false;
                }
                _isTyping = evt.target.value ? 1 : 0;
                _isTypingText = evt.target.value;
            })
            if (_loquendoPlaceholderSupported) $t.focus();

            // loop...
            _isChatting = 1;
            _setCookie('loquendo-chat-id', _chat_id);//session, null, 300); // track for 5 minutes
            _scrollMessages();
            _checkForMessages();
        },

        _close = function(e) {
            var $e = $(e);
            _isChatting = 0;
            _setCookie('loquendo-chat-id', 0);
            _doAjax({
                    action: 'close',
                    client_id: _settings.client_id,
                    chat_id: _chat_id
                },
                function(data) {
                    if (_settings.agent) {
                        window.close();
                    } else {
                        $('.loquendo-chat-content').html(Base64.decode(data.html));
                        if (data.done) {
                            // done: this was last step...
                            _end();
                        } else {
                            // not quite done: handle survey...
                            _loquendoPlaceholderAdd($e);
                            $e.find('input:text,select,textarea').cancelZoom();
                            $e.find('button[type="submit"]').click(function(evt) {
                                evt.preventDefault();
                                _loquendoPlaceholderClear($(this).parent('form'));
                                _doAjax(
                                    $(this).parent('form').serialize(),
                                    function(data) {
                                        $('.loquendo-chat-content').html(Base64.decode(data.html));
                                        _end();
                                    }
                                );
                            });
                        }
                    }
                });
        },

        _endTimeout = 0,
        _end = function() {
            $('.loquendo-chat').removeClass('loquendo-chatting');
            // hide slider after 2 secs...
            _endTimeout = setTimeout(function() {
                _slider.slideIn(2000);
            }, 5000);
        },

        _run = function() {
            // don't show at all when hidden...
            if (_rule_action == 'chat-hide') return;

            if (_endTimeout) clearTimeout(_endTimeout);

            // get start form with name, email and message field...
            _doAjax({
                    client_id: _settings.client_id,
                    site_id: _settings.site_id,
                    external_id: _settings.external_id,
                    external_url: _settings.external_url,
                    referer: _settings.referer,
                    rule_action: _rule_action
                },
                function(data) {
                    // live settings...
                    if (data.chat_color) _settings.className = data.chat_color;
                    if (data.chat_position) _settings.slider.tabLocation = data.chat_position;

                    // got start form...
                    $('.loquendo-chat').remove();

                    $('body').append(Base64.decode(data.html));

                    _settings.onRun();

                    var $div = $('.loquendo-chat');
                    if (_settings.className) $div.addClass(_settings.className);
                    $div.addClass('loquendo-' + _settings.slider.tabLocation);
                    _loquendoPlaceholderAdd($div);
                    $div.find('input:text,select,textarea').cancelZoom();
                    _slider = $div.loquendoSlideOut(_settings.slider);

                    if (parseInt(_getCookie('loquendo-chat-id'))>0) {
                        _getChatForm({
                            action: 'continue'
                        });
                    } else {
                        _settings.init_cb && _settings.init_cb(); // call external init func
                        _settings.init_cb = null; // clear...

                        // handle submit button...
                        $div.find('button').click(function(evt) {
                            evt.preventDefault();
                            var $form = $(this).parent();

                            // check required fields
                            var form_ok = 1;
                            _loquendoPlaceholderClear($form);
                            $form.find('input:visible,textarea:visible').each(function() {
                                var $e = $(this);
                                // IE always returns required? alert($e.attr('name')+':'+$e.attr('required'))
                                if (
                                    ($e.attr('required') && $e.val() == '') ||
                                    ($e.attr('type') == 'email' && $e.val() != '' && !_isValidEmailAddress($e.val()))
                                ) {
                                    $e.addClass('loquendo-input-required');
                                    $e.focus(function() {
                                        $e.removeClass('loquendo-input-required');
                                    });
                                    form_ok = 0;
                                }
                            });

                            if (!form_ok) {
                                _loquendoPlaceholderAdd($form);
                                return;
                            }

                            _session_id = $('[name=session_id]').val();
                            //_setCookie($('[name=session_name]').val(), $('[name=session_id]').val());

                            _getChatForm($form.serialize());
                        });
                    }
                }
            );
        },

        _getChatForm = function(data) {
            // get chat form...
            _doAjax(
                data,
                function(data) {
                    $('.loquendo-chat-content').html(Base64.decode(data.html));
                    if (data.message_sent) {
                        // offline message sent
                        _end();

                    } else {
                        // got chat form...
                        _lastID = data.lastID; // first question posted... keep as lastID
                        _chat_id = data.chat_id;
                        var $div = $('.loquendo-chat');
                        $div.addClass('loquendo-chatting');
                        _slider.slideOut();
                        _chat($div);
                    }
                },
                function(jqXHR, textStatus, errorThrown) {
                    //alert('Oops... at continue');
                    // if parseerror with < than json did not go okay... retry or do a 'continue'?
                }
            );
        },

        _loadScript = function(url, callback) {
            var script = document.createElement('script')
            script.type = 'text/javascript';

            if (script.readyState) { // IE
                script.onreadystatechange = function () {
                    if (script.readyState == 'loaded' || script.readyState == 'complete') {
                        script.onreadystatechange = null;
                        callback && callback();
                    }
                };
            } else { // Others
                script.onload = function () {
                    callback && callback();
                };
            }

            script.src = url;
            document.getElementsByTagName('head')[0].appendChild(script);
        },

        _versionGTE = function (cur_version, min_version) {
            return ([cur_version, min_version].sort()[1] === cur_version);
        };

    if (0
            // no jQuery at all...
        || typeof window.jQuery == 'undefined'
            // check min required version...
        || !_versionGTE(window.jQuery.fn.jquery, '1.6.0')
    ) {
        _loadScript(location.protocol+'//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js', function() {
            // restore previous lib that might use $
            $ = jQuery.noConflict(true);
            _ready();
        });
    } else {
        $ = jQuery;
        _ready();
    }

    // returning the object
    return {
        // public methods

        // init with call back for when ready...
        init: function(settings, callback) {
            _init(settings, callback);
        },

        //
        isOnline: function(callback) {
            _isOnline(callback);
        },

        //
        isHidden: function(callback) {
            _isHidden(callback);
        },

        //
        run: function() {
            _run();
        },

        //
        startChat: function(idata, callback) {
            // data.username || data.user_name
            // data.message
            // data.referer
            idata = _deserialize(idata);
            idata.client_id = _settings.client_id;
            idata.site_id = _settings.site_id;
            idata.action = 'start';
            _doAjax(
                idata,
                function(odata) {
                    _chat_id = odata.chat_id;
                    _lastID = odata.lastID;
                    _setCookie('loquendo-chat-id', _chat_id);// session, null, 300);
                    callback(odata); // return form...
                }
            );
        },

        activeChat: function() {
            return parseInt(_getCookie('loquendo-chat-id'))>0;
        },

        continueChat: function(callback) {
            if (parseInt(_getCookie('loquendo-chat-id'))>0) {
                _doAjax({
                        action: 'continue'
                    },
                    function(data) {
                        _lastID = data.lastID;
                        _chat_id = data.chat_id;
                        callback && callback(data); // return form...
                    }
                );
            }
        },

        //
        chat: function(e) {
            _chat(e);
        },

        //
        closeChat: function(callback) {
            _doAjax({
                    action: 'close',
                    client_id: _settings.client_id,
                    chat_id: _chat_id
                },
                function(data) {
                    callback && callback(data); // return form...
                }
            );
        },

        //
        sendSurvey: function(data, callback) {
            // data.answer
            // data.helpful
            // data.experience
            // data.comments
            data = _deserialize(data);
            data.action = 'survey';
            data.client_id = _settings.client_id;
            data.chat_id = _chat_id;
            _doAjax(
                data,
                function(data) {
                    callback && callback(data); // return form...
                }
            );
        },

        //
        postMessage: function(data, callback, print) {
            // data.message
            data = _deserialize(data);
            data.client_id = _settings.client_id;
            data.chat_id = _chat_id;
            data.action = 'post';
            _doAjax(
                data,
                function(result) {
                    data.message_id = result.message_id;
                    if (print) _printMessage(data, print);
                    callback && callback(result); // return id...
                }
            );
        },

        openChat: function () {
            var x = _loquendoSlideOut();
        },

        //
        deleteMessage: function(id, callback) {
            // data.message
            var data = {message_id: id};
            data.client_id = _settings.client_id;
            data.chat_id = _chat_id;
            data.action = 'delete';
            _doAjax(
                data,
                function(result) {
                    data.message_id = result.message_id;
                    if (print) _deleteMessage(data);
                    callback && callback(result); // return id...
                }
            );
        },

        //
        checkForMessages: function(data, callback) {
            data = _deserialize(data);
            _checkForMessages(data, callback);
        },

        // external caller may want to use our jQuery
        $: function() {
            return $;
        },

        end: 1
    }

})();

/**
 *
 *  Base64 encode / decode
 *  http://www.webtoolkit.info/
 *
 **/
var Base64 = {

    // private property
    _keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

    // public method for encoding
    encode : function (input) {
        var output = "";
        var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
        var i = 0;

        input = Base64._utf8_encode(input);

        while (i < input.length) {

            chr1 = input.charCodeAt(i++);
            chr2 = input.charCodeAt(i++);
            chr3 = input.charCodeAt(i++);

            enc1 = chr1 >> 2;
            enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
            enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
            enc4 = chr3 & 63;

            if (isNaN(chr2)) {
                enc3 = enc4 = 64;
            } else if (isNaN(chr3)) {
                enc4 = 64;
            }

            output = output +
                this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
                this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

        }

        return output;
    },

    // public method for decoding
    decode : function (input) {
        var output = "";
        var chr1, chr2, chr3;
        var enc1, enc2, enc3, enc4;
        var i = 0;

        input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

        while (i < input.length) {

            enc1 = this._keyStr.indexOf(input.charAt(i++));
            enc2 = this._keyStr.indexOf(input.charAt(i++));
            enc3 = this._keyStr.indexOf(input.charAt(i++));
            enc4 = this._keyStr.indexOf(input.charAt(i++));

            chr1 = (enc1 << 2) | (enc2 >> 4);
            chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
            chr3 = ((enc3 & 3) << 6) | enc4;

            output = output + String.fromCharCode(chr1);

            if (enc3 != 64) {
                output = output + String.fromCharCode(chr2);
            }
            if (enc4 != 64) {
                output = output + String.fromCharCode(chr3);
            }

        }

        output = Base64._utf8_decode(output);

        return output;

    },

    // private method for UTF-8 encoding
    _utf8_encode : function (string) {
        string = string.replace(/\r\n/g,"\n");
        var utftext = "";

        for (var n = 0; n < string.length; n++) {

            var c = string.charCodeAt(n);

            if (c < 128) {
                utftext += String.fromCharCode(c);
            }
            else if((c > 127) && (c < 2048)) {
                utftext += String.fromCharCode((c >> 6) | 192);
                utftext += String.fromCharCode((c & 63) | 128);
            }
            else {
                utftext += String.fromCharCode((c >> 12) | 224);
                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                utftext += String.fromCharCode((c & 63) | 128);
            }

        }

        return utftext;
    },

    // private method for UTF-8 decoding
    _utf8_decode : function (utftext) {
        var string = "";
        var i = 0;
        var c = c1 = c2 = 0;

        while ( i < utftext.length ) {

            c = utftext.charCodeAt(i);

            if (c < 128) {
                string += String.fromCharCode(c);
                i++;
            }
            else if((c > 191) && (c < 224)) {
                c2 = utftext.charCodeAt(i+1);
                string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                i += 2;
            }
            else {
                c2 = utftext.charCodeAt(i+1);
                c3 = utftext.charCodeAt(i+2);
                string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                i += 3;
            }

        }

        return string;
    }
}