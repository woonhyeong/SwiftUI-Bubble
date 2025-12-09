//
//  BubbleShape.swift
//  SwiftUIBubble
//
//  Created by Johnny on 6/29/25.
//

import SwiftUI

struct BubbleShape: Shape {
    
    // MARK: - Constants
    
    private enum ArrowGeometry {
        static let widthRatio: CGFloat = 2.8
        static let peakXRatio: CGFloat = 0.149
        static let peakYRatio: CGFloat = 0.0864
        static let curveXRatio: CGFloat = 0.600
        static let curveYRatio: CGFloat = 0.750
        static let controlXRatio: CGFloat = 0.750
        static let apexYRatio: CGFloat = -0.10
    }
    
    private enum CornerArc {
        static let topTrailing = (start: Angle.radians(-.pi * 0.5), end: Angle.radians(.pi * 0.0))
        static let bottomTrailing = (start: Angle.radians(.pi * 0.0), end: Angle.radians(.pi * 0.5))
        static let bottomLeading = (start: Angle.radians(.pi * 0.5), end: Angle.radians(.pi * 1.0))
        static let topLeading = (start: Angle.radians(.pi * 1.0), end: Angle.radians(-.pi * 0.5))
    }
    
    private static let offsetThreshold: CGFloat = 6
    
    // MARK: - Properties
    
    private let arrowHeight: CGFloat
    private var arrowWidth: CGFloat {
        arrowHeight * ArrowGeometry.widthRatio
    }
    
    private let arrowAlignment: BubbleArrowAlignment
    private let arrowOffset: CGPoint
    private let innerPadding: EdgeInsets
    private let borderRadius: CGFloat
    private let borderWidth: CGFloat
    
    // MARK: - Initialization
    
    init(
        arrowAlignment: BubbleArrowAlignment,
        arrowHeight: CGFloat,
        arrowOffset: CGPoint,
        innerPadding: EdgeInsets,
        borderRadius: CGFloat,
        borderWidth: CGFloat
    ) {
        self.arrowAlignment = arrowAlignment
        self.arrowHeight = arrowHeight
        self.arrowOffset = arrowOffset
        self.innerPadding = innerPadding
        self.borderRadius = borderRadius
        self.borderWidth = borderWidth
    }
    
    // MARK: - Safe Bounds
    
    private struct SafeBounds {
        let minX: CGFloat
        let maxX: CGFloat
        let minY: CGFloat
        let maxY: CGFloat
        
        func clamp(_ point: CGPoint) -> CGPoint {
            CGPoint(
                x: min(max(point.x, minX), maxX),
                y: min(max(point.y, minY), maxY)
            )
        }
    }
    
    private func safeBounds(for rect: CGRect) -> SafeBounds {
        let horizontalSafeZone = (rect.width / 2) - (arrowWidth / 2) - borderWidth - Self.offsetThreshold
        let verticalSafeZone = (rect.height / 2) - (arrowWidth / 2) - borderWidth - Self.offsetThreshold
        
        return SafeBounds(
            minX: -horizontalSafeZone,
            maxX: horizontalSafeZone,
            minY: -verticalSafeZone,
            maxY: verticalSafeZone
        )
    }
    
    // MARK: - Path Rendering
    
    func path(in rect: CGRect) -> Path {
        let offset = safeBounds(for: rect).clamp(arrowOffset)
        let basePath = createBubblePath(in: rect, offset: offset)
        return applyAlignment(to: basePath, in: rect)
    }
    
    private func createBubblePath(in rect: CGRect, offset: CGPoint) -> Path {
        var path = Path()
        
        // Cached values
        let halfBorderWidth = borderWidth / 2
        let halfArrowWidth = arrowWidth / 2
        let arrowBaseY = arrowHeight + borderWidth
        let midX = rect.width / 2 + offset.x
        let startX = midX + halfArrowWidth
        
        // Start point
        path.move(to: CGPoint(x: startX, y: arrowBaseY))
        
        // Draw rounded corners
        addCornerArcs(to: &path, in: rect, halfBorderWidth: halfBorderWidth)
        
        // Draw arrow
        addArrow(to: &path, midX: midX, halfArrowWidth: halfArrowWidth, arrowBaseY: arrowBaseY, halfBorderWidth: halfBorderWidth)
        
        return path
    }
    
    private func addCornerArcs(to path: inout Path, in rect: CGRect, halfBorderWidth: CGFloat) {
        let topY = borderRadius + arrowHeight + borderWidth
        let bottomY = rect.height - borderRadius - halfBorderWidth
        let rightX = rect.width - borderRadius - halfBorderWidth
        let leftX = borderRadius + halfBorderWidth
        
        // Top Trailing
        path.addArc(
            center: CGPoint(x: rightX, y: topY),
            radius: borderRadius,
            startAngle: CornerArc.topTrailing.start,
            endAngle: CornerArc.topTrailing.end,
            clockwise: false
        )
        
        // Bottom Trailing
        path.addArc(
            center: CGPoint(x: rightX, y: bottomY),
            radius: borderRadius,
            startAngle: CornerArc.bottomTrailing.start,
            endAngle: CornerArc.bottomTrailing.end,
            clockwise: false
        )
        
        // Bottom Leading
        path.addArc(
            center: CGPoint(x: leftX, y: bottomY),
            radius: borderRadius,
            startAngle: CornerArc.bottomLeading.start,
            endAngle: CornerArc.bottomLeading.end,
            clockwise: false
        )
        
        // Top Leading
        path.addArc(
            center: CGPoint(x: leftX, y: topY),
            radius: borderRadius,
            startAngle: CornerArc.topLeading.start,
            endAngle: CornerArc.topLeading.end,
            clockwise: false
        )
    }
    
    private func addArrow(to path: inout Path, midX: CGFloat, halfArrowWidth: CGFloat, arrowBaseY: CGFloat, halfBorderWidth: CGFloat) {
        // Arrow control points
        let baseX = halfArrowWidth
        let peakX = halfArrowWidth * ArrowGeometry.peakXRatio
        let peakY = arrowHeight * ArrowGeometry.peakYRatio + halfBorderWidth
        let curveX = halfArrowWidth * ArrowGeometry.curveXRatio
        let curveY = arrowBaseY * ArrowGeometry.curveYRatio
        let controlX = halfArrowWidth * ArrowGeometry.controlXRatio
        let apexY = arrowHeight * ArrowGeometry.apexYRatio + halfBorderWidth
        
        // Left base to left curve
        path.addLine(to: CGPoint(x: midX - baseX, y: arrowBaseY))
        path.addQuadCurve(
            to: CGPoint(x: midX - curveX, y: curveY),
            control: CGPoint(x: midX - controlX, y: arrowBaseY)
        )
        
        // Left curve to peak
        path.addLine(to: CGPoint(x: midX - peakX, y: peakY))
        
        // Peak to apex
        path.addQuadCurve(
            to: CGPoint(x: midX + peakX, y: peakY),
            control: CGPoint(x: midX, y: apexY)
        )
        
        // Apex to right curve
        path.addLine(to: CGPoint(x: midX + curveX, y: curveY))
        
        // Right curve to right base
        path.addQuadCurve(
            to: CGPoint(x: midX + baseX, y: arrowBaseY),
            control: CGPoint(x: midX + controlX, y: arrowBaseY)
        )
    }
    
    private func applyAlignment(to path: Path, in rect: CGRect) -> Path {
        guard arrowAlignment == .bottom else { return path }
        
        let transform = CGAffineTransform(scaleX: 1, y: -1)
            .translatedBy(x: 0, y: -rect.height)
        
        return path.applying(transform)
    }
}
