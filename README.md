# WagnerFischer

[![Version](https://img.shields.io/github/release/calebd/WagnerFischer.svg)](https://github.com/calebd/WagnerFischer/releases)
![Swift Version](https://img.shields.io/badge/swift-3.0.1-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

An implementation of [Wagner-Fischer](https://en.wikipedia.org/wiki/Wagner–Fischer_algorithm) in pure Swift. Insipired by [Dave Delong](http://davedelong.tumblr.com/post/134367865668/edit-distance-and-edit-steps).


## Usage

“Edit steps” defines the smallest set of steps needed to go from one array of elements to another. These steps can be used to drive animated transitions between sets of data.

`editSteps("Caleb Davenport", "Sam Soffes")` will return the following:

- substitute(0, S)
- delete(2)
- delete(3)
- substitute(2, m)
- delete(6)
- delete(7)
- delete(8)
- substitute(4, S)
- substitute(5, o)
- substitute(6, f)
- substitute(7, f)
- substitute(8, e)
- substitute(9, s)

“Edit distance” defines the smallest number of steps needed to go from one collection of elements to another.

`editDistance("Caleb Davenport", "Sam Soffes")` will return `13`.

These examples use strings but `WagnerFischer` defines functions that can take any `[T]`.
