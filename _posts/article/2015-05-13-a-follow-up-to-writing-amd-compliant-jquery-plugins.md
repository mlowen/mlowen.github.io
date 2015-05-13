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

That example works fine as long as you are exclusively loading your javascript using AMD modules or including the files manually. However it isn't always this way in the real world if you are transitioning a legacy code base over to AMD modules there will be a period of time where you are going to want to have things like jQuery plugins exposed both via the traditional method and as an AMD module. I wanted to take the opportunity to update the original example so that it is exposed via both methods at the same time.

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

The changes that have been made are only quite minor and are focused around where the exposition happens. First we moved the exposition via the traditional method out of the else statement and into its own if statement, it is here we also check if jQuery is available before loading something that wasn't being done previously. The second change we made was to move the checking if AMD modules are available out of the `if` condition and into a variable, this was done so that when we check if jQuery is not available we can decide if we want to throw an error based on whether the plugin is exposed via another method.

Though the changes are minor it does make your code more friendly and easier to use for those developers who are currently in a transitionary stage where only some things are being exposed via AMD modules. The more friendly your code is to these different scenarios the more likely developers will choose your plugin to use.
