---
layout: post
title:  "Adventures with CommonMark"
date:   2014-12-07
categories: article
---

It's no secret that I am a fan of [markdown](http://en.wikipedia.org/wiki/Markdown) I think it is a great way to write for the internet, in fact most of the content on this site is powered by it. I was also quite excited when [Jeff Atwood and others](http://blog.codinghorror.com/standard-flavored-markdown/) announced [CommonMark](http://commonmark.org/) I like the idea that the content I write in my preferred editor ([MarkdownPad 2](http://markdownpad.com/) in this case) will look the same when I post it here or up on GitHub.

Recently I've been working on a new project which uses CommonMark quite heavily for it's content as part of it I had started building some utilities around CommonMark. This weekend I decided to take a break from the side project and instead extract some of those utilities out into their own independent libraries.

## Knockout.CommonMark

The first of these libraries is [Knockout.CommonMark](https://github.com/mlowen/Knockout.CommonMark) provides [Knockout](http://knockoutjs.com/) bindings for CommonMark which allows knockout developers to do:

```html
<div data-bind="commonmark: text"></div>
```

The contents of text will be parsed as CommonMark markdown and rendered as HTML, as far as knockout bindings go I think this one is pretty simple the heart of it is the following method.

```js
function(ko, commonmark) {
	var reader = commonmark.DocParser();
	var writer = commonmark.HtmlRenderer();

	var convert = function (element, valueAccessor) {
		var accessor = valueAccessor();
		var actual = typeof accessor === 'function' ? accessor() : accessor;

		element.innerHTML = actual ? writer.render(reader.parse(actual)) : '';
	};

	ko.bindingHandlers.commonmark = { init: convert, update: convert };
};
```

The rest is just how this plugin is exposed either via an [AMD module](http://en.wikipedia.org/wiki/Asynchronous_module_definition) or by loading it into the global scope, using the method I wrote about in [this earlier post](http://mike.lowen.co.nz/article/2014/05/30/writing-amd-compliant-jquery-plugins).

## CommonMark.Editor

The other library I want to mention today is [CommonMark.Editor](https://github.com/mlowen/CommonMark.Editor) a bootstrap based CommonMark editor which is loosely inspired by the Github markdown editor. This library is a [jQuery](http://jquery.com/) plugin which is currently only exposed as an AMD module, once you have all the setup for the library done invoking looks like

```html
<html>
	<head>
		<link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.1/css/bootstrap.min.css" />
	</head>
	<body>
		<div class="container">
			<div class="page-header">
				<h1>CommonMark Editor</h1>
			</div>

			<div id="editor"></div>
		</div>

		<script src="http://cdnjs.cloudflare.com/ajax/libs/require.js/2.1.15/require.min.js"></script>
		<script>
			require([ 'jquery', 'commonmark.editor' ], function ($) {
				var editor = $('#editor').commonMarkEditor();
			});
		</script>
	</body>
</html>
```

The basics of the editor works however it is not yet as feature complete as I would like it, when I started moving this out into it's own library I realised I wasn't very happy with my original implementation and decided to scrap it and start from sratch. I want to add the following to it in the near future:

* Knockout binding.
* Programmatically setting/getting the content of the editor.
