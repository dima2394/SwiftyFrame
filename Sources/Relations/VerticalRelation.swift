//
//  VerticalRelation.swift
//  
//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

struct VerticalRelation {
    var hasY = false
    var yRect: CGFloat = 0 {
        didSet {
            var frame = view.frame
            frame.origin.y = yRect
            view.frame = frame
            hasY = true
        }
    }
    
    var hasHeight = false
    var heightRect: CGFloat = 0 {
        didSet {
            var frame = view.frame
            frame.size.height = heightRect
            view.frame = frame
            hasHeight = true
        }
    }
    
    let view: UIView
    
    init(view: UIView) {
        self.view = view
    }
}
