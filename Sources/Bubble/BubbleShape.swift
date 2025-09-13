//
//  BubbleShape.swift
//  HOHOTooltip
//
//  Created by Johnny on 6/29/25.
//

import SwiftUI

struct BubbleShape: Shape {
    private let clockwise: Bool = false
    private let arcTopTrailing = (start: Angle.radians(-.pi*0.5), end: Angle.radians(.pi*0.0))
    private let arcBottomTrailing = (start: Angle.radians(.pi*0.0),  end: Angle.radians(.pi*0.5))
    private let arcBottomLeading = (start: Angle.radians(.pi*0.5),  end: Angle.radians(.pi*1.0))
    private let arcTopLeading = (start: Angle.radians(.pi*1.0),  end: Angle.radians(-.pi*0.5))
    
    private let arrowHeight: CGFloat
    private var arrowWidth: CGFloat {
        arrowHeight * 2.8
    }
    
    private let arrowAlignment: BubbleArrowAlignment
    private let innerPadding: EdgeInsets
    private let borderRadius: CGFloat
    private let borderWidth: CGFloat
    
    init(
        arrowAlignment: BubbleArrowAlignment,
        arrowHeight: CGFloat,
        innerPadding: EdgeInsets,
        borderRadius: CGFloat,
        borderWidth: CGFloat
    ) {
        self.arrowAlignment = arrowAlignment
        self.arrowHeight = arrowHeight
        self.innerPadding = innerPadding
        self.borderRadius = borderRadius
        self.borderWidth = borderWidth
    }
    
    // MARK: Rendering
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let fit: ((CGPoint) -> (CGPoint)) = { point in return point }
        
        let rectWidth = rect.width
        let rectHeight = rect.height

        // Arc Top Trailing
        path.move(to: fit(CGPoint(x: rectWidth * 0.5 + arrowWidth * 0.5, y: arrowHeight + borderWidth * 2)) )
        path.addArc(
            center: fit(CGPoint(x: rectWidth - borderRadius - borderWidth, y: borderRadius + arrowHeight + borderWidth * 2)),
            radius: borderRadius,
            startAngle: arcTopTrailing.start,
            endAngle: arcTopTrailing.end,
            clockwise: clockwise
        )
        
        // Arc Bottom Trailing
        path.addArc(
            center: fit(CGPoint(x: rectWidth - borderRadius - borderWidth, y: rectHeight - borderRadius - borderWidth)),
            radius: borderRadius,
            startAngle: arcBottomTrailing.start,
            endAngle: arcBottomTrailing.end,
            clockwise: clockwise
        )
        
        // Arc Bottom Leading
        path.addArc(
            center: fit(CGPoint(x: borderRadius + borderWidth, y: rectHeight - borderRadius - borderWidth)),
            radius: borderRadius,
            startAngle: arcBottomLeading.start,
            endAngle: arcBottomLeading.end,
            clockwise: clockwise
        )
        
        // Arc Top Leading
        path.addArc(
            center: fit(CGPoint(x: borderRadius + borderWidth, y: borderRadius + arrowHeight + borderWidth * 2)),
            radius: borderRadius,
            startAngle: arcTopLeading.start,
            endAngle: arcTopLeading.end,
            clockwise: clockwise
        )
        
        let base = CGPoint(x: arrowWidth * 0.5, y: (arrowHeight + borderWidth * 2))
        let peak = CGPoint(x: arrowWidth * 0.5 * 0.149, y: arrowHeight * 0.0864 + borderWidth)
        let curv = CGPoint(x: arrowWidth * 0.5 * 0.600, y: (arrowHeight + borderWidth * 2) * 0.7500)
        let ctrl = CGPoint(x: arrowWidth * 0.5 * 0.750, y: (arrowHeight + borderWidth * 2))
        let apex = CGPoint(x: arrowWidth * 0.5 * 0.000, y: -(arrowHeight) * 0.1456 + borderWidth)
        
        let midX = rectWidth * 0.5
        
        path.addLine(to: fit(CGPoint(x: midX - base.x, y: base.y)))
        
        // Arrow : left side arc
        path.addQuadCurve(
            to: fit(CGPoint(x: midX - curv.x, y: curv.y)),
            control: fit(CGPoint(x: midX - ctrl.x, y: ctrl.y))
        )
        
        // Arrow : up line from arc
        path.addLine(to: fit(CGPoint(x: midX - peak.x, y: peak.y)))
        
        // Arrow : apex arc
        path.addQuadCurve(
            to: fit(CGPoint(x: midX + peak.x, y: peak.y)),
            control: fit(CGPoint(x: midX, y: apex.y))
        )
        
        // Arrow : down line from apex
        path.addLine(to: fit(CGPoint(x: midX + curv.x, y: curv.y)))

        // Arrow : down arc from line
        path.addQuadCurve(
            to: fit(CGPoint(x: midX + base.x, y: base.y)),
            control: fit(CGPoint(x: midX + ctrl.x, y: ctrl.y))
        )
        
        var transform = CGAffineTransform(scaleX: 1, y: 1)

        if arrowAlignment == .bottom {
            transform = CGAffineTransform(scaleX: 1, y: -1)
            transform = transform.translatedBy(x: 0, y: -rectHeight)
        }
        
        return path.applying(transform)
    }
}
