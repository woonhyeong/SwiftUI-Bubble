//
//  BubbleArrowAlignment.swift
//  SwiftUIBubble
//
//  Created by Johnny on 9/14/25.
//

import Foundation

public enum BubbleArrowAlignment: Sendable {
    case top
    case bottom
}

extension BubbleArrowAlignment {
    var horizontal: Bool {
        self == .top || self == .bottom
    }
    
    var vertical: Bool {
        false
    }
}
