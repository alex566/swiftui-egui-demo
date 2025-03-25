// swift-tools-version:5.5.0
import PackageDescription
let package = Package(
	name: "SmoothUI",
	products: [
		.library(
			name: "SmoothUI",
			targets: ["SmoothUI"]),
	],
	dependencies: [],
	targets: [
		.binaryTarget(
			name: "RustXcframework",
			path: "RustXcframework.xcframework"
		),
		.target(
			name: "SmoothUI",
			dependencies: ["RustXcframework"])
	]
)
	