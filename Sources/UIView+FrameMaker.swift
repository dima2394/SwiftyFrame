//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

public typealias ConfigurationBlock = (FrameMaker) -> Void

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
