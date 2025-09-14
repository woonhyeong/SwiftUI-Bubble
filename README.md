# SwiftUI Bubble

<img src="https://img.shields.io/badge/release-1.0.0-blue"/> <img src="https://img.shields.io/badge/license-MIT-aeeb34"/>

This package provides you with an easy way to show tooltips over any SwiftUI view, since Apple does not provide one.

```swift
import SwiftUIBubble
...
Text("Bubble Text")
    .bubble()
...
```

## Configuration Reference

Below you can see all the properties that you can set in the configuration.

| Property               | Type          | Description                                          |
| ---------------------- | ------------- | ---------------------------------------------------- |
| `arrowAlignment`                 | `BubbleArrowAlignment` | Side of view that the tooltip should appear on top or bottom      |
| `arrowHeight`               | `CGFloat`     | Bubble arrow's height |
| `innerPadding`         | `EdgeInsets`     | Padding from the bubble to the view it's attached to                               |
| `border`          | `BubbleBorder`     | Thickness, Border, CornerRadius of the border                              |
