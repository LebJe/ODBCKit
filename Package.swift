// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ODBCKit",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ODBCKit",
            targets: ["ODBCKit"]
		),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
		.target(
			name: "CNanODBC",
			path: "Sources/CNanODBC",
			cxxSettings: [
				.define("NANODBC_DISABLE_TESTS", to: "ON"),
				.define("NANODBC_DISABLE_EXAMPLES", to: "ON"),
				.define("NANODBC_THROW_NO_SOURCE_LOCATION", to: "ON", .when(platforms: nil, configuration: .release))
				//.define("NANODBC_ENABLE_UNICODE", to: "ON"),
			],
			linkerSettings: [.linkedLibrary("odbc")]
		),
        .target(
            name: "ODBCKit",
            dependencies: ["CNanODBC"]
		),
        .testTarget(
            name: "ODBCKitTests",
            dependencies: ["ODBCKit"]
		),
    ],
	cLanguageStandard: .c11,
	cxxLanguageStandard: .cxx14
)