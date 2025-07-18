# Blog Un-downgrade

Writing all my blog posts in raw HTML was a funny idea, but in the end I was too comfortable with the familiar minimal markup of Markdown to change my ways. 

The reason for even considering that option is my absurd quest for blog minimalism. At first I wanted no JS and random blog theme bloat on the site, which was easy to clear out, but then I didn't like the complexity of having a whole blog generator to run. The issue is of course you can't write Markdown and give users an HTML site without some kind of conversion/publishing process. The silly options are thus 

1. Write Markdown and publish to HTML with a minimal blog generator (such as pandoc and everyone's favorite build tool, Make)
2. Write HTML directly (idea from last time)
3. Write Markdown alone and don't even bother with a website. Users will have to download the repo and read Markdown on their own device OR more likely read on GitHub using its repo Markdown previewer (seems to require JS in the browser, unlike a plain HTML page).

What could be more minimalist than just Markdown files and no site at all? Incidentally, even after I took out all Jekyll-related files, https://jxu.github.io/blog still builds a Jekyll blog in GitHub pages unless a `.nojekyll` file is present. The lazy option is to not bother with a site at all, but I'll probably experiment with a pandoc-based build solution for fun sometime in the future.
