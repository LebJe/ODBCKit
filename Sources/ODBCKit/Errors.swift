// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

public enum ODBCError: Error {
	case general(message: String? = nil)

	/// The type you requested is not the type of the value in the specified column.
	case invalidType

	case indexOutOfRange

	case programmingError(message: String)

	case databaseError(message: String)
}
