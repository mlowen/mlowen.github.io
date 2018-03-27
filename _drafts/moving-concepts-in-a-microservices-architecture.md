---
layout: article
title:  "Moving Concepts in a Microservices Architecture"
date:   2018-03-26
categories: article
---

For better or worse you've found yourself in the situation where the particular concern you're dealing with no longer fits in the service that it currently lives in. Whether it's because something has changed with the concern or the initial modeling wasn't correct is neither here nor there, these things happen. What happens next is what is important.

This article is going to cover some of the techniques we can use when we find ourselves in this situation and for the purposes of this article the following I’m going to use the following definitions:

* Commands - The synchronous communication for the service used when you want your service to do something, these are commonly mapped to the [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete) actions offered out on a [RESTful](https://en.wikipedia.org/wiki/Representational_state_transfer) interface.
* Events - The asynchronous communication for the service for when you want to notify the ecosystem that something has happened in the service (usually as a result of a command or another event). These are generally offered out over a messaging technology such as [RabbitMQ](https://www.rabbitmq.com/) or [Kafka](https://kafka.apache.org/).

I’ll be discussing techniques for tending to both of these styles of communication, the scenarios that we will be covering in terms of moving events are a 1-to-1 move where the concept is moving wholesale from one service to another and a 1-to-many move where the concept is being split into a set of smaller concepts which could be going to multiple different services.

## Synchronisation

While this approach could fall under techniques for events I wanted to address this option separately because all of the other approaches deal with moving the ownership of the concern to another service. In this approach you add the concern or concerns to their destination without removing the concern from the original service you then keep the data stores of the different services synchronised by using the events from the different services to communicate changes.

Personally I’m not a fan of this approach as it is effectively introduces dual mastery into your ecosystem and all of the complexity and issues of keeping two data repositories synchronised (e.g. what happens when one gets out of sync with the other?) and this only gets worse if you are splitting your concept in a 1-to-many fashion. In cases where I’ve seen something like this done I’ve found that it leads to confusion amongst the developers in regards to which is the go forward option. The advantage of this approach is that compared to some of the others listed below the old service does not incur any run time coupling to the services that the concern has been moved to.

## Commands
### Redirection

This approach is best utilised when commands are exposed by a RESTful API, when the service receives a request for the concern (in the example below a GET) the service will respond with the new location for concern for the client to request.

![](/images/moving-concepts-in-a-microservices-architecture/command-redirect.png)

This approach is best used when the concern is either a straight lift and shift from one service to another with no changes to the contract or the new contract is a superset of the previous version as in the case with the semantics of a 301 redirect the client will be expecting the redirected request to behave the same as it previously did.

### API Composition

This approach is best suited for the situation where when removing a concern from a service you split it amongst multiple services.

![](/images/moving-concepts-in-a-microservices-architecture/command-composition.png)

This approach is also applicable in the case where a concern has moved between services but the redirect approach is not applicable e.g. the contract has a breaking change. In this case rather than

This approach can also be used in the case where the concept has been moved to another service

## Events
### Multi-Publish
### Republish

## What next?

The key takeaway from this article is that when moving concerns between services no matter what approach we take we will be left with some level of technical debt, which will need to be remedied in the future. What we need to focus on is the trade offs of the various approaches and how they fit with the constraints on your ecosystem.
