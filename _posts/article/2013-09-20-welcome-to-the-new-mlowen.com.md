---
layout: post
title:  "Welcome to the new mlowen.com"
date:   2013-09-20
categories: article
---

A while ago the server which was hosting my old blog was shut down and I didn't do much about it, it had been a while since I had posted anything there and a lot of the content that was there wasn't of the highest quality so for a while I decided to leave it be. Over time this decision began to grate on me I felt that as someone whose career is very much built around the Internet that I should have more of a presence on it, the only question was how to bring mlowen.com back.

This site is the answer to that question, here I hope to provide two things thought out articles based on some of my experiences and discoveries as a software developer and a place to look in on what I'm currently working on. Over the next little while I hope to port over some of the more useful content from my old blog into the new site.

# Markdown

I'm a big fan of [markdown](http://en.wikipedia.org/wiki/Markdown) two of my [favourite](http://www.stackoverflow.com) [sites](http://www.github.com) use it pretty heavily. One of the key reasons I'm a big fan of markdown is that it allows me to fall back on HTML when the functionality doesn't to display something doesn't exist within markdown itself. This won't be my last foray with markdown, I have a couple of upcoming personal projects which will also be relying pretty heavily on it as well.

# Journal entries

After reading the [journals of Jordan Mechner](http://jordanmechner.com/ebook/) I thought it would be an interesting idea to include a more journal like format to compliment the articles. The journal entries are designed to be shorter in length detailing what I'm doing in regards to the personal projects that I'm currently working on, leaving articles to be focused on more researched topics.

# The stack

One of the things I wanted to achieve with this site is to work with a stack that I'm unfamiliar with, that reason coupled with the fact that it has been on my list of things to learn led me to choosing [Ruby on Rails](http://rubyonrails.org/) to build the site with. I still decided to use windows as my primary development environment which caused me some issues which I plan on detailing in a later article. In terms of database I again wanted to go with a choice I didn't have much experience with which led me to [PostgreSQL](http://www.postgresql.org/).

I spent some time looking for a suitable hosting provider which would give me decent value for money, I ended up going with [host4geeks](http://host4geeks.com/) so far I've been very happy with both the VPS and the level of service they have provided. The VPS I'm using is running Ubuntu 13.04 server which again due to doing the development in windows caused a few issues come deployment time. The server itself is running [Nginx](http://nginx.org/) and [Passenger](https://www.phusionpassenger.com/) which were pretty straight forward to set up thanks to [a guide by Marcin Kulik](http://blog.lunarlogic.io/2013/setup-fresh-ubuntu-server-for-ruby-on-rails/).

Other technologies that have been a great help in building the site are:

* [LESS](http://lesscss.org/)
* [Markdown](http://en.wikipedia.org/wiki/Markdown)
* [Knockout.js](http://knockoutjs.com/)
* [Goggle code prettify](https://code.google.com/p/google-code-prettify/)

# Future plans

This site is far from finished, there are several features which are still missing that I'm looking at adding in the near future:

* Pages
* Images in articles/journal entries.
* RSS feeds.
* Comments on articles.

Outside of the audience facing features the admin system is pretty bare bones at the moment and while it serves for what I want it requires a lot of work before it is
