---
layout: article
title:  "Hurdles I encountered bundling LESS on MVC 5 with DotLESS"
date:   2015-02-07
categories: article
---

When it comes to CSS [LESS](http://lesscss.org/) is my preprocessor of choice, mostly because it's the one I have the most experience with. On one of my current personal projects I was using [grunt](http://gruntjs.com/) set up as a post build task to compile LESS to CSS. Recently I discovered the [System.Web.Optimization.Less](http://www.nuget.org/packages/System.Web.Optimization.Less/) nuget package which uses [DotLESS](http://www.dotlesscss.org/) to do the compilation.

In this article I do not want to go through the steps of setting up System.Web.Optimization.Less and DotLess in your project as there are already good [existing tutorials](http://www.brendanforster.com/blog/yet-another-implement-less-in-aspnetmvc-post.html) on how to do that. Instead what I want to focus on is the issues that I encountered with how I structured my LESS files and how I worked around them.

To start of with lets look at a generic example of how I structure my LESS files in most projects that I work on. At the file level it is usually laid out in the following fashion.

```
/-
 |- app.less
 |- variables.less
 |- mixins/-
           |- mixin-1.less
           |- mixin-2.less
           |- mixin-3.less
 |- components/-
               |- component-1.less
               |- component-2.less
               |- component-3.less
               |- component-4.less
```

Where `app.less` is the core file that ties everything together and is usually the only file that is turned into CSS. The contents of `app.less` is composed of import statements like below.

```css
@import 'components/component-1.less';
@import 'components/component-2.less';
@import 'components/component-3.less';
@import 'components/component-4.less';
```

The `variables.less` file as you can probably guess is where all of the common values that are used over multiple mixins and components such as colours and font sizes are defined. I try an keep the mixins in separate grouped by similarity (e.g. all of the mixins for lists are in a single file) in the hopes that this makes reuse of the mixins easier.

The component files usually map to either a page or a common element used within the site, it is here that mixins are pulled together with other CSS to create the styles that will be used in the site, in most cases they look something similar to below.

```css
@import (reference) '../variables.less';

@import (reference) '../mixins/mixin-1.less';
@import (reference) '../mixins/mixin-3.less';

.class-name {
	.mixin-1-1(@variable);
	.mixin-3-1(@variable-2);

	border: 1px solid @border-colour;
}
```

Now that the stage is set it is time to start delving into the issues that I encountered after the transition to using DotLESS. The first roadblock that I came across was the around importing files. I like the [`@import (reference)`](http://lesscss.org/features/#import-options) statement when you are importing LESS files into other files from a good practices point of view. When using `@import (reference)` will import a file so you can use the mixins or variables from the other file without outputting the contents of the file into the your file, what this means for me is that it's a bit of a safety net if I don't declare a mixin correctly I don't have to worry about polluting my resulting CSS file. However there is [an issue in DotLESS](https://github.com/dotless/dotless/issues/378) where it does not support import options other than `once`. All of a sudden my saftey net was gone and I had to remove all of the `@import (reference)` statements from my LESS files.

The other big hurdle that I faced was regarding the order in which files were imported, I had a component file which had a set of imports which looked like:

```css
@import '../mixins/mixin-1.less';
@import '../mixins/mixin-2.less';
@import '../mixins/mixin-3.less';
```

The nature of the issue that I was seeing was the LESS compilier complaining that it could not find the mixins that were in the `../mixins/mixin-2.less` file but no errors about the file itself. To be on the safe side I ran my LESS through lessc from the [less npm package](https://www.npmjs.com/package/less) and it still compilied just fine. On a hunch I swapped `mixin-1.less` and `mixin-2.less` sure enough now I was getting an error that it could not find the mixins from `../mixins/mixin-1.less`. Then I went back to the original setup and swapped `mixin-2.less` and `mixin-3.less` however the compiler was still complaining about the mixins from `mixin-2.less`. What was the common thread between `mixin-1` and `mixin-2`? It turned out that unlike `mixin-3.less` the other two imports both imported the `variables.less` file, this appears to cause the second file imported to silently fail compilation in a meaningful way and instead all you get is the behaviour described above.

To solve that issue in the end I had to remove all of the imports from a component and mixin files and move them all to the  

The easiest way I found to solve this was to move all of my imports into the `app.less` and removing them from each of the individual file which resulted in an `app.less` where I need to care about the order of my imports more than I think I need to, in the end the file looked something like what is below.

```css
@import 'variables.less';

@import 'mixins/mixin-1.less';
@import 'mixins/mixin-2.less';
@import 'mixins/mixin-3.less';

@import 'components/component-1.less';
@import 'components/component-2.less';
@import 'components/component-3.less';
@import 'components/component-4.less';
```

While writing up this article I came across an issue on the [dotLESS github repo](https://github.com/dotless/dotless/issues/352) which sounds very similar to the issue that I encountered. However the solution prescribed to that issue - adding `disableVariableRedefines="true"` to the dotLess section of the web.config did not work for me. It also appears that this issue has only been introduced in the new version of dotLESS so perhaps downgrading to 1.3.1 could also solve the issue.

Hopefully this article will help others who transition over to using bundling to transform their LESS files as I do believe that this is better than having a number of compiled (and minified) CSS files in your repository which when working in a team environment have the tendency to be the place where merge conflicts occur.
