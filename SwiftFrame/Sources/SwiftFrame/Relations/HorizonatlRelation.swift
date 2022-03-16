//
//  File.swift
//  
//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

struct HorizontalRelation {
    var xRect: CGFloat = 0 {
        didSet {
            var frame = view.frame
            frame.origin.x = xRect
            view.frame = frame
        }
    }
    var widthRect: CGFloat = 0 {
        didSet {
            var frame = view.frame
            frame.size.width = widthRect
            view.frame = frame
        }
    }
    
    let view: UIView
    
    init(view: UIView) {
        self.view = view
    }
}
