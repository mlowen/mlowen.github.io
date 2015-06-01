---
layout: article
title:  "Introducing Knockout-SinglePage"
date:   2015-06-01
categories: article
---

I've found that when working on a side project I have the tendency to write a component which I think will stand really nicely on its own so I start extracting it out, I effectively had a side project from my side project. It last happened when I was [playing around with commonmark](/article/2014/12/07/adventures-with-commonmark/) and it has happened again with my latest project [Knockout-SinglePage](https://github.com/mlowen/knockout-singlepage).

Knockout-SinglePage is a javascript library for writing [single page applications](http://en.wikipedia.org/wiki/Single-page_application) using [Knockout](http://knockoutjs.com/). Unlike many other libraries which use Knockout to achieve similar functionality they do so by building a framework on top of Knockout whereas Knockout-SinglePage takes the approach of being an extension to the core Knockout library. Knockout-SinglePage uses [knockout components](http://knockoutjs.com/documentation/component-overview.html) and the [HTML 5 browser history API](http://diveintohtml5.info/history.html) to provide most of its functionality so that we can keep the layer of code on top relatively thin.

In the rest of this article I am going to give you a basic introduction for setting up your first application with Knockout-SinglePage. In what is a first for me this library is available via [Bower](http://bower.io/) which is also the preferred method for distribution, it can be installed with the following command:

```
bower install knockout-singlepage
```

Once you have Knockout-Singlepage installed the next thing that needs to be done is to setup a page to host our application.

```html
<html>
	<head>
		<script type="text/javascript" src="<path to scripts>/knockout.js"></script>
		<script type="text/javascript" src="<path to scripts>/knockout-singlepage.js"></script>
	</head>
	<body>
		<h1>App title</h1>
		<div id="app"></div>

		<script type="text/javascript" src="<path to scripts>/app.js"></script>
	</body>
</html>
```

Any content that is loaded by the application will be displayed in `<div id="app"></div>`. Where the magic starts to happen is in `app.js`, as mentioned previously Knockout-SinglePage uses knockout components so the first thing that we want to do is register some components that can be loaded.

```js
ko.components.register('default', { template: 'This is the default template<br /><a href="/another-page">Go to another page</a>' });
ko.components.register('another', { template: 'This is another page<br /><a href="/">Go back to the default page</a>' });
```

Now that we have some content that can be loaded we need to setup some routes so that we know when to load the content. For Knockout-SinglePage routes are an array of objects each route at its simplest is made up of a `name` which identifies the route and the URL which will determine when it is displayed. It is important that the name of the route matches the name of a component so that we know what component should be loaded when we match the URL.

```js
var routes = [
	{ name: 'default', url: '/' },
	{ name: 'userprofile', url: '/another-page' }
];
```

The URLs for the routes also support route parameters which in the form of a portion of the URL prefixed with a colon `:` like so `/user/:id` that URL will extract the route portion marked by `:id` into a variable passed to the component view model. Now that we have components registered and the routes defined it is time to start the application, unlike traditional Knockout where you call `ko.applyBindings()` we instead initialise Knockout-SinglePage like so:

```js
ko.singlePage.init(routes, document.getElementById('app'));
```

The last parameter which identifies the element that we will be loading our components into is optional, when it is not supplied the content is loaded directly into the `<body>` tag. For more in-depth information about how to use Knockout-SinglePage you can visit the [GitHub repository](https://github.com/mlowen/knockout-singlepage) and view the README, if you want to contribute check out the [issues at GitHub](https://github.com/mlowen/knockout-singlepage/issues) or raise an issue on how you think the library can be improved.
