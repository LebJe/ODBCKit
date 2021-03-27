// swift-tools-version:5.3

import PackageDescription
import Foundation

let package = Package(
    name: "ODBCKit",
    dependencies: [],
    targets: [
        .target(
			name: "nanodbcCXX", cxxSettings: [
				.define("NANODBC_DISABLE_TESTS", to: "ON"),
				.define("NANODBC_DISABLE_EXAMPLES", to: "ON"),
				.define("NANODBC_ENABLE_UNICODE", to: "ON"),
				.unsafeFlags(
					[
						"-L", "/Users/lebje/homebrew/lib",
						"-I", "/Users/lebje/homebrew/include/",
						"-I", "/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2021-03-25-a.xctoolchain/usr/include/c++/v1/",
					]
				)
			], linkerSettings: [
				.linkedLibrary("odbc")
			]
		),
        .target(
            name: "ODBCKit",
            dependencies: ["nanodbcCXX"],
			swiftSettings: [
				.unsafeFlags(
					[
						"-target",
						"arm64-apple-macosx10.15",
						"-Xfrontend",
						"-enable-cxx-interop",
						"-Xfrontend", "-validate-tbd-against-ir=none",
						"-L", "/Users/lebje/homebrew/lib",
						"-I", "/Users/lebje/homebrew/include/",
						"-I", "/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2021-03-25-a.xctoolchain/usr/include/c++/v1/",
					]
				)
			]
		),
        .testTarget(
            name: "ODBCKitTests",
            dependencies: ["ODBCKit"]
		),
	],
	cxxLanguageStandard: .cxx14
)


if let headerPath = ProcessInfo.processInfo.environment["CUSTOM_HEADER_PATH"] {
	package.targets[0].cxxSettings?.append(.unsafeFlags(["-I\(headerPath)"]))
}
