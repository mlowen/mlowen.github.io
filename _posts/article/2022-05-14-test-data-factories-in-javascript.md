---
layout: article
title:  "Test data factories in javascript"
date:   2022-05-14
categories: article
tags: javascript, js, testing, test, data, test data
---

Friday the 13th was a quiet evening and when the rest of the family were in bed or watching TV I chose to play around with a bit of the thought experiment. This time unlike others I wrote up what I was doing as I went along, what follows is a tidied up and expanded version of the notes that I took. While I was doing this I was primarily using two tools - [RunJS](https://runjs.app/) for my javascript REPL playground and [Typora](https://typora.io/) for my notes.

In the ruby world I'm a fan of [factory_bot](https://github.com/thoughtbot/factory_bot) for generating objects that will serve as test data in my unit tests. I had a bit of time to kill this evening and thought it would be fun to implement the subset of the functionality that I use in factory_bot in javascript to see how I would approach it.

For those unfamiliar with factory_bot is an implementation of the factory pattern to generate objects as alternative to using fixtures in tests. This approach allows you to generate your test data in a known and expected way will allow you to overwrite any  properties of the object as appropriate for the test. This approach allows you to remove a bunch of duplicate code from your tests. As an example of how I would use this in my current project I have a front end driven by APIs below is a sample payload from one of the APIs

```json
	{
  "_links": [
    {
      "href": "/clients/898f3b58-6c16-40f7-bf29-c9dac868bb2c",
      "rel": "self"
    },
    {
      "href": "/clients/",
      "rel": "up"
    },
    {
      "href": "/organisations/1f7c161a-8de1-44ff-9ac3-e36ecc01dfdc",
      "rel": "organisation"
    }
  ],
  "_type": "urn:emboss:client",
  "name": "Testing",
  "oauth": {
    "id": "738542d0-e1fb-40c3-8786-8b47119d9151",
    "secret": "************************f8c644399992"
  }
}
```

Rather than have multiple copies of this object in the codebase each just slightly different to the last, what I'd like to do is have something like the following:

```javascript
const payload = build(payloadFactory, { name: "Development" });
```

Where the second argument contains any overrides you want to make to the base object. I've got a bit of a quiet evening so lets play around with this idea, first lets define what we want a factory to look like. Considering that I'm restricting the functionality to only building objects what's wrong with what was defined in the example payload? It's simple and it works, we can assign it to variable call it our factory and pass it into a build function with some overrides to modify some of the properties to create a resulting object. Following that line of thinking the first version of our build function is as simple as:

```javascript
function build(factory, overrides = {}) {
  return { ...factory, ...overrides };
}
```

As a generalisation this works great until we want to have more than one instance of our object, the simple solution to that is you overwrite more data to make each unique but you end up finding yourself having to do that a lot, wouldn't it be neat if we could build in some automated uniquness into our factories? To acheive this what I'll do is extend our definition of a factory such that if any property of the factory is an function then it will be called to generate the value of the field in the resulting object. A simple example would be this factory:

```javascript
const factory = { foo: 1, bar: () => true };
```

would result in

```javascript
{ foo: 1, bar: true }
```

This would mean that should we actually want a property of the resulting object to be a function we'd have to do something like:

```javascript
const factory = {
  foo: 1,
  bar: () => { 
    return () => console.log("I'm a method on the object!");
  }
}
```

What would that mean for our `build` method though? That gets a little more complicated now, first we want to generate the appropriate value for any field, which would take the `key` of the field, the `factory` which defines it and finally the `overrides` the method to do that would look like:

```javascript
function populate(key, factory, overrides) {
  if (key in overrides) { return overrides[key]; }
  if (factory[key] instanceof Function) { return factory[key](); }

  return factory[key];
}
```

Next we want to construct the object from the factory based on the properties in the factory like so:

```javascript
function build(factory, overrides = {}) {
  return Object.keys(factory).reduce((obj, key) => {
    return {
      ...obj,
      [key]: populate(key, factory, overrides)
    };
  }, {});
}
```

This will do what we want, it will allow you to use a library like [Faker](https://fakerjs.dev/) to generatedata to populate your object,  it may not be the fastest way to do it but I think it's pretty legible. A nice side effect of this approach is this allows our factories to use other factories to define some of their properties, like so:

```javascript
const factory1 = {
  foo: 1,
  bar: () => true
};

const factory2 = {
  tar: "string",
  baz: () => build(factory1)
}
```

The next step in complexity for our factories is to introduce dependencies, there are times when you want to populate data in your factory in a specific order, a simple example of this could be a factory like:

```javascript
const factory = {
  firstName: () => faker.name.firstName(),
  lastName: () => faker.name.lastName(),
  fullName: () => '??'
}
```

We don't have a way to set it up so that `fullName` will be populated with `firstName + ' ' + lastName `, my thoughts around this would be to declare the dependencies on the method like so and pass the in progress object in like so:

```javascript
const factory = {
  firstName: () => faker.name.firstName(),
  lastName: () => faker.name.lastName(),
  fullName: (obj) => `${obj.firstName} ${obj.lastName}`
}

factory.fullName.dependencies = [ 'firstName', 'lastName' ];
```

It would also be nice if that was wrapped in a helper function so the factory looks (IMO) cleaner:

```javascript
const factory = {
  firstName: () => faker.name.firstName(),
  lastName: () => faker.name.lastName(),
  fullName: dependantProperty((obj) => `${obj.firstName} ${obj.lastName}`, [ 'firstName', 'lastName' ])
}
```

This however breaks our current build function, first we don't pass the object into the populate method and secondly we have no gaurantee on the order in which the properties will be populated. To solve this I'm going to order the keys to populate them in the appropriate order (though I'm not handling circular dependencies). Then to make sure that the population methods have the appropriate context to populate the object so it will now pass the object into the method when populating.

```javascript
function populate(key, obj, factory, overrides) {
  if (key in overrides) { return overrides[key]; }
  if (factory[key] instanceof Function) { return factory[key](obj); }

  return factory[key];
}

function build(factory, overrides = {}) {
  const order = (prev, current) => {
    if (prev.includes(current)) { return prev; }
    if (factory[current] instanceof Function && factory[current].dependencies) {
      return [ ...factory[current].dependencies.reduce(order, prev), current ];
    }

    return [ ...prev, current];
  }

  return Object.keys(factory).reduce(order, []).reduce((obj, key) => {
    return {
      ...obj,
      [key]: populate(key, obj, factory, overrides)
    };
  }, {});
}
```

Again I've prioritised readability over performance, this was actually my second attempt [my first attempt](https://gist.github.com/mlowen/d166770ec96815949aa24aaa1f71f9c2) combined everything into a single function and felt very messy. Lastly I with the `build` method only populating the resulting object with the fields present in the factory I thought it gives us the oppotunity to pass additional context data into the factory via the `overrides` parameter and then pass that along to the property population method, allowing you to write population methods like so:

```javascript
const factory = {
  name: dependantProperty(
    (obj, context) => context.nickName ?? `${obj.firstName} ${obj.lastName}`, 
    [ 'firstName', 'lastName' ]
  ),
  firstName: () => faker.name.firstName(),
  lastName: () => faker.name.lastName(),
}

build(factory, { nickName: 'Bob' });
```

Another neat aspect of the approach taken to defining factories is that you get extending factories for free by using the spread operator. If we take the above factory and wanted a new factory that extends it to includ an email address we could achieve it like so:

```javascript
const subfactory = {
  ...factory,
  email: () => faker.internet.email()
};
```

This was a fun thought experiment about how I could bring some functionality from a library I like in a different language into javascript. It isn't however a 1-1 port of the functionality of factory_bot just the pieces that I found interesting to play around with in an evening. I've setup the code in a [git repository](https://github.com/mlowen/td-builder) if you want to have a look at it in its entirety, given time I may come back and further tune it and publish it to [NPM](https://www.npmjs.com/).