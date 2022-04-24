// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "add-country-code",
  products: [
    .executable(
      name: "add-country-code",
      targets: ["add-country-code"]),
  ],
  targets: [
    .executableTarget(
      name: "add-country-code",
      dependencies: []),
  ]
)
