//
//  File.swift
//  
//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import Foundation

protocol Relation { }
enum VerticalRelationType: Relation {
    case top
    case bottom
}

enum HorizontalRelationType: Relation {
    case left
    case right
}

