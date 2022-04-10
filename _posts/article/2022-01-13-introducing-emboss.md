---
layout: article
title:  "Introducing Emboss"
date:   2022-01-13
categories: article
tags: REST, api, HTTP, PDF, SaaS, Emboss
---

I would like to introduce a side project that I've been working on Emboss. Emboss provides a RESTful API to transform HTML & CSS into a PDF and a management UI on top of it. This is a tool that is intended to be integrated into a broader system that needs to generate dynamic PDFs. 

Now the first thing your asking is why HTML? There are already libraries available for generating PDFs. That there is but those libraries generaly have their own [DSL](https://en.wikipedia.org/wiki/Domain-specific_language) that involves precisely specifying exactly where to draw things on a document that feel anything but user friendly, whereas HTML is a common technology that many people already know and have to work with. It also allows us to open up who can build the underlying PDF from developers to anyone who knows how to write HTML. 

The next question you're probably asking is couldn't we just use [wkhtmltopdf](https://wkhtmltopdf.org/) and be done with it? Sure if you really want to, it's a good and popular tool, but do you really want to build more software that you have to maintain? Further below in the post I'm going to go through my current roadmap for Emboss that goes beyond the capabilities that go beyond what you get from a tool like wkhtmltopdf

I'll do a longer post at some point but at a high level Emboss is comprised of an RESTful API using [Python](https://www.python.org/) & [Flask](https://flask.palletsprojects.com/), an application with a [React](https://reactjs.org/) + [Redux](https://redux.js.org/) client and a [Node](https://nodejs.org/) back end managing sessions and acting as a backend for frontend. It also utilises [Keycloak](https://www.keycloak.org/) as the identity provider. 

Now without further ado, I'd like to present my first demo of Emboss. In this demo I walk through the first time experience of a user signing into Emboss:

* Creating an organisation.
* Creating a client.
* Transforming some HTML into a PDF.

<iframe width="537" height="336" src="https://www.youtube.com/embed/9C-highp5G0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

While this demo walks through the application itself I've built out more of the API layer which you can find the spec (I wouldn't call it documentation yet) [on stoplight](https://emboss.stoplight.io/docs/emboss/YXBpOjY4Njc2-emboss-api).

## The Why

In my day job I don't spend much time hands on keyboard writing code, I still get to do some but not a lot. Most of my time is spent in conversation with folks or writing about patterns, practices, architecture, and strategy. In my opinion the goal of a role like mine (I'm currently a principal engineer) is to enable others to help and allow them to build great things.

I also believe that for me to be useful and relevant in my role I also need to keep cutting code to try new things and keep my skillset reasonably current in an effort to not end up holed up in an ivory tower disconnected from the changes that happen in our industry. 

Usually with my side projects I generally solve what I think is the interesting problem and then lose interest and put it on the metaphorical shelf to gather dust. As such my hard drive is full of half finished projects, in September [Sara Chipps](https://twitter.com/SaraJChipps) tweeted the following:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">What is the difference between a Staff level engineer and a Manager? <br>.<br>.<br>.<br>.<br>.<br>.<br><br>One of them thinks they code for a living.</p>&mdash; sarajo.eth (@SaraJChipps) <a href="https://twitter.com/SaraJChipps/status/1433868053712969730?ref_src=twsrc%5Etfw">September 3, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

I'd be lying to say this tweet didn't hit a little too close to home and while it wasn't the trigger for this project it did light a fire in me to prove to myself that I want to ship something, if for nothing else to remind myself that I can do it. In this case I'm being generous with myself and counting this blog post and the demo video above as shipping something I do plan to deploy Emboss for others to use in the future this is just the first stepping stone in that direction.

So far I've written very much about the personal motivation to build something, but not Emboss in particular. The reason for that is a lot shorter, during my career I have seen the problem of generating PDFs arise multiple times and each time whoever I'm working for ends up rolling their own solution to this problem. Now there are solutions that already exist in this space but for a variety of reasons they don't quite provide what I believe is required in this space, so I thought I'd take a crack at it.

## What's Next?

What I've presented in this demo is very bare bones and not yet MVP, there's still plenty of functionality that I want to build. In rough priority order the road map contains the following items:

* UI for managing user access and permissions (the API is already built).
* Accept a JSON payload for generating a document, this will allow for consumors of the API to supply both HTML and CSS as seperate attributes along with meta attributes to resolve relative links and set meta data on the PDF.
* Add templates, this would allow users to manage the templates within Emboss and then when making the request to generate the PDF the request only needs to contain the data to populate the template.
* Support "meta" formats for the content in templates and when generating PDFs, this would include supporting things like [CommonMark](https://commonmark.org/) and [Sass](https://sass-lang.com/).
* Storing generated PDFs.
* Supporting batch jobs, this would allow a user to specify a template and supply a list of datasets used to generate multiple documents in a single submission.
* Data regarding the number of documents that have been generated.

One of the bigger questions I am still to answer in regards to this project is how do I want to make this available? Is this something that I want to run as a side hustle, offering it as a SaaS with paid subscriptions? Or do I want to package it up and make it available as an open source solution? At this point if I'm honest I'm not sure.

I plan to blog at least monthly with a demo video to provide an update on my progress, I hope you follow along on the journey. If you have any feedback or feature suggestions please feel free to reach out.