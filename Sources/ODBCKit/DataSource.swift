// Copyright (c) 2021 Jeff Lebrun
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

	static func fromCDataSource(_ dataSource: CDataSource) -> DataSource {
		DataSource(name: String(cString: dataSource.name), driver: String(cString: dataSource.driver))
	}

	public static func all() -> [DataSource] {
		let a: [Any] = [0, ""]

		var size: Int32 = 0
		var dataSourceArray: [DataSource] = []
		let dataSources = listDataSources(&size)

		if dataSources != nil {
			for i in 0..<Int(size) {
				dataSourceArray.append(DataSource.fromCDataSource(dataSources![i]))
			}

			return dataSourceArray
		} else {
			return []
		}
	}
}
