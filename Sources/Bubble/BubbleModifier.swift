// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

@available(iOS 15.0, watchOS 6.0, *)
@frozen public struct BubbleModifier: ViewModifier {
    private let configuration: BubbleConfiguration
    
    @State private var contentSize: CGSize = .zero
    
    public init(configuration: BubbleConfiguration) {
        self.configuration = configuration
    }
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content
                .background(sizeMeasurer)
                .padding(.top, innerPadding.top + borderWidth)
            
            BubbleShape(
                arrowAlignment: configuration.arrowAlignment,
                arrowHeight: configuration.arrowHeight,
                innerPadding: innerPadding,
                borderRadius: borderRadius,
                borderWidth: borderWidth
            )
            .stroke(borderColor, lineWidth: borderWidth)
            .frame(
                width: tooltipShapeSize.width,
                height: tooltipShapeSize.height
            )
        }
    }
    
    private var tooltipShapeSize: CGSize {
        let width = contentSize.width + innerPadding.leading + innerPadding.trailing + borderWidth * 2
        let height = contentSize.height + innerPadding.top + innerPadding.bottom + arrowHeight + borderWidth * 3
        return CGSize(width: width, height: height)
    }
    
    private var sizeMeasurer: some View {
        GeometryReader { geometry in
            Color.clear
                .onAppear {
                    contentSize = geometry.size
                }
        }
    }
    
    private var innerPadding: EdgeInsets {
        configuration.innerPadding
    }
    
    private var borderRadius: CGFloat {
        configuration.border.radius
    }
    
    private var borderWidth: CGFloat {
        configuration.border.width
    }
    
    private var borderColor: Color {
        configuration.border.color
    }
    
    private var arrowHeight: CGFloat {
        configuration.arrowHeight
    }

}

// MARK: - Preview

#Preview {
    Text("Bubble")
        .bubble { configuration in
            configuration
                .arrowAlignment(.bottom)
                .arrowHeight(5)
                .border(BubbleBorder(width: 2))
        }
}
