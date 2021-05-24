// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

/// A type that contains one of two values: `left` or `right`.
enum Either<Left, Right> {
	case left(Left), right(Right)
}
