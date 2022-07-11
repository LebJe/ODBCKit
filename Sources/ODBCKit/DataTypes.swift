// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

/// A representation of the time data type in a SQL database.
public struct ODBCTime: Equatable, Codable, CustomDebugStringConvertible {
	/// Hours since midnight [0-23].
	///
	/// This documentation comment is from [nanodbc's documentation on `time.hour`](https://nanodbc.github.io/nanodbc/api.html#_CPPv4N7nanodbc4time4hourE).
	public var hour: Int

	public var minute: Int
	public var second: Int

	public var debugDescription: String {
		"\(self.hour):\(self.minute):\(self.second)"
	}

	public init(hour: Int, minute: Int, second: Int) {
		self.hour = hour
		self.minute = minute
		self.second = second
	}

	init(cTime: CTime) {
		self.hour = Int(cTime.hour)
		self.minute = Int(cTime.minute)
		self.second = Int(cTime.second)
	}

	var cTime: CTime {
		CTime(hour: Int16(self.hour), minute: Int16(self.minute), second: Int16(self.second))
	}
}

/// A representation of the date data type in a SQL database.
public struct ODBCDate: Equatable, Codable, CustomDebugStringConvertible {
	public var day: Int
	public var month: Int
	public var year: Int

	public var debugDescription: String {
		"\(self.month) \(self.day), \(self.year)"
	}

	public init(day: Int, month: Int, year: Int) {
		self.day = day
		self.month = month
		self.year = year
	}

	init(cDate: CDate) {
		self.year = Int(cDate.year)
		self.month = Int(cDate.month)
		self.day = Int(cDate.day)
	}

	var cDate: CDate {
		CDate(month: Int16(self.year), day: Int16(self.month), year: Int16(self.day))
	}
}

/// A representation of the timestamp data type in a SQL database.
public struct ODBCTimeStamp: Equatable, Codable {
	public var date: ODBCDate

	/// Hours since midnight [0-23].
	///
	/// This documentation comment is from [nanodbc's documentation on `time.hour`](https://nanodbc.github.io/nanodbc/api.html#_CPPv4N7nanodbc4time4hourE).
	public var hour: Int

	public var minute: Int
	public var second: Int
	public var fractionalSecond: Int

	public var debugDescription: String {
		"\(self.date.debugDescription), \(self.hour):\(self.minute):\(self.second):\(self.fractionalSecond)"
	}

	public init(date: ODBCDate, hour: Int, minute: Int, second: Int, fractionalSecond: Int) {
		self.date = date
		self.hour = hour
		self.minute = minute
		self.second = second
		self.fractionalSecond = fractionalSecond
	}

	init(cTimeStamp: CTimeStamp) {
		self.date = ODBCDate(cDate: cTimeStamp.date)
		self.hour = Int(cTimeStamp.hour)
		self.minute = Int(cTimeStamp.minute)
		self.second = Int(cTimeStamp.second)
		self.fractionalSecond = Int(cTimeStamp.fractionalSec)
	}

	var cTimestamp: CTimeStamp {
		CTimeStamp(
			date: self.date.cDate,
			hour: Int16(self.hour),
			minute: Int16(self.minute),
			second: Int16(self.second),
			fractionalSec: Int32(self.fractionalSecond)
		)
	}
}

/// SQL Data Types.
///
/// The documentation comments on each `case` are from [Microsoft's documentation on DSL Data Types](https://docs.microsoft.com/en-us/sql/odbc/reference/appendixes/sql-data-types?view=sql-server-ver15).
public enum ODBCDataType: Int32 {
	/// Character string of fixed length *n*.
	///
	/// Typical SQL Type: CHAR(*n*)
	case char = 1

	/// Signed, exact, numeric value with a precision *p* and scale *s*s (1 <= *p* <= 15; *s* <= *p*).
	///
	/// Typical SQL Type: NUMERIC(*p*, *s*)
	case numeric = 2

	/// Signed, exact, numeric value with a precision of at least *p* and scale s**. (The maximum precision is driver-defined.) (1 <= p <= 15; s <= p).
	///
	/// - Note: ``ODBCDataType/decimal`` (`SQL_DECIMAL`) and ``ODBCDataType/numeric`` (`SQL_NUMERIC`) data types differ only in their precision. The precision of a DECIMAL(*p*,*s*) is an implementation-defined decimal precision that is no less than *p*, whereas the precision of a NUMERIC(*p*,*s*) is exactly equal to *p*.
	case decimal = 3

	/// Exact numeric value with precision 10 and scale 0 (signed: -2[31] <= n** <= 2[31] - 1, unsigned: 0 <= *n* <= 2[32] - 1)
	case integer = 4

	/// Exact numeric value with precision 5 and scale 0 (signed: -32,768 <= *n* <= 32,767, unsigned: 0 <= *n* <= 65,535).
	case smallInt = 5

	/// Signed, approximate, numeric value with a binary precision of at least p. (The maximum precision is driver-defined.)
	///
	/// Depending on the implementation, the precision of ``ODBCDataType/float`` (`SQL_FLOAT`) can be either 24 or 53: if it is 24, the `SQL_FLOAT` data type is the same as ``ODBCDataType/real`` (`SQL_REAL`); if it is 53, the `SQL_FLOAT` data type is the same as ``ODBCDataType/double`` (`SQL_DOUBLE`).
	case float = 6

	/// Signed, approximate, numeric value with a binary precision 24 (zero or absolute value 10[-38] to 10[38]).
	case real = 7

	/// Signed, approximate, numeric value with a binary precision 53 (zero or absolute value 10[-308] to 10[308]).
	case double = 8

	/// Year, month, and day fields, conforming to the rules of the Gregorian calendar. (See [Constraints of the Gregorian Calendar](https://docs.microsoft.com/en-us/sql/odbc/reference/appendixes/constraints-of-the-gregorian-calendar?view=sql-server-ver15))
	///
	/// Typical SQL Type: DATE
	case date = 9

	///
	case time = 10

	///
	case timeStamp = 11

	/// Variable-length character string with a maximum string length *n*.
	case varChar = 12

	/// Variable length character data. Maximum length is data source-dependent.
	case longVarChar = -1

	/// Binary data of fixed length *n*.
	case binary = -2

	/// Variable length binary data of maximum length *n*. The maximum is set by the user.
	case varBinary = -3

	/// Variable length binary data. Maximum length is data source-dependent.
	case longVarBinary = -4

	/// Exact numeric value with precision 19 (if signed) or 20 (if unsigned) and scale 0 (signed: -2[63] <= n <= 2[63] - 1, unsigned: 0 <= n <= 2[64] - 1).
	case bigInt = -5

	/// Exact numeric value with precision 3 and scale 0 (signed: -128 <= n <= 127, unsigned: 0 <= n <= 255).
	case tinyInt = -6

	/// Single bit binary data.
	case bit = -7

	///
	case guid = -11
}
