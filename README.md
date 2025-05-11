# SwiftyFrame

A Swift Package Manager (SPM) library for iOS that provides a fluent, chainable API to configure view frames and layout constraints in UIKit.

## Overview

SwiftyFrame simplifies the process of setting up view frames and layout constraints in iOS applications. It offers a declarative, chainable syntax that makes it easy to define complex layouts with minimal code.

## Features

- **Fluent API**: Chainable methods for configuring view frames and layout constraints.
- **Safe Area Support**: Built-in support for safe area insets.
- **Comprehensive Layout Methods**: Methods for configuring edges, margins, and relations (top, bottom, left, right, centerX, centerY, width, height).
- **Collection Support**: Configure frames for multiple views at once using Swift collections.

## Installation

### Swift Package Manager

Add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/dima2394/SwiftyFrame.git", from: "0.3.6")
]
```

## Usage

### Basic Example

```swift
import SwiftyFrame

let view = UIView()
view.frame { maker in
    maker.edges(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
}
```

### Configuring Relations

```swift
let view = UIView()
view.frame { maker in
    maker.top(inset: 20)
       .left(inset: 20)
       .width(100)
       .height(100)
}
```

### Using Collections

```swift
let views = [view1, view2, view3]
views.frame { maker in
    maker.edges(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
}
```

## Requirements

- iOS 12.0+
- Swift 5.5+

## License

This project is licensed under the MIT License - see the LICENSE file for details.
