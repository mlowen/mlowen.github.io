---
layout: article
title:  "A follow up to writing AMD compliant jQuery plugins"
date:   2015-05-13
categories: article
---

I had previously written about [writing AMD compliant jQuery plugins](/article/2014/05/30/writing-amd-compliant-jquery-plugins/) where I went through writing a [jQuery](http://jquery.com/) plugin that was exposed in the [traditional method](http://learn.jquery.com/plugins/basic-plugin-creation/) as well as an [AMD module](http://en.wikipedia.org/wiki/Asynchronous_module_definition). The final version that was presented in that previous article was:

```js
(function() {
	var init = function ($) {
		$.fn.colourise = function(color) {
			this.each(function(index, item) {
				$(item).css('color', color);
			});

			return this;
		};
	}

	if (typeof define === 'function' && define.amd) {
		console.log('Creating an amd module.');

		define([ 'jquery' ], init);
	} else {
		console.log('Loading into global scope.');

		init(jQuery);
	}
})();
```

```js
(function() {
	var init = function ($) {
		$.fn.colourise = function(color) {
			this.each(function(index, item) {
				$(item).css('color', color);
			});

			return this;
		};
	}

	amdAvailable = typeof define === 'function' && define.amd;

	if (amdAvailable)
		define([ 'jquery' ], init);

	if (jQuery)
		init(jQuery);
	else if (!amdAvailable)
		throw 'Unable to detect jQuery';
})();
```
