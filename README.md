# minimatrix-polyroots
implementation of Kahan's polynomial root finders for polynomials up to degree 4.

## Motivation
According to Kahan, standard cubic root finders based on classical methods are prone to numerial inaccuracies. This is an implementation of a numerically stable method illustrated in Kahan's notes titles "To Solve a Real Cubic Equation".

The notes can be found here:(http://people.eecs.berkeley.edu/~wkahan/Math128/Cubic.pdf)[http://people.eecs.berkeley.edu/~wkahan/Math128/Cubic.pdf].

Kahan's cubic root finder is based on a quadratic root finder. In like fashion, the quartic root finder is base on Kahan's cubic root finder. The linear root finder is easy to calculate and is anded for completeness.

## Usage
The linear equation solved is Ax + B = 0.

The quadratic equation solved is Ax^2 + Bx + C = 0.

The cubic equation solved is Ax^3 + Bx^2 + Cx + D = 0.

The quartic equation solved is Ax^4 + Bx^3 + Cx^2 + Dx + E = 0.

* getLinearRoot(A, B)
* getQuadraticRoots(A, B, C)
* getCubicRoots(A, B, C, D)
* getQuarticRoots(A, B, C, D, E)

The roots returned are in an unsorted array. Since roots can be complex, they are given in a complex form:
```swift
struct Root {
  var real: Double
  var imag: Double
}
```

## Author
Algorithm and pseudocode by William Kakan. Implementation in Swift by George Tz.
