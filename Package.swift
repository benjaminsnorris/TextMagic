/*
 |  _   ____   ____   _
 | ⎛ |‾|  ⚈ |-| ⚈  |‾| ⎞
 | ⎝ |  ‾‾‾‾| |‾‾‾‾  | ⎠
 |  ‾        ‾        ‾
 */

import PackageDescription

let package = Package(
    name: "TextMagic",
    dependencies: [
        .Package(url: "https://github.com/soffes/diff", majorVersion: 0, minor: 1)
    ]
)
