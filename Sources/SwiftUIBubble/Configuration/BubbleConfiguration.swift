//
//  BubbleConfiguration.swift
//  HOHOTooltip
//
//  Created by Johnny on 5/1/25.
//

import SwiftUI

/// A configuration object that defines the appearance and behavior of a bubble view.
///
/// Use `BubbleConfiguration` to customize the visual properties of bubble-style tooltips or popovers,
/// including arrow placement, padding, borders, and offsets.
public struct BubbleConfiguration {
    /// The alignment position of the bubble's arrow.
    ///
    /// Determines whether the arrow appears at the top or bottom of the bubble.
    /// Default value is `.bottom`.
    var arrowAlignment: BubbleArrowAlignment = .bottom
    
    /// The height of the bubble's arrow.
    ///
    /// Specifies the vertical distance from the bubble's edge to the arrow tip.
    /// Default value is `5`.
    var arrowHeight: CGFloat = 5
    
    /// The horizontal and vertical offset of the arrow from its default center position.
    ///
    /// Moves the arrow's position along the bubble's edge while maintaining the bubble's overall shape integrity.
    /// The arrow can be offset horizontally when aligned to the top or bottom edge.
    ///
    /// The offset is automatically clamped to prevent the arrow from extending beyond the bubble's boundaries.
    /// A minimum margin of 6 points (accounting for the arrow width and border radius) is preserved on each side
    /// to ensure the arrow stays within the rounded corners and maintains visual consistency.
    ///
    /// - Note: Positive x values move the arrow to the right, negative values move it to the left.
    ///         The y offset is reserved for future support of leading/trailing arrow alignments.
    /// Default value is `CGPoint(x: 0, y: 0)`.
    var arrowOffset: CGPoint = .zero
    
    /// The background color of the bubble.
    ///
    /// Sets the fill color for the bubble's interior.
    /// Default value is `.clear`.
    var backgroundColor: Color = .clear
    
    /// The border configuration of the bubble.
    ///
    /// Defines the border's width, color, and corner radius.
    /// Default value is an empty `BubbleBorder(radius: CGFloat = 5, width: CGFloat = 2, color: Color = .black)`.
    var border: BubbleBorder = BubbleBorder()
    
    /// The internal padding between the bubble's edges and its content.
    ///
    /// Controls the spacing around the content within the bubble.
    /// Default value is `EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)`.
    var innerPadding: EdgeInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
    
    /// Sets the alignment position of the bubble's arrow.
    ///
    /// - Parameter alignment: The desired arrow alignment (`.top` or `.bottom`).
    /// - Returns: A modified configuration with the updated arrow alignment.
    public func arrowAlignment(_ alignment: BubbleArrowAlignment) -> BubbleConfiguration {
        var config = self
        config.arrowAlignment = alignment
        return config
    }
    
    /// Sets the height of the bubble's arrow.
    ///
    /// - Parameter height: The arrow height in points.
    /// - Returns: A modified configuration with the updated arrow height.
    public func arrowHeight(_ height: CGFloat) -> BubbleConfiguration {
        var config = self
        config.arrowHeight = height
        return config
    }
    
    /// Sets the horizontal and vertical offset of the arrow from its default center position.
    ///
    /// This method allows you to reposition the arrow along the bubble's edge while automatically
    /// maintaining safe boundaries. The arrow offset is clamped to ensure a minimum 6-point margin
    /// from the bubble's corners, preserving the visual integrity of the rounded edges.
    ///
    /// - Parameters:
    ///   - x: The horizontal offset in points. Positive values move the arrow right, negative values move it left.
    ///        Default is `0`.
    ///   - y: The vertical offset in points (reserved for future leading/trailing alignments).
    ///        Default is `0`.
    ///
    /// - Returns: A modified configuration with the updated arrow offset.
    ///
    /// - Note: The actual applied offset may be less than the specified value if it would cause the arrow
    ///         to extend beyond the safe boundaries of the bubble.
    ///
    /// Example:
    /// ```swift
    /// BubbleConfiguration()
    ///     .arrowOffset(x: 30)  // Arrow shifts 30 points to the right
    ///     .arrowOffset(x: -15) // Arrow shifts 15 points to the left
    /// ```
    public func arrowOffset(x: CGFloat = 0, y: CGFloat = 0) -> BubbleConfiguration {
        var config = self
        config.arrowOffset = CGPoint(x: x, y: y)
        return config
    }
    
    /// Sets the background color of the bubble.
    ///
    /// - Parameter color: The desired background color.
    /// - Returns: A modified configuration with the updated background color.
    public func background(_ color: Color) -> BubbleConfiguration {
        var config = self
        config.backgroundColor = color
        return config
    }
    
    /// Sets the border configuration of the bubble.
    ///
    /// - Parameter border: A `BubbleBorder` object defining width, color, and radius.
    /// - Returns: A modified configuration with the updated border.
    public func border(_ border: BubbleBorder) -> BubbleConfiguration {
        var config = self
        config.border = border
        return config
    }
    
    /// Sets the internal padding between the bubble's edges and its content.
    ///
    /// - Parameter insets: An `EdgeInsets` value defining the padding on all sides.
    /// - Returns: A modified configuration with the updated inner padding.
    public func innerPadding(_ insets: EdgeInsets) -> BubbleConfiguration {
        var config = self
        config.innerPadding = insets
        return config
    }
}
