---
layout: article
title:  "Autoloading Handlers in Tornado"
date:   2020-02-02
categories: article
tags: python, tornado, routes, code, api
---

In one of my current side projects I'm building out a service written in [Python](https://www.python.org/) which exposes a RESTful API. In situations like this the library that I reach for is [Tornado](https://www.tornadoweb.org/) as I find it to be lightweight and doesn't do more than I need it to (much like my ruby preference [Sinatra](http://sinatrarb.com/)).

When structuring my Tornado projects I create a module per handler and restrict a single handler to a single resource (I would count `/url-path-a/`, `/url-path-b`, & `/url-path-b/id` to all be separate resources). The basic file structure will look something like the following:

```
/-
 | - app.py
 | - handlers/-
              | - __init__.py
              | - handler_one.py
              | - handler_two.py
```

In the `handlers/__init__.py` I import the handler classes from the respective modules so I can write `handlers.HandlerOne` rather than `handlers.handler_one.HandlerOne`. Tying it all together is the `app.py` which defines the routes (the mappings between URL and handler), in it's simplest form looks it like the following:

```python
import asyncio
import tornado.ioloop
import tornado.web

import handlers

if __name__ == '__main__':
    app = tornado.web.Application([
        (r'/one', handlers.HandlerOne),
        (r'/two', handlers.HandlerTwo)
    ])

    app.listen(3000)

    tornado.ioloop.IOLoop.current().start()
```

You could imagine with an app of a reasonable complexity that this could become a sizable list. There are a couple of things that I'm not a fan of with this approach. The first is that adding a new handler requires touching three files, two of which are minor tweaks and something that could be easily forgotten. I'm a fan of [convention over configuration](https://en.wikipedia.org/wiki/Convention_over_configuration) and would prefer a situation where I add a file to the right directory and it is all wired up automatically. The second is that I like to have the definition of the route to be as close to the handler as possible so that when working on the handler you can have as much context as possible without needing to jump around the code base.

While neither of these are big annoyances (they aren't deal breakers by any means) I thought this would be an interesting opportunity to play around with solving these issues with the [reflection](https://en.wikipedia.org/wiki/Convention_over_configuration) capabilities built into python. To begin I moved the definition of mapping of the route to the handler to be closer to the handler, for those unfamiliar with Tornado a route is defined as a [tuple](https://docs.python.org/3/library/stdtypes.html?#tuples). After defining the handler I added the route, assigning it to the `ROUTE` constant like so:

```python
from tornado.web import RequestHandler

class HandlerOne(RequestHandler):
    def get(self):
        self.write('Hello from one')

ROUTE = (r'/one', HandlerOne)
```

Each module that contains handler should also define the `ROUTE` constant and later we will use that convention to determine if we can load a route from the module.

Now that we have our routes defined we need to load them. To do this we will add some code to the `__init__.py` of the `Handlers` module which will be responsible for loading the routes. All of the routes that are loaded from the modules will be added to a `ROUTES` constant that will be exposed from the `Handlers` module. The first part to do is to iterate through all of the files in the directory and skip any files which are not python files:

```python
FILES = listdir(dirname(realpath(__file__)))

for name, extension in [splitext(f) for f in FILES if f != __file__]:
    if extension != ".py":
        continue
```

Once we are only dealing with the python files we are able to load them in to the running application: 

```python
mod = import_module("{0}.{1}".format(__name__, name))
```

I'm using the the [`import_module`](https://docs.python.org/3/library/importlib.html#importlib.import_module) method from the `importlib` package in the standard library to load the files into the application. This method takes the name of the module to load and returns a reference to the module. Because in python a module maps to a directory or a file we can use the file name (sans extension) for the last part of the module and as we are running this from `__init__.py` we know the name of the parent module can be found in the `__name__` variable so we can create the full name of the module to be loaded without hard coding any module names.

Once the module has been loaded [`getattr`](https://docs.python.org/3/library/functions.html#getattr) is used to load the `ROUTE` constant we defined earlier:

```python
route = getattr(mod, "ROUTE", None)
```

I am using `getattr` rather than using `mod.ROUTE` because the final argument to `getattr` allows us to define what will be returned if `ROUTE` has not been defined in the module. In this case I've specified `None` as the default value. If we just accessed `mod.ROUTE` and it did not exist on the module an `AttributeError` would be thrown that would need to be handled.

We've loaded something from the module that we believe is a route, we need to verify this before we expose it to the wider application. We do this by first checking that the module actually does expose a route (e.g. the value of the `route` variable is not `None`) and that it is of the type we are expecting. Earlier I mentioned that a route is defined as a tuple, we can use [`isintance`](https://docs.python.org/3/library/functions.html?#isinstance) to test this is the case.

```python
if route is not None and isinstance(route, tuple):
    ROUTES.append(route)
```

When we bring all of the individual parts of loading our routes together the contents of the `__init__.py` look like the following:

```python
from os import listdir
from os.path import dirname, realpath, splitext
from importlib import import_module

ROUTES = []

if not __name__.endswith("__init__"):
    FILES = listdir(dirname(realpath(__file__)))

    for name, extension in [splitext(f) for f in FILES if f != __file__]:
        if extension != ".py":
            continue

        mod = import_module(".{0}".format(name), __name__)
        route = getattr(mod, "ROUTE", None)

        if route is not None and isinstance(route, tuple):
            ROUTES.append(route)
```

You'll note in the full example that we are not running this if the `__name__` variable ends in `__init__` this is being done so that we don't try and run this code multiple times which will cause it to throw a run time exception.

This then has an impact on `app.py` where it no longer is has to be responsible for defining all of the routes for the application, leading to something which looks much cleaner in my opinion:

```python
import tornado.ioloop
import tornado.web

import handlers

if __name__ == '__main__':
    app = tornado.web.Application(handlers.ROUTES)
    app.listen(3000)

    tornado.ioloop.IOLoop.current().start()
```

The trade off with using this approach is there is no single place in code that you can go to see all of the routes that are exposed by the application. I believe that having the fuller context with each route is worth the trade off. For those who still want to view all of the routes for an application they could do so using the python shell:

![](/images/autoloading-handlers-in-tornado/view-routes.gif)

For those so inclined you could also build this functionality into the app itself. A working version of the example code for this article can be found over at [Github](https://github.com/mlowen/tornado-autoload-handlers).

