//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

public typealias ConfigurationBlock = (FrameMaker) -> Void

public extension Collection where Element == UIView {
    
    @discardableResult
    func container(in view: UIView, configurationBlock: () -> Void) -> UIView {
        let containerView = UIView(frame: .zero)
        containerView.addSubviews(Array(self))
        view.addSubview(containerView)
        configurationBlock()
        let dimensions = configureContainer(for: containerView)
        containerView.frame = CGRect(x: 0,
                                     y: 0,
                                     width: dimensions.width,
                                     height: dimensions.height)
        return containerView
    }
    
    private typealias Dimensions = (width: CGFloat, height: CGFloat)
    private func configureContainer(for container: UIView) -> Dimensions {
        var width: CGFloat = 0
        var height: CGFloat = 0
        container.subviews.forEach {
            width = Swift.max($0.frame.maxX, width)
            height = Swift.max($0.frame.maxY, height)
        }
        return (width: width, height: height)
    }
}

// MARK: -  FrameMaker

public extension Collection where Element == UIView {

    /// Let's configure frame for collection of views with SwiftyFrame.
    /// - Parameter configurationBlock: configure view frame `here`...`inside`...'
    func frame(configurationBlock: ConfigurationBlock) {
        forEach {
            FrameMaker.configure(view: $0, configurationBlock: configurationBlock)
        }
    }
}

public extension UIView {
    
    /// Let's configure view's frame with SwiftyFrame.
    /// - Parameter configurationBlock: configure view frame `here`...`inside`...'
    func frame(configurationBlock: ConfigurationBlock) {
        FrameMaker.configure(view: self, configurationBlock: configurationBlock)
    }
    
    /// Top Relation of View
    var top: RelationView<VerticalRelationType> {
        RelationView<VerticalRelationType>(view: self, relationType: .top)
    }
    
    /// Bottom Relation of View
    var bottom: RelationView<VerticalRelationType> {
        RelationView<VerticalRelationType>(view: self, relationType: .bottom)
    }
    
    /// Left Relation of View
    var left: RelationView<HorizontalRelationType> {
        RelationView<HorizontalRelationType>(view: self, relationType: .left)
    }
    
    /// Right Relation of View
    var right: RelationView<HorizontalRelationType> {
        RelationView<HorizontalRelationType>(view: self, relationType: .right)
    }
    
    /// Center X Relation of View
    var centerX: RelationView<HorizontalRelationType> {
        RelationView<HorizontalRelationType>(view: self, relationType: .centerX)
    }
    
    /// Center Y Relation of View
    var centerY: RelationView<VerticalRelationType> {
        RelationView<VerticalRelationType>(view: self, relationType: .centerY)
    }
    
    /// Height Relation of View
    var height: RelationView<DimensionRelationType> {
        RelationView<DimensionRelationType>(view: self, relationType: .height)
    }
    
    /// Width Relation of View
    var width: RelationView<DimensionRelationType> {
        RelationView<DimensionRelationType>(view: self, relationType: .width)
    }
}
