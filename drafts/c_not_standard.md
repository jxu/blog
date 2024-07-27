I first learned C through informal tutorials online and in college classes, when I really should've learned from a reliable book like K&R C. Many online tutorials and almost all my peers make assumptions about what C should do, which are usually correct on a modern 64-bit Debian-based system with GCC. Case in point: I was writing Arduino code for a clock and I didn't realize `int`s were only 16 bits on the platform until after debugging.

Most of these are well-known, nonetheless I wanted to collect ones I found interesting. This doesn't even include the quirks with `printf` formatting or using C string functions.

The [SEI Cert C Coding Standard provides](https://wiki.sei.cmu.edu/confluence/display/c/SEI+CERT+C+Coding+Standard) a good list of pitfalls.
For data types, [C data types on Wikipedia](https://en.wikipedia.org/wiki/C_data_types) is a good quick resource. 

Table: C99 standard and "reasonable" default


`char` can be signed or unsigned, and is distinct from `signed char` and `unsigned char`
`char` defaults to signed, like other integer types


Signed integers can be represented using one's complement or sign-magnitude implementations.
Signed integers use two's complement. (GCC only supports two's complement)

Signed integer overflow is undefined.
Signed integer overflow wraps around, like for unsigned integers and or GCC with `-fwrapv`. 

`char` is at least 8 bits, `short` and `int` are at least 16 bits, `long` is at least 32 bits, `long long` is at least 64 bits. Signed numbers hold at least [-(2^(n-1)-1), 2^(n-1)-1] range
`char` is exactly 8 bit, `int` is exactly 32 bit, `long long int` is exactly 64 bit, and use full (two's complement) range of -2^(n-1) to 2^(n-1)-1. Thank goodness for C99 fixed-width integer types like `uint8_t`!

`float` and `double` use some kind of floating-point type.
`float` and `double` use IEEE 754 binary32 and binary64. But pretty much all platforms do support all or most of IEEE 754.

`&&` has higher precendence than `||`, and `&` has higher precendence than `^` which has higher precedence than `|`
`&&` and `||` have equal precedence, along with `&`, `^`, and `|` (interestingly, `!=` is the logical version of `^`)

Bitwise operators `&`, `^`, and `|` have lower precedence than `==` and `!=`. (K&R C notes we must paranthesize expressions like `(x & MASK) == 0`.)
Bitwise operators have higher precedence than relational operators.

Bitfield layout is implementation defined and bitfield `int` is implementation-defined as either signed or unsigned.
Bitfields have a fixed layout and bitfield `int` is signed.


Bonus niceties: 

Division truncates towards zero and modulo is defined by `(a/b)*b + a%b == a`. In C90, direction of truncation for `/` and sign of result of `%` are machine-dependent for negative operands. This is what always GCC does. Reasonable is
division floors ([like in python - rationale](http://python-history.blogspot.com/2010/08/why-pythons-integer-division-floors.html)).





