// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public struct Time {
	public let hour: Int
	public let minute: Int
	public let second: Int

	init(cTime: CTime) {
		self.hour = Int(cTime.hour)
		self.minute = Int(cTime.minute)
		self.second = Int(cTime.second)
	}

	var cTime: CTime {
		CTime(hour: Int16(self.hour), minute: Int16(self.minute), second: Int16(self.second))
	}
}

public struct Date {
	public let day: Int
	public let month: Int
	public let year: Int

	init(cDate: CDate) {
		self.year = Int(cDate.year)
		self.month = Int(cDate.month)
		self.day = Int(cDate.day)
	}

	var cDate: CDate {
		CDate(year: Int16(self.year), month: Int16(self.month), day: Int16(self.day))
	}
}

public struct TimeStamp {
	public let date: Date
	public let hour: Int
	public let minute: Int
	public let second: Int
	public let fractionalSecond: Int

	init(cTimeStamp: CTimeStamp) {
		self.date = Date(cDate: cTimeStamp.date)
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
