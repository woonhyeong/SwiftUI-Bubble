//
//  BubbleBorder.swift
//  SwiftUIBubble
//
//  Created by Johnny on 9/14/25.
//

import SwiftUI

public struct BubbleBorder {
    let radius: CGFloat
    let width: CGFloat
    let color: Color
    
    public init(radius: CGFloat = 5, width: CGFloat = 2, color: Color = .black) {
        self.radius = radius
        self.width = width
        self.color = color
    }
}
