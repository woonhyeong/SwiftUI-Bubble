//
//  BubbleConfiguration.swift
//  HOHOTooltip
//
//  Created by Johnny on 5/1/25.
//

import SwiftUI

public struct BubbleConfiguration {
    var arrowAlignment: BubbleArrowAlignment = .bottom
    var arrowHeight: CGFloat = 5
    var arrowOffset: CGPoint = .zero
    var backgroundColor: Color = .clear
    var border: BubbleBorder = BubbleBorder()
    var innerPadding: EdgeInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    public func arrowAlignment(_ alignment: BubbleArrowAlignment) -> BubbleConfiguration {
        var config = self
        config.arrowAlignment = alignment
        return config
    }
    
    public func arrowHeight(_ height: CGFloat) -> BubbleConfiguration {
        var config = self
        config.arrowHeight = height
        return config
    }
    
    public func arrowOffset(x: CGFloat = 0, y: CGFloat = 0) -> BubbleConfiguration {
        var config = self
        config.arrowOffset = CGPoint(x: x, y: y)
        return config
    }
    
    public func background(_ color: Color) -> BubbleConfiguration {
        var config = self
        config.backgroundColor = color
        return config
    }
    
    public func border(_ border: BubbleBorder) -> BubbleConfiguration {
        var config = self
        config.border = border
        return config
    }
    
    public func innerPadding(_ insets: EdgeInsets) -> BubbleConfiguration {
        var config = self
        config.innerPadding = insets
        return config
    }
}
