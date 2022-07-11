// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

/// An ODBC data source.
public struct DataSource {
	/// The name of the data source.
	public let name: String

	/// The driver associated with the data source.
	public let driver: String

	init(name: String, driver: String) {
		self.name = name
		self.driver = driver
	}

	init(cDataSource: CDataSource) {
		self = DataSource(name: String(cString: cDataSource.name), driver: String(cString: cDataSource.driver))
	}

	/// Retrieve a list of all datasources.
	public static func all() -> [DataSource] {
		var size: UInt = 0

		guard let dataSources = listDataSources(&size) else { return [] }

		return UnsafeBufferPointer(start: dataSources, count: Int(size))
			.map(DataSource.init(cDataSource:))
	}
}
