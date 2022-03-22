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
    
    @discardableResult
    func edges(_ insets: UIEdgeInsets) -> FrameMaker {
        guard let superView = view.superview else {
            fatalError("❌ need to configure superview")
        }
        horizontalRelation.xRect = superView.frame.minX + superView.safeAreaInsets.left + insets.left
        verticalRelation.yRect = superView.frame.minY + superView.safeAreaInsets.top + insets.top
        horizontalRelation.widthRect = superView.frame.maxX - superView.frame.minX - (insets.right + insets.left)
        verticalRelation.heightRect = superView.frame.maxY - superView.frame.minY - (superView.safeAreaInsets.top + superView.safeAreaInsets.bottom) - (insets.bottom + insets.top)
        return self
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
            break
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
            horizontalRelation.xRect = relationView.view.frame.maxX + inset
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
        return self
    }

    // MARK: -  Size configuration
    
    @discardableResult
    func height(_ height: CGFloat) -> FrameMaker {
        guard view.superview != nil else {
            fatalError("❌ need to configure superview")
        }
        if verticalRelation.hasY && realizedVerticalRelations.contains(.bottom) {
            verticalRelation.yRect = verticalRelation.yRect - height
        }
        verticalRelation.heightRect = height
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
