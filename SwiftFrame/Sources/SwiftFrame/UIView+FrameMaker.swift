//
//  File.swift
//  
//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

extension UIView {
    
    func configureFrame(configurationBlock: @escaping (FrameMaker) -> Void) {
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
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
