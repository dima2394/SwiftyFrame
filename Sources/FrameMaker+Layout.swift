//
//  File.swift
//  
//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

public struct SafeArea {}
public var safeArea: SafeArea {
    return SafeArea()
}

// MARK: -  Layout Configuration Methods

public extension FrameMaker {
    
    // MARK: -  Edges Relation Configuration
    
    /// For edges relation inside `superview`.
    /// - Parameter insets: margin from each side.
    /// - Returns: FrameMaker instance for chainable syntax.
    @discardableResult
    func edges(_ insets: UIEdgeInsets) -> FrameMaker {
        guard let superView = view.superview,
              #available(tvOS 11.0, iOS 9.0, *)
        else {
            fatalError("❌ need to configure superview")
        }
        
        horizontalRelation.xRect = superView.frame.minX + superView.safeAreaInsets.left + insets.left
        verticalRelation.yRect = superView.frame.minY + superView.safeAreaInsets.top + insets.top
        verticalRelation.heightRect = superView.frame.maxY - superView.frame.minY - (superView.safeAreaInsets.top + superView.safeAreaInsets.bottom) - (insets.bottom + insets.top)
        horizontalRelation.widthRect = superView.frame.maxX - superView.frame.minX - (insets.right + insets.left)
        return self
    }
    
    /// For edges relation inside `view`.
    /// - Parameters:
    ///   - view: superview.
    ///   - insets: margin from each side.
    /// - Returns: FrameMaker instance for chainable syntax.
    @discardableResult
    func edges(into view: UIView, insets: UIEdgeInsets) -> FrameMaker {
        guard self.view.superview != nil,
              #available(tvOS 11.0, iOS 9.0, *)
        else {
            fatalError("❌ need to configure superview")
        }
        horizontalRelation.xRect = view.frame.minX + view.safeAreaInsets.left + insets.left
        verticalRelation.yRect = view.frame.minY + view.safeAreaInsets.top + insets.top
        horizontalRelation.widthRect = view.frame.maxX - view.frame.minX - (insets.right + insets.left)
        verticalRelation.heightRect = view.frame.maxY - view.frame.minY - (view.safeAreaInsets.top + view.safeAreaInsets.bottom) - (insets.bottom + insets.top)
        return self
    }
    
    /// Configure Left And Right margins for view.
    /// - Parameter margin: indent from each side. Default is `0`.
    /// - Returns: FrameMaker instance for chainable syntax.
    @discardableResult
    func leftAndRight(margin: CGFloat = 0) -> FrameMaker {
        left(inset: margin).right(inset: margin)
    }

    /// Left And Right  margins configuration for view.
    /// - Parameter margin: indent from each side. Default is `0`.
    /// - Returns: FrameMaker instance for chainable syntax.
    @discardableResult
    func horizontal(margin: CGFloat = 0) -> FrameMaker {
        left(inset: margin).right(inset: margin)
    }
    
    /// Vertical relation configuration for view: `Top` and `Bottom`
    /// - Parameter margin: indent from each side. Default is `0`.
    /// - Returns: FrameMaker instance for chainable syntax.
    @discardableResult
    func topAndBottom(margin: CGFloat = 0) -> FrameMaker {
        top(inset: margin).bottom(inset: margin)
    }
    
    /// Vertical relation configuration for view: `Top` and `Bottom`
    /// - Parameter margin: indent from each side. Default is `0`.
    /// - Returns: FrameMaker instance for chainable syntax.
    @discardableResult
    func vertical(margin: CGFloat = 0) -> FrameMaker {
        top(inset: margin).bottom(inset: margin)
    }
    
    /// "ThreeSide" relation configuration for view: `Left`,  `Top`, `Right`.
    /// - Parameter margin: indent from each side. Default is `0`.
    /// - Returns: FrameMaker instance for chainable syntax.
    @discardableResult
    func leftTopRight(margin: CGFloat = 0) -> FrameMaker {
        leftAndRight(margin: margin).top(inset: margin)
    }
    
    /// "ThreeSide" relation configuration for view: `Left`,  `Bottom`, `Right`.
    /// - Parameter margin: indent from each side.
    /// - Returns: FrameMaker instance for chainable syntax.
    @discardableResult
    func leftBottomRight(margin: CGFloat = 0) -> FrameMaker {
        bottom(inset: margin).leftAndRight(margin: margin)
    }
    
    // MARK: -  Top Relation Configuration
    
