Many times I have thought about what a smaller subset of C that still retains reasonable usability would look like. This would make the language standard simpler and smaller, compiler writing easier, and maybe even enable more optimized compilation. The only C subset that has substantial effort I know of is [C0](http://c0.typesafety.net/) developed at Carnegie Mellon University, used for teaching basic programming and compilers. However C0 is not of practical use as it has only 32-bit integer types, no floating point support, no explicit memory management, etc. 

What is included in my hypothetical C subset depends on how minimal the subset is and how much specialized use and/or legacy support is desired. For example: is `goto` really necessary for a structured programming language? There's decades of academic debate. Maybe it's ok only jumping forward for exiting out of many loops, where higher level languages would use exceptions. How about `setjmp()`/`longjmp()`? [This answer](https://stackoverflow.com/a/14686051) argues that by not performing cleanup it is almost never the correct solution for the problem at hand. What about bitfields? They have implementation-defined specifics such as endianness and addressable storage unit alignment (spanning boundaries). Bitmasks do the same thing but are much more portable, but maybe bitfields are cleaner for internal code use. If 95% of C code can get by without a feature, maybe it is worth leaving out in an effort to strip down a language to its most essential parts. All in all, as a C beginner, I'm not in any position to say. (Completely getting rid of control flow jumps is going to be very hard, though.)

More practical than inventing a subset of C is to simply follow existing rules and guidelines, such as the [SEI CERT C Coding Standard](https://wiki.sei.cmu.edu/confluence/display/c/SEI+CERT+C+Coding+Standard). I looked through the rules and recommendations and they all look very reasonable, and I highly recommend reading the rules as general good programming practice. For example, a `goto` chain is recommended specifically for the case of cleaning up resources in the case of error [MEM12-C], but not in general. There are a bunch of recommendations for `setjmp()`/`longjmp()` at [MSC22-C] (and those functions are definitely not needed for C++). There is also the recommendation to not make assumptions regarding layout of bitfields [EXP11-C]. Other standards exist, such as the widely used MISRA and NASA JPL Coding Standards for C (available for free online and pretty short to read). The related "Power of Ten" rules from JPL has as their first rule not to use jump constructs (or even recursion). 

----------

For fun, here's a conservative arbitrarily-chosen list of mostly historical cruft C language features that I would get rid of. I came up with these after skimming through K&R C Appendix A, based on the ANSI C standard. The problem with removing features conservatively is that it doesn't leave a much smaller subset of C. Of the small amount of C code I have read, none require the use of any of the following.

- `auto` keyword: [apparently completely useless](https://stackoverflow.com/questions/2192547/where-is-the-c-auto-keyword-used). This is not the same as C++ `auto` which was repurposed to be quite handy.

- `register` keyword: a compiler hint that is pretty much useless nowadays as compiler optimizations have gotten better. (`restrict` is still useful.)

- Octal: only use case is probably for Linux permission bits. If really needed, the language could use Python-style `0o` prefix which would be consistent and reduce much confusion.

- `wchar_t` and wide string functions: originally designed for wide characters, but is implementation-defined making it useless for portability. That is what `char16_t` and `char32_t` are for (in C99, `uint_least16_t` and `uint_least32_t`). According to Unicode standard: "The width of `wchar_t` is compiler-specific and can be as small as 8 bits. Consequently, programs that need to be portable across any C or C++ compiler should not use `wchar_t` for storing Unicode text. The `wchar_t` type is intended for storing compiler-defined wide characters, which may be Unicode characters in some compilers."

- `char` as a distinct type from `signed char` and `unsigned char`: a reasonable default is to follow all other C integer data types and default to unsigned.

- C locales: global state and messes with standard functions in nasty ways, and almost never in a useful way. See [wm4's mpv rant](https://github.com/mpv-player/mpv/commit/1e70e82baa9193f6f027338b0fab0f5078971fbe). 

- Trigraphs(??!): Cliche under-handed code.



