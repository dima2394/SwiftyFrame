//
//  File.swift
//  
//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import UIKit

public extension FrameMaker {
    
    static func configure(view: UIView, configurationBlock: ConfigurationBlock) {
        let maker = FrameMaker(view: view)
        
        configurationBlock(maker)
        
        maker.defferedOperations.forEach { $0.start() }
    }
}
