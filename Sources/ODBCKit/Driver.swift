// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

/// Attributes describe `Driver`s.
public struct Attribute {
	/// The name of the attribute.
	public let keyword: String

	/// The value of the attribute.
	public let value: String

	init(keyword: String, value: String) {
		self.keyword = keyword
		self.value = value
	}

	init(cAttribute: CAttribute) {
		self = Self(keyword: String(cString: cAttribute.keyword), value: String(cString: cAttribute.value))
	}
}

///
public struct Driver {
	/// The name of the `Driver`.
	public let name: String

	/// The `Attribute`s describing the `Driver`.
	public let attributes: [Attribute]

	init(name: String, attributes: [Attribute]) {
		self.name = name
		self.attributes = attributes
	}

	init(cDriver: CDriver) {
		var attrArray: [Attribute] = []

		if cDriver.attributes != nil {
			for i in 0..<Int(cDriver.attrSize.pointee) {
				attrArray.append(Attribute(cAttribute: cDriver.attributes![i]))
			}
		}

		self = Self(name: String(cString: cDriver.name), attributes: attrArray)
	}

	/// Retrieve a list of all the installed `Driver`s.
	public static func all() -> [Driver] {
		var size: UInt = 0

		guard let drivers = listDrivers(&size) else { return [] }

		return UnsafeBufferPointer(start: drivers, count: Int(size))
			.map(Driver.init(cDriver:))
	}
}
