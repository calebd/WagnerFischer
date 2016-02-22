# WagnerFischer

An implementation of [Wagner-Fischer](https://en.wikipedia.org/wiki/Wagner–Fischer_algorithm) in pure Swift. Insipired by [Dave Delong](http://davedelong.tumblr.com/post/134367865668/edit-distance-and-edit-steps).

## Usage

"Edit steps" defines the smallest set of steps needed to go from one array of elements to another. These steps can be used to drive animated transitions between sets of data.

`editSteps("Caleb Davenport", "Sam Soffes")` will return the following:

- Substitute(0, S)
- Delete(2)
- Delete(3)
- Substitute(2, m)
- Delete(6)
- Delete(7)
- Delete(8)
- Substitute(4, S)
- Substitute(5, o)
- Substitute(6, f)
- Substitute(7, f)
- Substitute(8, e)
- Substitute(9, s)

"Edit distance" defines the smallest number of steps needed to go from one collection of elements to another.

`editSteps("Caleb Davenport", "Sam Soffes")` will return `13`.

These examples use strings but `WagnerFischer` defines functions that can take any `[T]`.
