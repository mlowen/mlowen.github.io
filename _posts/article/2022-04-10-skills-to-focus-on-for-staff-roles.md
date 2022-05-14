---
layout: article
title:  "Skills to focus on for staff+ roles"
date:   2022-04-10
categories: article
tags: Individual contributor, IC, Staf+, career
---

Recently a senior developer at work who is on the individual contributor (IC) path asked for advice as what they should be focussing on as they progress towards a staff+ role. Reflecting on the feedback I realised that with a bit of generalisation it would be useful for anyone looking to step up into a staff+ style of role. With the permission of the developer who requested the guidance here is an edited and slightly expanded version of the feedback I gave.

A bit of context around the advice given the company I work for is a SaaS product company currently going on a journey to transform our monolith into a service based architecture, this does influence some of the advice and recommendations that have been given. 

I'm the sort of person whose learning style suits asorbing information from books and then using little projects (when I can) to apply that knowledge. As such I make recommendations of a few books throughout this post, these are all books that I have myself.

---

As you progress your technical skills while important become less relevant in many respects. In my mind what differentiates an intermediate from a senior from a staff+ engineer is increasing less about technical skill as you go along and much more about what are traditionally called ["soft skills"](https://en.wikipedia.org/wiki/Soft_skills), though I've never been a big fan of the term as I think these are the skills tend to be more difficult to master. As a generalisation communication is always a good thing to keep working on as it will become probably your core tool in your toolbox. The IC path is one that is centered around influence without authority and most of what you end up doing is trying to convince people to do things in the way you suggest.

In terms of specific skill sets that become more prominent when working in staff+ roles it's my opinion that you would want to focus on the following.

## Strategic thinking

As you progress down the IC path you will have more and more influence on company and engineering strategy so it is important to get your head in that space. This can range from how do you ensure you are supporting the broader strategy and how do you foster and create the appropriate strategies and vision for engineers informed by what the company is doing. Part of the role of a staff+ engineer is to provide the guiding light to rest of the engineering capability. A good write up around formulating strategies can be [found at StaffEng](https://staffeng.com/guides/engineering-strategy), a book mentioned in there that I have also had recommended to me by others is [Good Strategy / Bad Strategy](http://goodbadstrategy.com/), I must admit this is one on my to read list but I've had enough people I respect talk well about it that I got a physical copy.

## Product thinking 

You will find yourself making more and more product decisions or at the very least in assisting in them. While a product manager is ultimately accountable for a product roadmap or strategy as a staff+ engineer I believe it is a shared responsibility between the two roles to develop those artefacts. You'll also find yourself being asked more and more product orientated questions by engineers as well so it is important that you build up that product skillset especially working if you continue working for product companies. A few books I might recommend are:

* [Lean Startup](http://theleanstartup.com/)
* [The Lean Product Handbook](https://leanproductplaybook.com/)
* [Product Roadmaps Relaunched](https://www.bookdepository.com/Product-Roadmaps-Relaunched/9781491971727)
* [Escaping the Build Trap](https://melissaperri.com/book)

## Tradeoff analysis

This again is another key skill set that will come into play, to quote Neal Ford 

> There are no right or wrong answers in architecture—only trade-offs.

Understanding the tradeoffs is also about how do you influence where you system is going in the future. Many times this may be unintentionally setting the direction for the architecture for the system. Where possible you should avoid concreting over a door and making a decision reversible if possible. When making faced with deciding between tradeoffs and making decisions a good question to ask yourself is "do I need to make this choice now?". Sometimes it's better to wait to gather more information and make an informed decision and wait for [the last responsible moment](https://blog.codinghorror.com/the-last-responsible-moment/).

One of the core responsibilities of a staff+ engineer in my opinion is balancing emergent vs intentional architecture. Intentional architecture is what you set out to build initially and emergent is what presents itself as you begin to actually build the system. In my experience most of the time the emergent architecture is usually the preferred option, it usually presents itself due to the discovery of new information. At the heart of this balance is making sure you understand the tradeoffs of following either path.

During delivery this quite often presents itself as when do we take on technical debt, which is always a tough decision and one where the manta _"Perfection is the enemy of good enough"_ comes into play. At the end of the day the most important thing is deliverying business value, the code and architecture can be perfect but if it's not out in the world being used it doesn't really matter. You can always come back and fix up incurred debt (it's a different problem if not given that opportunity). In my experience and opinion the systems that usually have the higher levels of tech debt are new systems which brings to mind a quote by Reid Hoffman: 

> If you are not embarrassed by the first version of your product, you’ve launched too late.

Now all this is not to say you should always take the option to incur technical debt but it's important to understand the tradeoffs when making any decision. I think it was Neal Ford or Sam Newman who also said that (and I'm paraphrasing):

> Every decision has trade offs, if you think you've found one that doesn't it just means you haven't found it yet.

## Systems Thinking

Perhaps of all of the areas of focus here this is the one that comes most naturally to a developer, the key here is lifting up the level of abstraction which you are working at. Where you may be used to working at the class/function/story level you are having to hoist yourself up to understanding the impact on the entire system. I'd go so far that you need to make sure that you are operating at a level of abstraction where you understand the impacts on the people and process of either the company or the customer.

## Stakeholder Management

Thinking on all of the above another of the key responsibilities of a staff+ engineer is stakeholder management. You'll be wanting to understand who they are balancing their various needs and wants and how that will impact the system that is being built. This also includes making sure they understand the impacts that technical strategies and decisions will have on them. One of the things I see people new to the role overlook is that the development teams are also stakeholders that you need to account for.

## General Advice

From here I would like to offer more generalised advice from my own journey that I hope you find valuable. Starting with some advice that I got when I first moved into an IC leadership role regarding the developers in my team (I had just stepped into a technical lead role):

> Just because it's not the way you'd do it, doesn't mean that it's wrong.

This is something that I still struggle with at times (I think it comes from being overly opinionated when the mood takes me), it is something that I've needed to loosen up on. Though loosening up can also be detrimental at times, where teams may go too far off the reservation, which is likely more to do with a lack of guard rails for the team to operate within. I've also in my time come to value a hunger to learn and adapt over straight skill sets when it comes to working with developers. Skills can be taught but that type of mindset it a lot harder to embed in someone who doesn't have it.

An architects or staff+ engineer (I consider the roles to be largely analogous) is a very amorphous role and will generally change to fill the "gaps" in an organisation this has also been referred to as [being glue](https://noidea.dog/glue). While your focus will be on the more technical side of things, the people side should not be ignored. Much like DevOps can be described as the intersection of people, process, and technology the same can very much be said about architecture - after all that's why [Conway's law](https://en.wikipedia.org/wiki/Conway's_law) is a thing. You will find yourself involved and helping to guide and define organisational change it can be helpful to have a view on how these sort of things could work and the impact it will have on how you build your systems, I've found [team topologies](https://itrevolution.com/team-topologies/) to be one that works well for my mental model.

Now I know I said that I don't think that technical knowledge isn't as important it is not something that should be neglected, here are the list of technical books that I've found to be useful in my role/career:

* [Fundamentals of Software Architecture](https://www.thoughtworks.com/insights/books/fundamentals-of-software-architecture)
* [Building Evolutionary Architectures](https://www.thoughtworks.com/insights/books/building-evolutionary-architectures)
* [Building Microservices](https://samnewman.io/books/building_microservices/)
* [Monolith to Microservices](https://samnewman.io/books/monolith-to-microservices/)
* [Designing Distributed Systems](https://www.bookdepository.com/Designing-Distributed-Systems-Brendan-Burns/9781491983645)
* [Domain Driven Design Distilled](https://www.bookdepository.com/Domain-Driven-Design-Distilled-Vaughn-Vernon/9780134434421)
* [The Phoenix Project](https://itrevolution.com/the-phoenix-project/)
* [The Unicorn Project](https://itrevolution.com/the-unicorn-project/)

And because I do love me some dead trees on my shelf here are a set of books I have on my backlog that I'm working my way through slowly but surely that I think could be applicable/interesting.

* [Staff Engineer](https://staffeng.com/book) (Currently reading)
* [EDGE: Value Driven Digital Transformation](https://www.thoughtworks.com/insights/books/edge)
* [Project to Product](https://projecttoproduct.org/the-book/)
* [Building Event Driven Microservices](https://www.bookdepository.com/Building-Event-Driven-Microservices-Adam-Bellemare/9781492057895)
* [Coders](https://www.penguinrandomhouse.com/books/539883/coders-by-clive-thompson/)
* [An Elegant Puzzle](https://press.stripe.com/an-elegant-puzzle)
* [Lovability](https://www.aha.io/lovability)
* [The Mom Test](http://momtestbook.com/)