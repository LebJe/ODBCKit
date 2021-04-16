// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text license can be found in the file named LICENSE.

import CNanODBC

/// Attributes describe `Driver`s.
public struct Attribute {
	/// The name of the attribute.
	public let keyword: String

	/// The value of the attribute.
	public let value: String

	static func fromCAttribute(_ attr: CAttribute) -> Attribute {
		Attribute(keyword: String(cString: attr.keyword), value: String(cString: attr.value))
	}
}

///
public struct Driver {
	/// The name of the `Driver`.
	public let name: String

	/// The `Attribute`s describing the `Driver`.
	public let attributes: [Attribute]

	static func fromCDriver(_ driver: CDriver) -> Driver {
		var attrArray: [Attribute] = []

		if driver.attributes != nil {
			for i in 0..<Int(driver.attrSize.pointee) {
				attrArray.append(Attribute.fromCAttribute(driver.attributes![i]))
			}
		}

		return Driver(name: String(cString: driver.name), attributes: attrArray)
	}

	/// Retrieve a list of all the installed `Driver`s.
	public static func all() -> [Driver] {
		var size: Int32 = 0
		var driverArray: [Driver] = []
		let drivers = listDrivers(&size)

		if drivers != nil {
			for i in 0..<Int(size) {
				driverArray.append(Driver.fromCDriver(drivers![i]))
			}

			return driverArray
		} else {
			return []
		}
	}
}