    @discardableResult
    func top(inset: CGFloat = 0) -> FrameMaker {
        guard let superview = view.superview else {
            fatalError("❌ need to configure superview")
        }
        if verticalRelation.hasY {
            verticalRelation.heightRect = verticalRelation.yRect - superview.frame.minY - inset
            
        }
        verticalRelation.yRect = superview.frame.origin.y + inset
        return self
    }

    @discardableResult
    func top(to safeArea: SafeArea, inset: CGFloat = 0) -> FrameMaker {
        guard let superview = view.superview else {
            fatalError("❌ need to configure superview")
        }
        if verticalRelation.hasY {
            verticalRelation.heightRect = verticalRelation.yRect - superview.frame.minY - inset - safeAreaInset.bottom
            verticalRelation.yRect = safeAreaInset.top + inset + superview.frame.minY
        } else {
            verticalRelation.yRect = safeAreaInset.top + inset
        }
        return self
    }
    
    @discardableResult
    func top(to relationView: RelationView<VerticalRelationType>, inset: CGFloat = 0) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        switch relationView.relationType {
        case .top:
            if verticalRelation.hasY {
                verticalRelation.heightRect = verticalRelation.yRect - (relationView.view.frame.minY + inset)
            }
            verticalRelation.yRect = relationView.view.frame.minY + inset
        case .bottom:
            verticalRelation.yRect = relationView.view.frame.maxY + inset
        case .centerY:
            if verticalRelation.hasY {
                verticalRelation.heightRect = verticalRelation.yRect - relationView.view.center.y - inset
            } else {
                verticalRelation.yRect = relationView.view.center.y + inset
            }
        }
        return self
    }
    
    // MARK: -  Bottom Relation Configuration
    
    @discardableResult
    func bottom(to relationView: RelationView<VerticalRelationType>, inset: CGFloat = 0) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        switch relationView.relationType {
        case .top:
            verticalRelation.yRect = relationView.view.frame.minY - inset
            realizedVerticalRelations.append(.bottom)
        case .bottom:
            if verticalRelation.hasY {
                verticalRelation.heightRect = (relationView.view.frame.maxY - inset - verticalRelation.yRect)
            } else {
                verticalRelation.yRect = relationView.view.frame.maxY - inset
            }
            realizedVerticalRelations.append(.bottom)
        case .centerY:
            if verticalRelation.hasY {
                verticalRelation.heightRect = (relationView.view.center.y - inset - verticalRelation.yRect)
            } else {
                verticalRelation.yRect = relationView.view.center.y - inset
            }
            realizedVerticalRelations.append(.bottom)
        }
        return self
    }
    
    @discardableResult
    func bottom(inset: CGFloat = 0) -> FrameMaker {
        guard let superview = view.superview else {
            fatalError("❌ need to configure superview")
        }
        if verticalRelation.hasY {
            verticalRelation.heightRect = superview.frame.maxY - inset - verticalRelation.yRect
        } else {
            verticalRelation.yRect = superview.frame.maxY - inset
        }
        return self
    }

    @discardableResult
    func bottom(to safeArea: SafeArea, inset: CGFloat = 0) -> FrameMaker {
        guard let superview = view.superview else {
            fatalError("❌ need to configure superview")
        }
        if verticalRelation.hasY {
            verticalRelation.heightRect = superview.frame.maxY - verticalRelation.yRect - inset - safeAreaInset.bottom
        } else {
            verticalRelation.yRect = superview.frame.maxY - inset - safeAreaInset.bottom
        }
        return self
    }
    
    // MARK: -  Left Relation Configuration
    
    @discardableResult
    func left(inset: CGFloat = 0) -> FrameMaker {
        guard let superview = view.superview else {
            fatalError("❌ need to configure superview")
        }
        if horizontalRelation.hasX {
            horizontalRelation.widthRect = horizontalRelation.xRect - inset
        }
        horizontalRelation.xRect = superview.frame.minX + inset
        return self
    }
    
    @discardableResult
    func left(to relationView: RelationView<HorizontalRelationType>, inset: CGFloat = 0) -> FrameMaker {
        switch relationView.relationType {
        case .left:
            if horizontalRelation.hasX {
                horizontalRelation.widthRect = horizontalRelation.xRect - (relationView.view.frame.minX + inset)
            }
            horizontalRelation.xRect = relationView.view.frame.minX + inset
            realizedHorizontalRelations.append(.left)
        case .right:
            if horizontalRelation.hasX {
                horizontalRelation.widthRect = horizontalRelation.xRect - (relationView.view.frame.maxX + inset)
            }
            horizontalRelation.xRect = relationView.view.frame.maxX + inset
            realizedHorizontalRelations.append(.left)
        case .centerX:
            if horizontalRelation.hasX {
                horizontalRelation.widthRect = horizontalRelation.xRect - (relationView.view.center.x + inset)
            }
            horizontalRelation.xRect = relationView.view.center.x + inset
            realizedHorizontalRelations.append(.left)
        }
        return self
    }
    
    // MARK: -  Right Relation Configuration
    
    @discardableResult
    func right(to relationView: RelationView<HorizontalRelationType>, inset: CGFloat = 0) -> FrameMaker {
        switch relationView.relationType {
        case .left:
            horizontalRelation.xRect = relationView.view.frame.minX + inset
            realizedHorizontalRelations.append(.left)
        case .right:
            if horizontalRelation.hasX {
                horizontalRelation.widthRect = relationView.view.frame.maxX - inset - horizontalRelation.xRect
            } else {
                horizontalRelation.xRect = relationView.view.frame.maxX - inset
            }
            realizedHorizontalRelations.append(.right)
        case .centerX:
            if horizontalRelation.hasX {
                horizontalRelation.widthRect = relationView.view.center.x - inset - horizontalRelation.xRect
            } else {
                horizontalRelation.xRect = relationView.view.center.x - inset
            }
            realizedHorizontalRelations.append(.right)
        }
        return self
    }
    
    @discardableResult
    func right(inset: CGFloat = 0) -> FrameMaker {
        guard let superview = view.superview else {
            fatalError("❌ need to configure superview")
        }
        if horizontalRelation.hasX {
            horizontalRelation.widthRect = superview.frame.maxX - inset - horizontalRelation.xRect
        } else {
            horizontalRelation.xRect = superview.frame.maxX - inset
        }
        realizedHorizontalRelations.append(.right)
        return self
    }
    
    // MARK: -  Center Relations
    // MARK: -  Center
    @discardableResult
    func center(to relationView: UIView) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        let center = relationView.center
        let block = BlockOperation { [unowned view] in
            view.center = center
        }
        defferedOperations.append(block)
        return self
    }
    
    @discardableResult
    func center() -> FrameMaker {
        guard let superview = view.superview else {
            fatalError("❌ need to configure superview")
        }
        let center = superview.center
        let block = BlockOperation { [unowned view] in
            view.center = center
        }
        defferedOperations.append(block)
        return self
    }
    
    // MARK: -  Center X
    @discardableResult
    func centerX(to relationView: RelationView<HorizontalRelationType>, offset: CGFloat = 0) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        let leftRect = relationView.view.frame.minX
        let rightRect = relationView.view.frame.maxX
        let centerX = relationView.view.center.x
        let relationType = relationView.relationType
        let block = BlockOperation { [unowned view] in
            var value: CGFloat
            switch relationType {
            case .left:
                value = leftRect
            case .right:
                value = rightRect
            case .centerX:
                value = centerX
            }
            view.center.x = value - offset
        }
        defferedOperations.append(block)
        return self
    }
    
    @discardableResult
    func centerX(offset: CGFloat = 0) -> FrameMaker {
        guard let superview = view.superview else {
            fatalError("❌ need to configure superview")
        }
        let centerX = superview.center.x
        let block = BlockOperation { [unowned view] in
            view.center.x = centerX - offset
        }
        defferedOperations.append(block)
        return self
    }
    
    // MARK: -  Center Y
    @discardableResult
    func centerY(to relationView: RelationView<VerticalRelationType>, offset: CGFloat = 0) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        let topRect = relationView.view.frame.minY
        let bottomRect = relationView.view.frame.maxY
        let centerY = relationView.view.center.y
        let relationType = relationView.relationType
        let block = BlockOperation { [unowned view] in
            var value: CGFloat
            switch relationType {
            case .top:
                value = topRect
            case .bottom:
                value = bottomRect
            case .centerY:
                value = centerY
            }
            view.center.y = value - offset
        }
        defferedOperations.append(block)
        return self
    }
    
    @discardableResult
    func centerY(offset: CGFloat = 0) -> FrameMaker {
        guard let superview = view.superview else {
            fatalError("❌ need to configure superview")
        }
        let centerY = superview.center.y
        let block = BlockOperation { [unowned view] in
            view.center.y = centerY - offset
        }
        defferedOperations.append(block)
        return self
    }

    // MARK: -  Size configuration
    
    @discardableResult
    func height(_ height: CGFloat) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        guard !verticalRelation.hasHeight else {
            fatalError("❌ already configured height dimension")
        }
        if verticalRelation.hasY && realizedVerticalRelations.contains(.bottom) {
            verticalRelation.yRect = verticalRelation.yRect - height
        }
        verticalRelation.heightRect = height
        return self
    }

    @discardableResult
    func height(equal to: UIView) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        guard !verticalRelation.hasHeight else {
            fatalError("❌ already configured height dimension")
        }
        let heightDimension = to.bounds.height
        if verticalRelation.hasY && realizedVerticalRelations.contains(.bottom) {
            verticalRelation.yRect = verticalRelation.yRect - heightDimension
        }
        verticalRelation.heightRect = heightDimension
        return self
    }

    @discardableResult
    func width(_ width: CGFloat) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        if horizontalRelation.hasX && realizedHorizontalRelations.contains(.right) {
            horizontalRelation.xRect = horizontalRelation.xRect - width
        }
        horizontalRelation.widthRect = width
        return self
    }
    
    @discardableResult
    func width(equal to: UIView) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        let widthDimension = to.bounds.width
        if horizontalRelation.hasX && realizedHorizontalRelations.contains(.right) {
            horizontalRelation.xRect = horizontalRelation.xRect - widthDimension
        }
        horizontalRelation.widthRect = widthDimension
        return self
    }

    @discardableResult
    func size(width: CGFloat, height: CGFloat) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        if verticalRelation.hasY && realizedVerticalRelations.contains(.top) {
            verticalRelation.yRect = verticalRelation.yRect - height
        } else if verticalRelation.hasY && realizedVerticalRelations.contains(.bottom) {
            verticalRelation.yRect = verticalRelation.yRect + height
        }
        horizontalRelation.widthRect = width
        verticalRelation.heightRect = height
        return self
    }

    @discardableResult
    func squareSize(_ value: CGFloat) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }

        if horizontalRelation.hasX && realizedHorizontalRelations.contains(.right) {
            horizontalRelation.xRect = horizontalRelation.xRect - value
        }
        horizontalRelation.widthRect = value
        
        if verticalRelation.hasY && realizedVerticalRelations.contains(.top) {
            verticalRelation.yRect = verticalRelation.yRect + value
        } else if verticalRelation.hasY && realizedVerticalRelations.contains(.bottom) {
            verticalRelation.yRect = verticalRelation.yRect - value
        }
        verticalRelation.heightRect = value
        return self
    }
    
    @discardableResult
    func size(equalTo view: UIView) -> FrameMaker {
        guard self.view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        horizontalRelation.widthRect = view.frame.width
        verticalRelation.heightRect = view.frame.height
        return self
    }

    @discardableResult
    func sizeToFit() -> FrameMaker {
        guard self.view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        let block = BlockOperation { [unowned view] in view.sizeToFit() }
        defferedOperations.append(block)
        return self
    }
    
    @discardableResult
    func widthToFit(max: CGFloat = .greatestFiniteMagnitude) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        let block = BlockOperation { [unowned view] in
            let fittingWidth = view.widthThatFits(.greatestFiniteMagnitude)
            view.frame.size.width = min(max, fittingWidth)
        }
        defferedOperations.append(block)
        return self
    }

    @discardableResult
    func heightToFit(max: CGFloat = .greatestFiniteMagnitude) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        let block = BlockOperation { [unowned view] in
            let fittingHeight = view.heightThatFits(.greatestFiniteMagnitude)
            view.frame.size.height = min(max, fittingHeight)
        }
        defferedOperations.append(block)
        return self
    }
    
    // MARK: -  Layout Helpers
    
    @discardableResult
    func cornerRadius(_ value: CGFloat) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        let block = BlockOperation { [unowned view] in
            view.layer.masksToBounds = true
            view.layer.cornerRadius = value
        }
        defferedOperations.append(block)
        return self
    }
    
    @discardableResult
    func cornerRadius(_ dimensionType: DimensionRelationType, multiplier: CGFloat = 1.0) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        let width = horizontalRelation.widthRect
        let height = verticalRelation.heightRect
        let block = BlockOperation { [unowned view] in
            var value: CGFloat
            switch dimensionType {
            case .width:
                value = width * multiplier
            case .height:
                value = height * multiplier
            }
            view.layer.masksToBounds = true
            view.layer.cornerRadius = value
        }
        defferedOperations.append(block)
        return self
    }
}
