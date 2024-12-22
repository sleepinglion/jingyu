// fancybox.js
var e = "undefined" !== typeof globalThis ? globalThis : "undefined" !== typeof self ? self : global;
var t = {};
t = function(t2) {
  var i2 = t2("html"), n = t2(window), o = t2(document), a = t2.fancybox = function() {
    a.open.apply(this || e, arguments);
  }, r = navigator.userAgent.match(/msie/i), l = null, s = void 0 !== document.createTouch, isQuery = function(e2) {
    return e2 && e2.hasOwnProperty && e2 instanceof t2;
  }, isString = function(e2) {
    return e2 && "string" === t2.type(e2);
  }, isPercentage = function(e2) {
    return isString(e2) && e2.indexOf("%") > 0;
  }, isScrollable = function(e2) {
    return e2 && !(e2.style.overflow && "hidden" === e2.style.overflow) && (e2.clientWidth && e2.scrollWidth > e2.clientWidth || e2.clientHeight && e2.scrollHeight > e2.clientHeight);
  }, getScalar = function(e2, t3) {
    var i3 = parseInt(e2, 10) || 0;
    t3 && isPercentage(e2) && (i3 = a.getViewport()[t3] / 100 * i3);
    return Math.ceil(i3);
  }, getValue = function(e2, t3) {
    return getScalar(e2, t3) + "px";
  };
  t2.extend(a, { version: "2.1.5", defaults: { padding: 15, margin: 20, width: 800, height: 600, minWidth: 100, minHeight: 100, maxWidth: 9999, maxHeight: 9999, pixelRatio: 1, autoSize: true, autoHeight: false, autoWidth: false, autoResize: true, autoCenter: !s, fitToView: true, aspectRatio: false, topRatio: 0.5, leftRatio: 0.5, scrolling: "auto", wrapCSS: "", arrows: true, closeBtn: true, closeClick: false, nextClick: false, mouseWheel: true, autoPlay: false, playSpeed: 3e3, preload: 3, modal: false, loop: true, ajax: { dataType: "html", headers: { "X-fancyBox": true } }, iframe: { scrolling: "auto", preload: true }, swf: { wmode: "transparent", allowfullscreen: "true", allowscriptaccess: "always" }, keys: { next: { 13: "left", 34: "up", 39: "left", 40: "up" }, prev: { 8: "right", 33: "down", 37: "right", 38: "down" }, close: [27], play: [32], toggle: [70] }, direction: { next: "left", prev: "right" }, scrollOutside: true, index: 0, type: null, href: null, content: null, title: null, tpl: { wrap: '<div class="fancybox-wrap" tabIndex="-1"><div class="fancybox-skin"><div class="fancybox-outer"><div class="fancybox-inner"></div></div></div></div>', image: '<img class="fancybox-image" src="{href}" alt="" />', iframe: '<iframe id="fancybox-frame{rnd}" name="fancybox-frame{rnd}" class="fancybox-iframe" frameborder="0" vspace="0" hspace="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen' + (r ? ' allowtransparency="true"' : "") + "></iframe>", error: '<p class="fancybox-error">The requested content cannot be loaded.<br/>Please try again later.</p>', closeBtn: '<a title="Close" class="fancybox-item fancybox-close" href="javascript:;"></a>', next: '<a title="Next" class="fancybox-nav fancybox-next" href="javascript:;"><span></span></a>', prev: '<a title="Previous" class="fancybox-nav fancybox-prev" href="javascript:;"><span></span></a>', loading: '<div id="fancybox-loading"><div></div></div>' }, openEffect: "fade", openSpeed: 250, openEasing: "swing", openOpacity: true, openMethod: "zoomIn", closeEffect: "fade", closeSpeed: 250, closeEasing: "swing", closeOpacity: true, closeMethod: "zoomOut", nextEffect: "elastic", nextSpeed: 250, nextEasing: "swing", nextMethod: "changeIn", prevEffect: "elastic", prevSpeed: 250, prevEasing: "swing", prevMethod: "changeOut", helpers: { overlay: true, title: true }, onCancel: t2.noop, beforeLoad: t2.noop, afterLoad: t2.noop, beforeShow: t2.noop, afterShow: t2.noop, beforeChange: t2.noop, beforeClose: t2.noop, afterClose: t2.noop }, group: {}, opts: {}, previous: null, coming: null, current: null, isActive: false, isOpen: false, isOpened: false, wrap: null, skin: null, outer: null, inner: null, player: { timer: null, isActive: false }, ajaxLoad: null, imgPreload: null, transitions: {}, helpers: {}, open: function(e2, i3) {
    if (e2) {
      t2.isPlainObject(i3) || (i3 = {});
      if (false !== a.close(true)) {
        t2.isArray(e2) || (e2 = isQuery(e2) ? t2(e2).get() : [e2]);
        t2.each(e2, function(n2, o2) {
          var r2 = {}, l2, s2, c, f, d, p, u;
          if ("object" === t2.type(o2)) {
            o2.nodeType && (o2 = t2(o2));
            if (isQuery(o2)) {
              r2 = { href: o2.data("fancybox-href") || o2.attr("href"), title: t2("<div/>").text(o2.data("fancybox-title") || o2.attr("title") || "").html(), isDom: true, element: o2 };
              t2.metadata && t2.extend(true, r2, o2.metadata());
            } else r2 = o2;
          }
          l2 = i3.href || r2.href || (isString(o2) ? o2 : null);
          s2 = void 0 !== i3.title ? i3.title : r2.title || "";
          c = i3.content || r2.content;
          f = c ? "html" : i3.type || r2.type;
          if (!f && r2.isDom) {
            f = o2.data("fancybox-type");
            if (!f) {
              d = o2.prop("class").match(/fancybox\.(\w+)/);
              f = d ? d[1] : null;
            }
          }
          if (isString(l2)) {
            if (!f) {
              if (a.isImage(l2)) f = "image";
              else if (a.isSWF(l2)) f = "swf";
              else if ("#" === l2.charAt(0)) f = "inline";
              else if (isString(o2)) {
                f = "html";
                c = o2;
              }
            }
            if ("ajax" === f) {
              p = l2.split(/\s+/, 2);
              l2 = p.shift();
              u = p.shift();
            }
          }
          if (!c) {
            if ("inline" === f) l2 ? c = t2(isString(l2) ? l2.replace(/.*(?=#[^\s]+$)/, "") : l2) : r2.isDom && (c = o2);
            else if ("html" === f) c = l2;
            else if (!f && !l2 && r2.isDom) {
              f = "inline";
              c = o2;
            }
          }
          t2.extend(r2, { href: l2, type: f, content: c, title: s2, selector: u });
          e2[n2] = r2;
        });
        a.opts = t2.extend(true, {}, a.defaults, i3);
        void 0 !== i3.keys && (a.opts.keys = !!i3.keys && t2.extend({}, a.defaults.keys, i3.keys));
        a.group = e2;
        return a._start(a.opts.index);
      }
    }
  }, cancel: function() {
    var e2 = a.coming;
    if (!e2 || false !== a.trigger("onCancel")) {
      a.hideLoading();
      if (e2) {
        a.ajaxLoad && a.ajaxLoad.abort();
        a.ajaxLoad = null;
        a.imgPreload && (a.imgPreload.onload = a.imgPreload.onerror = null);
        e2.wrap && e2.wrap.stop(true, true).trigger("onReset").remove();
        a.coming = null;
        a.current || a._afterZoomOut(e2);
      }
    }
  }, close: function(e2) {
    a.cancel();
    if (false !== a.trigger("beforeClose")) {
      a.unbindEvents();
      if (a.isActive) if (a.isOpen && true !== e2) {
        a.isOpen = a.isOpened = false;
        a.isClosing = true;
        t2(".fancybox-item, .fancybox-nav").remove();
        a.wrap.stop(true, true).removeClass("fancybox-opened");
        a.transitions[a.current.closeMethod]();
      } else {
        t2(".fancybox-wrap").stop(true).trigger("onReset").remove();
        a._afterZoomOut();
      }
    }
  }, play: function(e2) {
    var clear = function() {
      clearTimeout(a.player.timer);
    }, set = function() {
      clear();
      a.current && a.player.isActive && (a.player.timer = setTimeout(a.next, a.current.playSpeed));
    }, stop = function() {
      clear();
      o.unbind(".player");
      a.player.isActive = false;
      a.trigger("onPlayEnd");
    }, start = function() {
      if (a.current && (a.current.loop || a.current.index < a.group.length - 1)) {
        a.player.isActive = true;
        o.bind({ "onCancel.player beforeClose.player": stop, "onUpdate.player": set, "beforeLoad.player": clear });
        set();
        a.trigger("onPlayStart");
      }
    };
    true === e2 || !a.player.isActive && false !== e2 ? start() : stop();
  }, next: function(e2) {
    var t3 = a.current;
    if (t3) {
      isString(e2) || (e2 = t3.direction.next);
      a.jumpto(t3.index + 1, e2, "next");
    }
  }, prev: function(e2) {
    var t3 = a.current;
    if (t3) {
      isString(e2) || (e2 = t3.direction.prev);
      a.jumpto(t3.index - 1, e2, "prev");
    }
  }, jumpto: function(e2, t3, i3) {
    var n2 = a.current;
    if (n2) {
      e2 = getScalar(e2);
      a.direction = t3 || n2.direction[e2 >= n2.index ? "next" : "prev"];
      a.router = i3 || "jumpto";
      if (n2.loop) {
        e2 < 0 && (e2 = n2.group.length + e2 % n2.group.length);
        e2 %= n2.group.length;
      }
      if (void 0 !== n2.group[e2]) {
        a.cancel();
        a._start(e2);
      }
    }
  }, reposition: function(e2, i3) {
    var n2 = a.current, o2 = n2 ? n2.wrap : null, r2;
    if (o2) {
      r2 = a._getPosition(i3);
      if (e2 && "scroll" === e2.type) {
        delete r2.position;
        o2.stop(true, true).animate(r2, 200);
      } else {
        o2.css(r2);
        n2.pos = t2.extend({}, n2.dim, r2);
      }
    }
  }, update: function(e2) {
    var t3 = e2 && e2.originalEvent && e2.originalEvent.type, i3 = !t3 || "orientationchange" === t3;
    if (i3) {
      clearTimeout(l);
      l = null;
    }
    a.isOpen && !l && (l = setTimeout(function() {
      var n2 = a.current;
      if (n2 && !a.isClosing) {
        a.wrap.removeClass("fancybox-tmp");
        (i3 || "load" === t3 || "resize" === t3 && n2.autoResize) && a._setDimension();
        "scroll" === t3 && n2.canShrink || a.reposition(e2);
        a.trigger("onUpdate");
        l = null;
      }
    }, i3 && !s ? 0 : 300));
  }, toggle: function(e2) {
    if (a.isOpen) {
      a.current.fitToView = "boolean" === t2.type(e2) ? e2 : !a.current.fitToView;
      if (s) {
        a.wrap.removeAttr("style").addClass("fancybox-tmp");
        a.trigger("onUpdate");
      }
      a.update();
    }
  }, hideLoading: function() {
    o.unbind(".loading");
    t2("#fancybox-loading").remove();
  }, showLoading: function() {
    var e2, i3;
    a.hideLoading();
    e2 = t2(a.opts.tpl.loading).click(a.cancel).appendTo("body");
    o.bind("keydown.loading", function(e3) {
      if (27 === (e3.which || e3.keyCode)) {
        e3.preventDefault();
        a.cancel();
      }
    });
    if (!a.defaults.fixed) {
      i3 = a.getViewport();
      e2.css({ position: "absolute", top: 0.5 * i3.h + i3.y, left: 0.5 * i3.w + i3.x });
    }
    a.trigger("onLoading");
  }, getViewport: function() {
    var e2 = a.current && a.current.locked || false, t3 = { x: n.scrollLeft(), y: n.scrollTop() };
    if (e2 && e2.length) {
      t3.w = e2[0].clientWidth;
      t3.h = e2[0].clientHeight;
    } else {
      t3.w = s && window.innerWidth ? window.innerWidth : n.width();
      t3.h = s && window.innerHeight ? window.innerHeight : n.height();
    }
    return t3;
  }, unbindEvents: function() {
    a.wrap && isQuery(a.wrap) && a.wrap.unbind(".fb");
    o.unbind(".fb");
    n.unbind(".fb");
  }, bindEvents: function() {
    var e2 = a.current, i3;
    if (e2) {
      n.bind("orientationchange.fb" + (s ? "" : " resize.fb") + (e2.autoCenter && !e2.locked ? " scroll.fb" : ""), a.update);
      i3 = e2.keys;
      i3 && o.bind("keydown.fb", function(n2) {
        var o2 = n2.which || n2.keyCode, r2 = n2.target || n2.srcElement;
        if (27 === o2 && a.coming) return false;
        n2.ctrlKey || n2.altKey || n2.shiftKey || n2.metaKey || r2 && (r2.type || t2(r2).is("[contenteditable]")) || t2.each(i3, function(i4, r3) {
          if (e2.group.length > 1 && void 0 !== r3[o2]) {
            a[i4](r3[o2]);
            n2.preventDefault();
            return false;
          }
          if (t2.inArray(o2, r3) > -1) {
            a[i4]();
            n2.preventDefault();
            return false;
          }
        });
      });
      t2.fn.mousewheel && e2.mouseWheel && a.wrap.bind("mousewheel.fb", function(i4, n2, o2, r2) {
        var l2 = i4.target || null, s2 = t2(l2), c = false;
        while (s2.length) {
          if (c || s2.is(".fancybox-skin") || s2.is(".fancybox-wrap")) break;
          c = isScrollable(s2[0]);
          s2 = t2(s2).parent();
        }
        if (0 !== n2 && !c && a.group.length > 1 && !e2.canShrink) {
          r2 > 0 || o2 > 0 ? a.prev(r2 > 0 ? "down" : "left") : (r2 < 0 || o2 < 0) && a.next(r2 < 0 ? "up" : "right");
          i4.preventDefault();
        }
      });
    }
  }, trigger: function(e2, i3) {
    var n2, r2 = i3 || a.coming || a.current;
    if (r2) {
      t2.isFunction(r2[e2]) && (n2 = r2[e2].apply(r2, Array.prototype.slice.call(arguments, 1)));
      if (false === n2) return false;
      r2.helpers && t2.each(r2.helpers, function(i4, n3) {
        n3 && a.helpers[i4] && t2.isFunction(a.helpers[i4][e2]) && a.helpers[i4][e2](t2.extend(true, {}, a.helpers[i4].defaults, n3), r2);
      });
    }
    o.trigger(e2);
  }, isImage: function(e2) {
    return isString(e2) && e2.match(/(^data:image\/.*,)|(\.(jp(e|g|eg)|gif|png|bmp|webp|svg)((\?|#).*)?$)/i);
  }, isSWF: function(e2) {
    return isString(e2) && e2.match(/\.(swf)((\?|#).*)?$/i);
  }, _start: function(e2) {
    var i3 = {}, n2, o2, r2, l2, c;
    e2 = getScalar(e2);
    n2 = a.group[e2] || null;
    if (!n2) return false;
    i3 = t2.extend(true, {}, a.opts, n2);
    l2 = i3.margin;
    c = i3.padding;
    "number" === t2.type(l2) && (i3.margin = [l2, l2, l2, l2]);
    "number" === t2.type(c) && (i3.padding = [c, c, c, c]);
    i3.modal && t2.extend(true, i3, { closeBtn: false, closeClick: false, nextClick: false, arrows: false, mouseWheel: false, keys: null, helpers: { overlay: { closeClick: false } } });
    i3.autoSize && (i3.autoWidth = i3.autoHeight = true);
    "auto" === i3.width && (i3.autoWidth = true);
    "auto" === i3.height && (i3.autoHeight = true);
    i3.group = a.group;
    i3.index = e2;
    a.coming = i3;
    if (false !== a.trigger("beforeLoad")) {
      r2 = i3.type;
      o2 = i3.href;
      if (!r2) {
        a.coming = null;
        if (a.current && a.router && "jumpto" !== a.router) {
          a.current.index = e2;
          return a[a.router](a.direction);
        }
        return false;
      }
      a.isActive = true;
      if ("image" === r2 || "swf" === r2) {
        i3.autoHeight = i3.autoWidth = false;
        i3.scrolling = "visible";
      }
      "image" === r2 && (i3.aspectRatio = true);
      "iframe" === r2 && s && (i3.scrolling = "scroll");
      i3.wrap = t2(i3.tpl.wrap).addClass("fancybox-" + (s ? "mobile" : "desktop") + " fancybox-type-" + r2 + " fancybox-tmp " + i3.wrapCSS).appendTo(i3.parent || "body");
      t2.extend(i3, { skin: t2(".fancybox-skin", i3.wrap), outer: t2(".fancybox-outer", i3.wrap), inner: t2(".fancybox-inner", i3.wrap) });
      t2.each(["Top", "Right", "Bottom", "Left"], function(e3, t3) {
        i3.skin.css("padding" + t3, getValue(i3.padding[e3]));
      });
      a.trigger("onReady");
      if ("inline" === r2 || "html" === r2) {
        if (!i3.content || !i3.content.length) return a._error("content");
      } else if (!o2) return a._error("href");
      "image" === r2 ? a._loadImage() : "ajax" === r2 ? a._loadAjax() : "iframe" === r2 ? a._loadIframe() : a._afterLoad();
    } else a.coming = null;
  }, _error: function(e2) {
    t2.extend(a.coming, { type: "html", autoWidth: true, autoHeight: true, minWidth: 0, minHeight: 0, scrolling: "no", hasError: e2, content: a.coming.tpl.error });
    a._afterLoad();
  }, _loadImage: function() {
    var t3 = a.imgPreload = new Image();
    t3.onload = function() {
      (this || e).onload = (this || e).onerror = null;
      a.coming.width = (this || e).width / a.opts.pixelRatio;
      a.coming.height = (this || e).height / a.opts.pixelRatio;
      a._afterLoad();
    };
    t3.onerror = function() {
      (this || e).onload = (this || e).onerror = null;
      a._error("image");
    };
    t3.src = a.coming.href;
    true !== t3.complete && a.showLoading();
  }, _loadAjax: function() {
    var e2 = a.coming;
    a.showLoading();
    a.ajaxLoad = t2.ajax(t2.extend({}, e2.ajax, { url: e2.href, error: function(e3, t3) {
      a.coming && "abort" !== t3 ? a._error("ajax", e3) : a.hideLoading();
    }, success: function(t3, i3) {
      if ("success" === i3) {
        e2.content = t3;
        a._afterLoad();
      }
    } }));
  }, _loadIframe: function() {
    var i3 = a.coming, n2 = t2(i3.tpl.iframe.replace(/\{rnd\}/g, (/* @__PURE__ */ new Date()).getTime())).attr("scrolling", s ? "auto" : i3.iframe.scrolling).attr("src", i3.href);
    t2(i3.wrap).bind("onReset", function() {
      try {
        t2(this || e).find("iframe").hide().attr("src", "//about:blank").end().empty();
      } catch (e2) {
      }
    });
    if (i3.iframe.preload) {
      a.showLoading();
      n2.one("load", function() {
        t2(this || e).data("ready", 1);
        s || t2(this || e).bind("load.fb", a.update);
        t2(this || e).parents(".fancybox-wrap").width("100%").removeClass("fancybox-tmp").show();
        a._afterLoad();
      });
    }
    i3.content = n2.appendTo(i3.inner);
    i3.iframe.preload || a._afterLoad();
  }, _preloadImages: function() {
    var e2 = a.group, t3 = a.current, i3 = e2.length, n2 = t3.preload ? Math.min(t3.preload, i3 - 1) : 0, o2, r2;
    for (r2 = 1; r2 <= n2; r2 += 1) {
      o2 = e2[(t3.index + r2) % i3];
      "image" === o2.type && o2.href && (new Image().src = o2.href);
    }
  }, _afterLoad: function() {
    var i3 = a.coming, n2 = a.current, o2 = "fancybox-placeholder", r2, l2, s2, c, f, d;
    a.hideLoading();
    if (i3 && false !== a.isActive) if (false !== a.trigger("afterLoad", i3, n2)) {
      if (n2) {
        a.trigger("beforeChange", n2);
        n2.wrap.stop(true).removeClass("fancybox-opened").find(".fancybox-item, .fancybox-nav").remove();
      }
      a.unbindEvents();
      r2 = i3;
      l2 = i3.content;
      s2 = i3.type;
      c = i3.scrolling;
      t2.extend(a, { wrap: r2.wrap, skin: r2.skin, outer: r2.outer, inner: r2.inner, current: r2, previous: n2 });
      f = r2.href;
      switch (s2) {
        case "inline":
        case "ajax":
        case "html":
          if (r2.selector) l2 = t2("<div>").html(l2).find(r2.selector);
          else if (isQuery(l2)) {
            l2.data(o2) || l2.data(o2, t2('<div class="' + o2 + '"></div>').insertAfter(l2).hide());
            l2 = l2.show().detach();
            r2.wrap.bind("onReset", function() {
              t2(this || e).find(l2).length && l2.hide().replaceAll(l2.data(o2)).data(o2, false);
            });
          }
          break;
        case "image":
          l2 = r2.tpl.image.replace(/\{href\}/g, f);
          break;
        case "swf":
          l2 = '<object id="fancybox-swf" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="100%"><param name="movie" value="' + f + '"></param>';
          d = "";
          t2.each(r2.swf, function(e2, t3) {
            l2 += '<param name="' + e2 + '" value="' + t3 + '"></param>';
            d += " " + e2 + '="' + t3 + '"';
          });
          l2 += '<embed src="' + f + '" type="application/x-shockwave-flash" width="100%" height="100%"' + d + "></embed></object>";
          break;
      }
      isQuery(l2) && l2.parent().is(r2.inner) || r2.inner.append(l2);
      a.trigger("beforeShow");
      r2.inner.css("overflow", "yes" === c ? "scroll" : "no" === c ? "hidden" : c);
      a._setDimension();
      a.reposition();
      a.isOpen = false;
      a.coming = null;
      a.bindEvents();
      a.isOpened ? n2.prevMethod && a.transitions[n2.prevMethod]() : t2(".fancybox-wrap").not(r2.wrap).stop(true).trigger("onReset").remove();
      a.transitions[a.isOpened ? r2.nextMethod : r2.openMethod]();
      a._preloadImages();
    } else {
      i3.wrap.stop(true).trigger("onReset").remove();
      a.coming = null;
    }
  }, _setDimension: function() {
    var e2 = a.getViewport(), i3 = 0, n2 = false, o2 = false, r2 = a.wrap, l2 = a.skin, s2 = a.inner, c = a.current, f = c.width, d = c.height, p = c.minWidth, u = c.minHeight, h = c.maxWidth, g = c.maxHeight, m = c.scrolling, y = c.scrollOutside ? c.scrollbarWidth : 0, x = c.margin, v = getScalar(x[1] + x[3]), w = getScalar(x[0] + x[2]), b, k, C, O, W, T, _, S, E, L, H, P, R, j, M;
    r2.add(l2).add(s2).width("auto").height("auto").removeClass("fancybox-tmp");
    b = getScalar(l2.outerWidth(true) - l2.width());
    k = getScalar(l2.outerHeight(true) - l2.height());
    C = v + b;
    O = w + k;
    W = isPercentage(f) ? (e2.w - C) * getScalar(f) / 100 : f;
    T = isPercentage(d) ? (e2.h - O) * getScalar(d) / 100 : d;
    if ("iframe" === c.type) {
      j = c.content;
      if (c.autoHeight && 1 === j.data("ready")) try {
        if (j[0].contentWindow.document.location) {
          s2.width(W).height(9999);
          M = j.contents().find("body");
          y && M.css("overflow-x", "hidden");
          T = M.outerHeight(true);
        }
      } catch (e3) {
      }
    } else if (c.autoWidth || c.autoHeight) {
      s2.addClass("fancybox-tmp");
      c.autoWidth || s2.width(W);
      c.autoHeight || s2.height(T);
      c.autoWidth && (W = s2.width());
      c.autoHeight && (T = s2.height());
      s2.removeClass("fancybox-tmp");
    }
    f = getScalar(W);
    d = getScalar(T);
    E = W / T;
    p = getScalar(isPercentage(p) ? getScalar(p, "w") - C : p);
    h = getScalar(isPercentage(h) ? getScalar(h, "w") - C : h);
    u = getScalar(isPercentage(u) ? getScalar(u, "h") - O : u);
    g = getScalar(isPercentage(g) ? getScalar(g, "h") - O : g);
    _ = h;
    S = g;
    if (c.fitToView) {
      h = Math.min(e2.w - C, h);
      g = Math.min(e2.h - O, g);
    }
    P = e2.w - v;
    R = e2.h - w;
    if (c.aspectRatio) {
      if (f > h) {
        f = h;
        d = getScalar(f / E);
      }
      if (d > g) {
        d = g;
        f = getScalar(d * E);
      }
      if (f < p) {
        f = p;
        d = getScalar(f / E);
      }
      if (d < u) {
        d = u;
        f = getScalar(d * E);
      }
    } else {
      f = Math.max(p, Math.min(f, h));
      if (c.autoHeight && "iframe" !== c.type) {
        s2.width(f);
        d = s2.height();
      }
      d = Math.max(u, Math.min(d, g));
    }
    if (c.fitToView) {
      s2.width(f).height(d);
      r2.width(f + b);
      L = r2.width();
      H = r2.height();
      if (c.aspectRatio) while ((L > P || H > R) && f > p && d > u) {
        if (i3++ > 19) break;
        d = Math.max(u, Math.min(g, d - 10));
        f = getScalar(d * E);
        if (f < p) {
          f = p;
          d = getScalar(f / E);
        }
        if (f > h) {
          f = h;
          d = getScalar(f / E);
        }
        s2.width(f).height(d);
        r2.width(f + b);
        L = r2.width();
        H = r2.height();
      }
      else {
        f = Math.max(p, Math.min(f, f - (L - P)));
        d = Math.max(u, Math.min(d, d - (H - R)));
      }
    }
    y && "auto" === m && d < T && f + b + y < P && (f += y);
    s2.width(f).height(d);
    r2.width(f + b);
    L = r2.width();
    H = r2.height();
    n2 = (L > P || H > R) && f > p && d > u;
    o2 = c.aspectRatio ? f < _ && d < S && f < W && d < T : (f < _ || d < S) && (f < W || d < T);
    t2.extend(c, { dim: { width: getValue(L), height: getValue(H) }, origWidth: W, origHeight: T, canShrink: n2, canExpand: o2, wPadding: b, hPadding: k, wrapSpace: H - l2.outerHeight(true), skinSpace: l2.height() - d });
    !j && c.autoHeight && d > u && d < g && !o2 && s2.height("auto");
  }, _getPosition: function(e2) {
    var t3 = a.current, i3 = a.getViewport(), n2 = t3.margin, o2 = a.wrap.width() + n2[1] + n2[3], r2 = a.wrap.height() + n2[0] + n2[2], l2 = { position: "absolute", top: n2[0], left: n2[3] };
    if (t3.autoCenter && t3.fixed && !e2 && r2 <= i3.h && o2 <= i3.w) l2.position = "fixed";
    else if (!t3.locked) {
      l2.top += i3.y;
      l2.left += i3.x;
    }
    l2.top = getValue(Math.max(l2.top, l2.top + (i3.h - r2) * t3.topRatio));
    l2.left = getValue(Math.max(l2.left, l2.left + (i3.w - o2) * t3.leftRatio));
    return l2;
  }, _afterZoomIn: function() {
    var e2 = a.current;
    if (e2) {
      a.isOpen = a.isOpened = true;
      a.wrap.css("overflow", "visible").addClass("fancybox-opened").hide().show(0);
      a.update();
      (e2.closeClick || e2.nextClick && a.group.length > 1) && a.inner.css("cursor", "pointer").bind("click.fb", function(i3) {
        if (!t2(i3.target).is("a") && !t2(i3.target).parent().is("a")) {
          i3.preventDefault();
          a[e2.closeClick ? "close" : "next"]();
        }
      });
      e2.closeBtn && t2(e2.tpl.closeBtn).appendTo(a.skin).bind("click.fb", function(e3) {
        e3.preventDefault();
        a.close();
      });
      if (e2.arrows && a.group.length > 1) {
        (e2.loop || e2.index > 0) && t2(e2.tpl.prev).appendTo(a.outer).bind("click.fb", a.prev);
        (e2.loop || e2.index < a.group.length - 1) && t2(e2.tpl.next).appendTo(a.outer).bind("click.fb", a.next);
      }
      a.trigger("afterShow");
      if (e2.loop || e2.index !== e2.group.length - 1) {
        if (a.opts.autoPlay && !a.player.isActive) {
          a.opts.autoPlay = false;
          a.play(true);
        }
      } else a.play(false);
    }
  }, _afterZoomOut: function(e2) {
    e2 = e2 || a.current;
    t2(".fancybox-wrap").trigger("onReset").remove();
    t2.extend(a, { group: {}, opts: {}, router: false, current: null, isActive: false, isOpened: false, isOpen: false, isClosing: false, wrap: null, skin: null, outer: null, inner: null });
    a.trigger("afterClose", e2);
  } });
  a.transitions = { getOrigPosition: function() {
    var e2 = a.current, t3 = e2.element, i3 = e2.orig, n2 = {}, o2 = 50, r2 = 50, l2 = e2.hPadding, s2 = e2.wPadding, c = a.getViewport();
    if (!i3 && e2.isDom && t3.is(":visible")) {
      i3 = t3.find("img:first");
      i3.length || (i3 = t3);
    }
    if (isQuery(i3)) {
      n2 = i3.offset();
      if (i3.is("img")) {
        o2 = i3.outerWidth();
        r2 = i3.outerHeight();
      }
    } else {
      n2.top = c.y + (c.h - r2) * e2.topRatio;
      n2.left = c.x + (c.w - o2) * e2.leftRatio;
    }
    if ("fixed" === a.wrap.css("position") || e2.locked) {
      n2.top -= c.y;
      n2.left -= c.x;
    }
    n2 = { top: getValue(n2.top - l2 * e2.topRatio), left: getValue(n2.left - s2 * e2.leftRatio), width: getValue(o2 + s2), height: getValue(r2 + l2) };
    return n2;
  }, step: function(e2, t3) {
    var i3, n2, o2, r2 = t3.prop, l2 = a.current, s2 = l2.wrapSpace, c = l2.skinSpace;
    if ("width" === r2 || "height" === r2) {
      i3 = t3.end === t3.start ? 1 : (e2 - t3.start) / (t3.end - t3.start);
      a.isClosing && (i3 = 1 - i3);
      n2 = "width" === r2 ? l2.wPadding : l2.hPadding;
      o2 = e2 - n2;
      a.skin[r2](getScalar("width" === r2 ? o2 : o2 - s2 * i3));
      a.inner[r2](getScalar("width" === r2 ? o2 : o2 - s2 * i3 - c * i3));
    }
  }, zoomIn: function() {
    var i3 = a.current, n2 = i3.pos, o2 = i3.openEffect, r2 = "elastic" === o2, l2 = t2.extend({ opacity: 1 }, n2);
    delete l2.position;
    if (r2) {
      n2 = this.getOrigPosition();
      i3.openOpacity && (n2.opacity = 0.1);
    } else "fade" === o2 && (n2.opacity = 0.1);
    a.wrap.css(n2).animate(l2, { duration: "none" === o2 ? 0 : i3.openSpeed, easing: i3.openEasing, step: r2 ? (this || e).step : null, complete: a._afterZoomIn });
  }, zoomOut: function() {
    var t3 = a.current, i3 = t3.closeEffect, n2 = "elastic" === i3, o2 = { opacity: 0.1 };
    if (n2) {
      o2 = this.getOrigPosition();
      t3.closeOpacity && (o2.opacity = 0.1);
    }
    a.wrap.animate(o2, { duration: "none" === i3 ? 0 : t3.closeSpeed, easing: t3.closeEasing, step: n2 ? (this || e).step : null, complete: a._afterZoomOut });
  }, changeIn: function() {
    var e2 = a.current, t3 = e2.nextEffect, i3 = e2.pos, n2 = { opacity: 1 }, o2 = a.direction, r2 = 200, l2;
    i3.opacity = 0.1;
    if ("elastic" === t3) {
      l2 = "down" === o2 || "up" === o2 ? "top" : "left";
      if ("down" === o2 || "right" === o2) {
        i3[l2] = getValue(getScalar(i3[l2]) - r2);
        n2[l2] = "+=" + r2 + "px";
      } else {
        i3[l2] = getValue(getScalar(i3[l2]) + r2);
        n2[l2] = "-=" + r2 + "px";
      }
    }
    "none" === t3 ? a._afterZoomIn() : a.wrap.css(i3).animate(n2, { duration: e2.nextSpeed, easing: e2.nextEasing, complete: a._afterZoomIn });
  }, changeOut: function() {
    var i3 = a.previous, n2 = i3.prevEffect, o2 = { opacity: 0.1 }, r2 = a.direction, l2 = 200;
    "elastic" === n2 && (o2["down" === r2 || "up" === r2 ? "top" : "left"] = ("up" === r2 || "left" === r2 ? "-" : "+") + "=" + l2 + "px");
    i3.wrap.animate(o2, { duration: "none" === n2 ? 0 : i3.prevSpeed, easing: i3.prevEasing, complete: function() {
      t2(this || e).trigger("onReset").remove();
    } });
  } };
  a.helpers.overlay = { defaults: { closeClick: true, speedOut: 200, showEarly: true, css: {}, locked: !s, fixed: true }, overlay: null, fixed: false, el: t2("html"), create: function(i3) {
    var n2;
    i3 = t2.extend({}, (this || e).defaults, i3);
    (this || e).overlay && this.close();
    n2 = a.coming ? a.coming.parent : i3.parent;
    (this || e).overlay = t2('<div class="fancybox-overlay"></div>').appendTo(n2 && n2.length ? n2 : "body");
    (this || e).fixed = false;
    if (i3.fixed && a.defaults.fixed) {
      (this || e).overlay.addClass("fancybox-overlay-fixed");
      (this || e).fixed = true;
    }
  }, open: function(i3) {
    var o2 = this || e;
    i3 = t2.extend({}, (this || e).defaults, i3);
    (this || e).overlay ? (this || e).overlay.unbind(".overlay").width("auto").height("auto") : this.create(i3);
    if (!(this || e).fixed) {
      n.bind("resize.overlay", t2.proxy((this || e).update, this || e));
      this.update();
    }
    i3.closeClick && (this || e).overlay.bind("click.overlay", function(e2) {
      if (t2(e2.target).hasClass("fancybox-overlay")) {
        a.isActive ? a.close() : o2.close();
        return false;
      }
    });
    (this || e).overlay.css(i3.css).show();
  }, close: function() {
    n.unbind("resize.overlay");
    if ((this || e).el.hasClass("fancybox-lock")) {
      t2(".fancybox-margin").removeClass("fancybox-margin");
      (this || e).el.removeClass("fancybox-lock");
      n.scrollTop((this || e).scrollV).scrollLeft((this || e).scrollH);
    }
    t2(".fancybox-overlay").remove().hide();
    t2.extend(this || e, { overlay: null, fixed: false });
  }, update: function() {
    var t3 = "100%", i3;
    (this || e).overlay.width(t3).height("100%");
    if (r) {
      i3 = Math.max(document.documentElement.offsetWidth, document.body.offsetWidth);
      o.width() > i3 && (t3 = o.width());
    } else o.width() > n.width() && (t3 = o.width());
    (this || e).overlay.width(t3).height(o.height());
  }, onReady: function(i3, n2) {
    var o2 = (this || e).overlay;
    t2(".fancybox-overlay").stop(true, true);
    o2 || this.create(i3);
    if (i3.locked && (this || e).fixed && n2.fixed) {
      n2.locked = (this || e).overlay.append(n2.wrap);
      n2.fixed = false;
    }
    true === i3.showEarly && (this || e).beforeShow.apply(this || e, arguments);
  }, beforeShow: function(i3, o2) {
    if (o2.locked && !(this || e).el.hasClass("fancybox-lock")) {
      false !== (this || e).fixPosition && t2("*").filter(function() {
        return "fixed" === t2(this || e).css("position") && !t2(this || e).hasClass("fancybox-overlay") && !t2(this || e).hasClass("fancybox-wrap");
      }).addClass("fancybox-margin");
      (this || e).el.addClass("fancybox-margin");
      (this || e).scrollV = n.scrollTop();
      (this || e).scrollH = n.scrollLeft();
      (this || e).el.addClass("fancybox-lock");
      n.scrollTop((this || e).scrollV).scrollLeft((this || e).scrollH);
    }
    this.open(i3);
  }, onUpdate: function() {
    (this || e).fixed || this.update();
  }, afterClose: function(i3) {
    (this || e).overlay && !a.coming && (this || e).overlay.fadeOut(i3.speedOut, t2.proxy((this || e).close, this || e));
  } };
  a.helpers.title = { defaults: { type: "float", position: "bottom" }, beforeShow: function(e2) {
    var i3 = a.current, n2 = i3.title, o2 = e2.type, l2, s2;
    t2.isFunction(n2) && (n2 = n2.call(i3.element, i3));
    if (isString(n2) && "" !== t2.trim(n2)) {
      l2 = t2('<div class="fancybox-title fancybox-title-' + o2 + '-wrap">' + n2 + "</div>");
      switch (o2) {
        case "inside":
          s2 = a.skin;
          break;
        case "outside":
          s2 = a.wrap;
          break;
        case "over":
          s2 = a.inner;
          break;
        default:
          s2 = a.skin;
          l2.appendTo("body");
          r && l2.width(l2.width());
          l2.wrapInner('<span class="child"></span>');
          a.current.margin[2] += Math.abs(getScalar(l2.css("margin-bottom")));
          break;
      }
      l2["top" === e2.position ? "prependTo" : "appendTo"](s2);
    }
  } };
  t2.fn.fancybox = function(i3) {
    var n2, r2 = t2(this || e), l2 = (this || e).selector || "", run = function(o2) {
      var s2 = t2(this || e).blur(), c = n2, f, d;
      if (!(o2.ctrlKey || o2.altKey || o2.shiftKey || o2.metaKey) && !s2.is(".fancybox-wrap")) {
        f = i3.groupAttr || "data-fancybox-group";
        d = s2.attr(f);
        if (!d) {
          f = "rel";
          d = s2.get(0)[f];
        }
        if (d && "" !== d && "nofollow" !== d) {
          s2 = l2.length ? t2(l2) : r2;
          s2 = s2.filter("[" + f + '="' + d + '"]');
          c = s2.index(this || e);
        }
        i3.index = c;
        false !== a.open(s2, i3) && o2.preventDefault();
      }
    };
    i3 = i3 || {};
    n2 = i3.index || 0;
    l2 && false !== i3.live ? o.undelegate(l2, "click.fb-start").delegate(l2 + ":not('.fancybox-item, .fancybox-nav')", "click.fb-start", run) : r2.unbind("click.fb-start").bind("click.fb-start", run);
    this.filter("[data-fancybox-start=1]").trigger("click");
    return this || e;
  };
  o.ready(function() {
    var e2, n2;
    void 0 === t2.scrollbarWidth && (t2.scrollbarWidth = function() {
      var e3 = t2('<div style="width:50px;height:50px;overflow:auto"><div/></div>').appendTo("body"), i3 = e3.children(), n3 = i3.innerWidth() - i3.height(99).innerWidth();
      e3.remove();
      return n3;
    });
    void 0 === t2.support.fixedPosition && (t2.support.fixedPosition = function() {
      var e3 = t2('<div style="position:fixed;top:20px;"></div>').appendTo("body"), i3 = 20 === e3[0].offsetTop || 15 === e3[0].offsetTop;
      e3.remove();
      return i3;
    }());
    t2.extend(a.defaults, { scrollbarWidth: t2.scrollbarWidth(), fixed: t2.support.fixedPosition, parent: t2("body") });
    e2 = t2(window).width();
    i2.addClass("fancybox-lock-test");
    n2 = t2(window).width();
    i2.removeClass("fancybox-lock-test");
    t2("<style type='text/css'>.fancybox-margin{margin-right:" + (n2 - e2) + "px;}</style>").appendTo("head");
  });
};
var i = t;
var fancybox_default = i;
export {
  fancybox_default as default
};
