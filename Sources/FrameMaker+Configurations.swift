//
//  File.swift
//  
//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

public extension FrameMaker {
    
    static func configure(view: UIView, configurationBlock: @escaping (FrameMaker) -> Void) {
        let maker = FrameMaker(view: view, configurationBlock: configurationBlock)
        configurationBlock(maker)
    }
}
