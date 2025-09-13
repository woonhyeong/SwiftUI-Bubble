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
    var innerPadding: EdgeInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
    var border: BubbleBorder = BubbleBorder()
    
    func arrowAlignment(_ alignment: BubbleArrowAlignment) -> BubbleConfiguration {
        var config = self
        config.arrowAlignment = alignment
        return config
    }
    
    func arrowHeight(_ height: CGFloat) -> BubbleConfiguration {
        var config = self
        config.arrowHeight = height
        return config
    }
    
    func innerPadding(_ insets: EdgeInsets) -> BubbleConfiguration {
        var config = self
        config.innerPadding = insets
        return config
    }
    
    func border(_ border: BubbleBorder) -> BubbleConfiguration {
        var config = self
        config.border = border
        return config
    }
}
