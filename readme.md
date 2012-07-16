Ant Sort
========

Intro
-----
Back in college there was a homework assignment that I never did get working correctly
This is an attempt to get it right.
I don't remember the specifics of the algorithm.  But the gist of it is this.

What this does
--------------
Sorts a 2 dimensional data-set across 3 dimensions of attributes to sort on (a color).

How it does it
--------------
It uses digital ants that crawl over the grid carrying 1 color per ant.
When an ant moves to a new location, it considers whether or not the color
that it's currently carrying would be a better fit for the current location
than the color that is currently there.
If swapping colors would be a better fit, it will do the swap and begin
carrying the color that used to be on the grid but was poorly positioned.

How well does it currently work?
--------------------------------
Not great.  Though it does better than it did at school if I remember correctly.
