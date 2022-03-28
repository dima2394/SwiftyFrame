//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

public typealias ConfigurationBlock = (FrameMaker) -> Void

public extension Collection where Element == UIView {
    
    @discardableResult
    func container(in view: UIView, configurationBlock: () -> Void) -> UIView {
        let containerView = UIView(frame: .zero)
        containerView.addSubviews(self.reversed())
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

public extension UIView {
    
    func frame(configurationBlock: ConfigurationBlock) {
        FrameMaker.configure(view: self, configurationBlock: configurationBlock)
    }
    
    var top: RelationView<VerticalRelationType> {
        RelationView<VerticalRelationType>(view: self, relationType: .top)
    }
    
    var bottom: RelationView<VerticalRelationType> {
        RelationView<VerticalRelationType>(view: self, relationType: .bottom)
    }
    
    var left: RelationView<HorizontalRelationType> {
        RelationView<HorizontalRelationType>(view: self, relationType: .left)
    }
    
    var right: RelationView<HorizontalRelationType> {
        RelationView<HorizontalRelationType>(view: self, relationType: .right)
    }
    
    var centerX: RelationView<HorizontalRelationType> {
        RelationView<HorizontalRelationType>(view: self, relationType: .centerX)
    }
    
    var centerY: RelationView<VerticalRelationType> {
        RelationView<VerticalRelationType>(view: self, relationType: .centerY)
    }
}
