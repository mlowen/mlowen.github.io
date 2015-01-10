---
layout: post
title:  "Writing AMD compliant jQuery plugins"
date:   2014-05-30
categories: article
---

Recently at work we've been moving towards using [AMD modules](http://en.wikipedia.org/wiki/Asynchronous_module_definition) loaded with [require.js](http://requirejs.org/) to do some really neat stuff around client side UI composition. Because we live in a world where some of our products are using modules and others are not it makes it interesting when we want to write some common javascript code which we want to be exposed to both worlds, we notice this most often when we are exposing functionality via [jQuery plugins](http://learn.jquery.com/plugins/). In this article I'm not going to go over how to create a jQuery plugin as that has been covered by others many times before, instead I'm going to show you how to write a plugin that will play nice in both an AMD and non-AMD world.

If we use the following simple jQuery plugin which changes the text colour of the element it is applied to as an example a traditional jQuery plugin would look like the following.

```js
(function ($) {
	$.fn.colourise = function(color) {
		this.each(function(index, item) {
			$(item).css('color', color);
		});

		return this;
	};
})(jQuery);
```

When invoking this plugin in a page it would look something like this.

```html
<html>
	<head>
		<title>jQuery plugin example</title>
	</head>
	<body>
		<ul>
			<li class="red">Red</li>
			<li class="green">Green</li>
			<li class="blue">Blue</li>
			<li class="red">Red</li>
			<li class="green">Green</li>
			<li class="blue">Blue</li>
		</ul>

		<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
		<script src="jquery.colourise.js"></script>
		<script>
			$(function() {
				$('.red').colourise('#F00');
				$('.green').colourise('#0F0');
				$('.blue').colourise('#00F');
			});
		</script>
	</body>
</html>
```

Looking at our example the plugin requires jQuery to be loaded into the global scope, which is all fine and dandy if you aren't using require to load up your javascript as soon as you do the console will be full of errors. Right so instinct dictates that next we change our plugin to be loaded as an AMD module.

```js
define([ 'jquery' ], function($) {
	$.fn.colourise = function(color) {
		this.each(function(index, item) {
			$(item).css('color', color);
		});

		return this;
	};
});
```

Then update our page to load our javascript through require.

```html
<html>
	<head>
		<title>jQuery plugin with require</title>
	</head>
	<body>
		<ul>
			<li class="red">Red</li>
			<li class="green">Green</li>
			<li class="blue">Blue</li>
			<li class="red">Red</li>
			<li class="green">Green</li>
			<li class="blue">Blue</li>
		</ul>

		<script src="//cdnjs.cloudflare.com/ajax/libs/require.js/2.1.11/require.min.js"></script>
		<script>
			requirejs.config({
				'paths': {
					'jquery': '//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min',
				},
				'urlArgs': 'bust=' + (new Date()).getTime()
			});

			require([ 'jquery', 'jquery.colourise' ], function($) {
				$(function() {
					$('.red').colourise('#F00');
					$('.green').colourise('#0F0');
					$('.blue').colourise('#00F');
				});
			});
		</script>
	</body>
</html>
```

This will indeed solve our issue of our plugin not working with require. However at the start of this article I mentioned that we live in a world where not everyone is using require to load up their javascript, our revised plugin neglects this world and forces the users of the plugin to also use require. We want to give the developers the freedom to develop their software how they choose, so being able to load a plugin with and without require is an issue that javascript library developers need to care about now we are living in this dual world scenario.

To solve this lets look at the creation of our plugin in both scenarios, in our current examples the definition of our plugin is tied directly into the registration of the plugin. What if we were to separate that out into a different function, then we could then try and detect if we can create AMD modules and create one if possible otherwise register the plugin in the global scope. We also need to be careful that we aren't polluting the global scope with the definition of our plugin we are going to handle that by wrapping the definition and registration of the plugin in a self-executing anonymous function. Our resulting plugin ends up looking like the following:

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

	if(typeof define === 'function' && define.amd) {
		console.log('Creating an amd module.');

		define([ 'jquery' ], init);
	} else {
		console.log('Loading into global scope.');

		init(jQuery);
	}
})();
```

The above example will work with both of our previous page examples and allows the users of the plugin to develop in whichever way suits them. This approach however is not perfect, if you are working on a site which is a transitional phase where it is using a mixture of libraries loaded in the global scope and loading some libraries with require and you need your plugin to work on the libraries loaded in the global scope then you will be in trouble as the plugin will only be available to code loaded through require.
