// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

/// A type that contains one of two values: `left` or `right`.
public enum ODBCEither<Left, Right> {
	case left(Left), right(Right)
}
