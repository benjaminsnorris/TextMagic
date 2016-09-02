# TextMagic
[![Build Status](https://img.shields.io/travis/benjaminsnorris/TextMagic.svg)](https://travis-ci.org/benjaminsnorris/TextMagic)
[![codecov](https://img.shields.io/codecov/c/github/benjaminsnorris/TextMagic.svg)](https://codecov.io/gh/benjaminsnorris/TextMagic)
[![Latest release](http://img.shields.io/github/release/benjaminsnorris/TextMagic.svg)](https://github.com/benjaminsnorris/TextMagic/releases)
[![GitHub license](https://img.shields.io/github/license/benjaminsnorris/TextMagic.svg)](/LICENSE)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift_Package_Manager-compatible-brightgreen.svg)](https://swift.org/package-manager)

A simple library to make working with text in iOS easier. Currently, the library offers support for updating text in `UITextView` or `UITextField` without losing cursor position and text selection.

1. [Requirements](#requirements)
2. [Usage](#usage)
  - [Text updating](#text-updating)
3. [Plans](#plans)
4. [Integration](#integration)
  - [Carthage](#carthage)
  - [Swift Package Manager](#swift-package-manager)
  - [Git Submodules](#git-submodules)


## Requirements
- iOS 9.0+
- Xcode 7
- [Diff](https://github.com/soffes/diff)


## Usage
Import the module into any file where you need to update text
```swift
import TextMagic

var textMagicService = TextMagicService()
```

### Updating text
If you need to update text in a `UITextView` or `UITextField` while preserving cursor position and text selection, use `updateText(in:newString:)`. You provide the text input and changed text, and the rest happens magically for you.


## Plans
- [ ] Adding tests for `UITextField`
- [x] Adding code coverage metrics
- [x] Adding automated build


## Integration
### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate TextMagic into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "benjaminsnorris/TextMagic" ~> 1.0
```

Run `carthage update` to build the framework and drag the built `TextMagic.framework` into your Xcode project.

### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `TextMagic` by adding the proper description to your `Package.swift` file:

```swift
import PackageDescription

let package = Package(
    name: "YOUR_PACKAGE_NAME",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/benjaminsnorris/TextMagic.git", majorVersion: 1)
    ]
)
```

Note that the [Swift Package Manager](https://swift.org/package-manager) is still in early design and development. For more information check out its [GitHub Page](https://github.com/apple/swift-package-manager)


### Git Submodules

- If you don't already have a `.xcworkspace` for your project, create one. ([Here's how](https://developer.apple.com/library/ios/recipes/xcode_help-structure_navigator/articles/Adding_an_Existing_Project_to_a_Workspace.html))

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

```bash
$ git init
```

- Add TextMagic as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

```bash
$ git submodule add https://github.com/benjaminsnorris/TextMagic.git Vendor/TextMagic
```

- Open the new `TextMagic` folder, and drag the `TextMagic.xcodeproj` into the Project Navigator of your application's Xcode workspace.

    > It should not be nested underneath your application's blue project icon. Whether it is above or below your application's project does not matter.

- Select `TextMagic.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Linked Frameworks and Libraries" section.
- Select `TextMagic.framework` inside the `Workspace` folder.
- Click on the `+` button under the "Embedded Binaries" section.
- Select `TextMagic.framework` nested inside your project.
- An extra copy of `TextMagic.framework` will show up in "Linked Frameworks and Libraries". Delete one of them (it doesn't matter which one).
- And that's it!
