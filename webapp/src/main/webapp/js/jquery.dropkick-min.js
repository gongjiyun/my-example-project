!function(e,t,n){"use strict";var a=navigator.userAgent.match(/MSIE ([0-9]{1,}[\.0-9]{0,})/),i=!!a,r=i&&parseFloat(a[1])<7,o=navigator.userAgent.match(/iPad|iPhone|Android|IEMobile|BlackBerry/i),d={},l=[],s={left:37,up:38,right:39,down:40,enter:13,tab:9,zero:48,z:90,last:221},c=['<div class="dk_container {{ isDisabled }}" id="dk_container_{{ id }}" tabindex="{{ tabindex }}" aria-hidden="true">','<a class="dk_toggle dk_label">{{ label }}</a>','<div class="dk_options">','<ul class="dk_options_inner" role="main" aria-hidden="true">',"</ul>","</div>","</div>"].join(""),p='<li><a data-dk-dropdown-value="{{ value }}">{{ text }}</a></li>',u={startSpeed:400,theme:!1,changes:!1,syncReverse:!0,nativeMobile:!0,autoWidth:!0},f=null,k=null,h=function(e,t,n){var a,i,r,o;a=e.attr("data-dk-dropdown-value"),i=e.text(),r=t.data("dropkick"),o=r.$select,o.val(a).trigger("change"),i.length>22&&i.substr(0,22),t.find(".dk_label").text(i),n=n||!1,!r.settings.change||n||r.settings.syncReverse||r.settings.change.call(o,a,i)},v=function(){},g=function(e,t,n){var a=e.find(".dk_options_inner"),i=t.prevAll("li").outerHeight()*t.prevAll("li").length,r=a.scrollTop(),o=a.height()+a.scrollTop()-t.outerHeight();(n&&"keydown"===n.type||r>i||i>o)&&a.scrollTop(i)},_=function(){},m=function(e,t,n){t.find(".dk_option_current").removeClass("dk_option_current"),e.addClass("dk_option_current"),g(t,e,n)},b=function(t,n){var a,i,r,o,d,l,c,p=t.keyCode,u=n.data("dropkick"),f=String.fromCharCode(p),k=n.find(".dk_options"),g=n.hasClass("dk_open"),b=k.find("li"),w=n.find(".dk_option_current"),C=b.first(),x=b.last();switch(p){case s.enter:g?w.hasClass("disabled")||(h(w.find("a"),n),v(n)):_(n,t),t.preventDefault();break;case s.tab:g&&(w.length&&h(w.find("a"),n),v(n));break;case s.up:i=w.prev("li"),g?i.length?m(i,n,t):m(x,n,t):_(n,t),t.preventDefault();break;case s.down:g?(a=w.next("li").first(),a.length?m(a,n,t):m(C,n,t)):_(n,t),t.preventDefault()}if(p>=s.zero&&p<=s.z){for(r=(new Date).getTime(),null===u.finder||void 0===u.finder?(u.finder=f.toUpperCase(),u.timer=r):r>parseInt(u.timer,10)+1e3?(u.finder=f.toUpperCase(),u.timer=r):(u.finder=u.finder+f.toUpperCase(),u.timer=r),o=b.find("a"),d=0,l=o.length;l>d;d++)if(c=e(o[d]),0===c.html().toUpperCase().indexOf(u.finder)){h(c,n),m(c.parent(),n,t);break}n.data("dropkick",u)}},w=function(t){return e.trim(t).length>0?t:!1},C=function(t,n){var a,i,r,o,d,l=t.replace("{{ id }}",n.id).replace("{{ label }}",n.label).replace("{{ tabindex }}",n.tabindex).replace("{{ isDisabled }}",n.isDisabled),s=[];if(n.options&&n.options.length)for(i=0,r=n.options.length;r>i;i++)o=e(n.options[i]),d=0===i&&void 0!==o.attr("selected")&&void 0!==o.attr("disabled")?null:p.replace("{{ value }}",o.val()).replace("{{ current }}",w(o.val())===n.value?"dk_option_current":"").replace("{{ disabled }}",void 0!==o.attr("disabled")?"disabled":"").replace("{{ text }}",e.trim(o.html())),s[s.length]=d;return a=e(l),a.find(".dk_options_inner").html(s.join("")),a};r||(n.documentElement.className=n.documentElement.className+" dk_fouc"),d.init=function(t){return t=e.extend({},u,t),c=t.dropdownTemplate?t.dropdownTemplate:c,p=t.optionTemplate?t.optionTemplate:p,this.each(function(){var n,a,i=e(this),r=i.find(":selected").first(),d=i.find("option"),s=i.data("dropkick")||{},p=i.attr("id")||i.attr("name"),u=t.width||i.outerWidth(),f=i.attr("tabindex")||"0",h=!1,v=void 0!==e(this).attr("disabled")?"gd-disable":"";return s.id?i:(s.settings=t,s.tabindex=f,s.id=p,s.$original=r,s.$select=i,s.value=w(i.val())||w(r.attr("value")),s.label=r.text(),s.options=d,s.isDisabled=v,h=C(c,s),s.settings.autoWidth&&h.find(".dk_toggle").css({width:u+"px"}),i.before(h).appendTo(h),h=e('div[id="dk_container_'+p+'"]').fadeIn(t.startSpeed),n=t.theme||"default",h.addClass("dk_theme_"+n),s.theme=n,s.$dk=h,i.data("dropkick",s),h.addClass(i.attr("class")),h.data("dropkick",s),l[l.length]=i,h.on("focus.dropkick",function(){k=h.addClass("dk_focus")}).on("blur.dropkick",function(){h.removeClass("dk_focus"),k=null}),o&&s.settings.nativeMobile&&h.addClass("dk_mobile"),s.settings.syncReverse&&i.on("change",function(t){var n=i.val(),a=e('a[data-dk-dropdown-value="'+n+'"]',h),r=a.text();r=a.text().length>22?a.text().substr(0,22):a.text(),h.find(".dk_label").text(r),s.settings.change&&s.settings.change.call(i,n,r),m(a.parent(),h,t)}),a=i.attr("form")?e("#"+i.attr("form").replace(" ",", #")):i.closest("form"),void(a.length&&a.on("reset",function(){i.dropkick("reset")})))})},d.theme=function(t){var n=e(this).data("dropkick"),a=n.$dk,i="dk_theme_"+n.theme;a.removeClass(i).addClass("dk_theme_"+t),n.theme=t},d.reset=function(){return this.each(function(){var t,n=e(this).data("dropkick"),a=n.$dk,i=e('a[data-dk-dropdown-value="'+n.$original.attr("value")+'"]',a);t=n.label.length>22?n.label.substr(0,22):n.label,n.$original.prop("selected",!0),a.find(".dk_label").text(t),m(i.parent(),a)})},d.setValue=function(t){return this.each(function(){var n=e(this).data("dropkick").$dk,a=e('.dk_options a[data-dk-dropdown-value="'+t+'"]',n);a.length?h(a,n)|m(a.parent(),n):console.warn("There is no option with this value in "+n.selector)})},d.refresh=function(){return this.each(function(){var t,n,a=e(this).data("dropkick"),i=a.$select,r=a.$dk;a.options=i.find("option"),n=C(c,a).find(".dk_options_inner"),r.find(".dk_options_inner").replaceWith(n),t=e('a[data-dk-dropdown-value="'+i.val()+'"]',r),m(t.parent(),r)})},e.fn.dropkick=function(e){if(!r){if(d[e])return d[e].apply(this,Array.prototype.slice.call(arguments,1));if("object"==typeof e||!e)return d.init.apply(this,arguments)}},e(function(){e(n).on(i?"mousedown":"click",".dk_options a",function(){var t=e(this),n=t.parents(".dk_container").first();return t.parent().parent().parent().parent().hasClass("gd-disable")?(v(n),!1):(t.parent().hasClass("disabled")||(h(t,n),m(t.parent(),n),setTimeout(function(){n.removeClass("dk_open dk_open_top"),f=null},3)),!1)}),e(n).on("keydown.dk_nav",function(e){var t;f?t=f:k&&(t=k),t&&b(e,t)}),e(n).on("click",null,function(t){if(e(t.target).parent().hasClass("gd-disable"))return!1;var n,a=e(t.target);if(f&&0===a.closest(".dk_container").length)v(f);else{if(a.is(".dk_toggle, .dk_label"))return n=a.parents(".dk_container").first(),n.hasClass("dk_open")?v(n):(f&&v(f),_(n,t)),!1;a.attr("for")&&e("#dk_container_"+a.attr("for"))[0]&&e("#dk_container_"+a.attr("for")).trigger("focus.dropkick")}});var a="onwheel"in t?"wheel":"onmousewheel"in n?"mousewheel":"MouseScrollEvent"in t?"DOMMouseScroll MozMousePixelScroll":!1;a&&e(n).on(a,".dk_options_inner",function(e){var t=e.originalEvent.wheelDelta||-e.originalEvent.deltaY||-e.originalEvent.detail;return i?(this.scrollTop-=Math.round(t/10),!1):t>0&&this.scrollTop<=0||0>t&&this.scrollTop>=this.scrollHeight-this.offsetHeight?!1:!0})})}(jQuery,window,document);