//
//  FrameMaker.swift
//  
//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

final class FrameMaker {
    
    unowned let view: UIView
    var handlers =  [() -> ()]()
    
    lazy var verticalRelation = VerticalRelation(view: view)
    lazy var horizontalRelation = HorizontalRelation(view: view)
    var configurationBlock: ((FrameMaker) -> ())
    
    var safeAreaInset: UIEdgeInsets {
        view.window?.safeAreaInsets ?? .zero
    }
    
    init(view: UIView, configurationBlock: @escaping ((FrameMaker) -> ())) {
        self.view = view
        self.configurationBlock = configurationBlock
    }
}
