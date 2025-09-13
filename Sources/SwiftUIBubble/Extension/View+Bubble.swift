//
//  View+Bubble.swift
//  SwiftUIBubble
//
//  Created by Johnny on 9/13/25.
//

import SwiftUI

extension View {
    func bubble(configuration: @escaping (BubbleConfiguration) -> BubbleConfiguration = { $0 }) -> some View {
        let configuration = configuration(BubbleConfiguration())
        
        return modifier(BubbleModifier(configuration: configuration))
    }
}
