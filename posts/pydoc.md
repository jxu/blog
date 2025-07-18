# Python's Documentation Is Still Terrible

This is a comment I left on a Github issue on why docs.python.org has poor SEO.
I'm reposting it because it's something I've wanted to write about for a long time.

---

I don't believe in Google conspiracy - they're lower ranked simply because they're BAD and thus people don't want to use them. I felt this way when I first started learning python, and I still do even though I know most of the language basics.

Take the `.strip()` string method for example. 
![image](https://github.com/user-attachments/assets/87f8bbb3-3190-4215-9ba3-5d3ab1fa666a)

It's 2024 and it still says the very unfriendly "No Information Available", while linking to 3.4 docs. So I go to https://docs.python.org/3.4/library/stdtypes.html and what do I get? A gigantic page titled "4. Built-in Types". Wait, I thought I was looking for strip! 
![image](https://github.com/user-attachments/assets/8461f2f8-fc2f-4b09-b456-427daaa03c9d)

So how do I get there? Well first I need to know that the function will be under string methods and is actually called `str.strip()`. If I go to 4.7. Text Sequence Type - `str` (why not just call it String Type `str`??) and to String Methods, I have to page down 8 screens to get to the function (next to nearly useless functions `str.swapcase()` and `str.title()`).

If you want to be user-friendly, you should have one page per TYPE, per CLASS, and in the best case per METHOD. If I google `numpy sin`, I get a page https://numpy.org/doc/stable/reference/generated/numpy.sin.html that is exactly what I'm looking for! Nothing more, nothing less. It tells me what the parameters and return values are, and there's no guesswork with expected types. If I look up "javascript array push", I get a whole MDN page https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push. If I look up "python list extend", I get ONE LINE of information. What's the time complexity? Can it fail? Does it modify in-place or return a new list? There has to be more info.

I see this term maybe overused on Stack Overflow but this issue is an "XY Problem". The issue asks why the docs SEO is atrocious, when it should be asking why the docs themselves are atrocious. (There's speculation from large youtube creators that its infamous "algorithm" is the same way - if you want to be consistently recommended, you have to be worthwhile and quality first.) It's mind-boggling to me that a language as massive and successful as python would never improve its languishing documentation.

