---
layout: article
title:  "Back to Linux"
date:   2014-02-02
categories: article
---

If there is one thing that I learned while redeveloping [mlowen.com](http://mlowen.com/) is that developing a rails app on Windows is not something that I'm all to keen to do again so this weekend I set up an [Ubuntu](http://www.ubuntu.com/) and got cracking. While the set up went a lot smoother this time around there was one thing that I noticed that I was missing - on windows I use [posh-git](http://dahlbyk.github.io/posh-git/) pretty much due to the extra information that it displays in the prompt. With that in mind I thought it would be a nice way to get myself back into the groove of Linux with a bit of [bash](http://en.wikipedia.org/wiki/Bash_(Unix_shell)) scripting.

Thankfully there were a couple of really good posts doing similar things to what I was wanting to do:

* [Show Git information in your prompt](http://bytebaker.com/2012/01/09/show-git-information-in-your-prompt/) by Shrutarshi Basu.
* [Bedazzle Your Bash Prompt with Git Info](http://www.railstips.org/blog/archives/2009/02/02/bedazzle-your-bash-prompt-with-git-info/) by John Nunemaker.

While neither of these sites did exactly what I was after they gave me a great starting point for messing around with how the prompt is displayed.

While scripting the prompt changes one thing that kept popping into my mind was that one of the things that I really love about where I work is our tendency to script as much as we can. We have a repository of powershell cmdlets which are invaluable when it comes to the amount of time that they save us and I was curious if I could use this as an opportunity to replicate that sort of environment for bash. The result of that little experiment can be found over [on Github](https://github.com/mlowen/dev_scripts), the idea behind this is a place for me to collect any useful scripts I may or may not write and an easy way to integrate it into the shell. Currently the only piece of functionality that is provided from that repository is adding the git information to the prompt but I hope in times that more will be added.

* Dev Scripts - [github.com/mlowen/dev_scripts](https://github.com/mlowen/dev_scripts)
