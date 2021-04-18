// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

protocol ODBCValueConvertible {
	var odbcvalue: ODBCValue { get }
}

protocol ODBCValue {}

extension ODBCValue {
	var odbcValue: Self {
		self
	}
}

extension Int: ODBCValue {}
extension Int8: ODBCValue {}
extension Int16: ODBCValue {}
extension Int32: ODBCValue {}
extension Int64: ODBCValue {}
extension Float: ODBCValue {}
extension Double: ODBCValue {}
extension String: ODBCValue {}
extension Date: ODBCValue {
	var odbcValue: CDate {
		self.cDate
	}
}
