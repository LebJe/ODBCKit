// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

/// A representation of the time data type in a SQL database.
public struct ODBCTime: Equatable, Codable {
	public let hour: Int
	public let minute: Int
	public let second: Int

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
public struct ODBCDate: Equatable, Codable {
	public let day: Int
	public let month: Int
	public let year: Int

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
	public let date: ODBCDate
	public let hour: Int
	public let minute: Int
	public let second: Int
	public let fractionalSecond: Int

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
