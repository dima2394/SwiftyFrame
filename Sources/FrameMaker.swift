//
//  FrameMaker.swift
//  
//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

public class FrameMaker {
    
    unowned let view: UIView
    
    lazy var realizedVerticalRelations = ContiguousArray<VerticalRelationType>()
    lazy var realizedHorizontalRelations = ContiguousArray<HorizontalRelationType>()
    
    lazy var verticalRelation = VerticalRelation(view: view)
    lazy var horizontalRelation = HorizontalRelation(view: view)
    
    lazy var defferedOperations = ContiguousArray<Operation>()
    
    var safeAreaInset: UIEdgeInsets {
        guard #available(tvOS 11.0, iOS 9.0, *) else {
            return .zero
        }
        return view.window?.safeAreaInsets ?? .zero
    }
    
    init(view: UIView) {
        self.view = view
    }
}
