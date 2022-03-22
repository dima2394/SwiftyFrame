//
//  Created by Dmitriy Verennik on 16.03.2022.
//

import Foundation

protocol Relation { }
public enum VerticalRelationType: Relation {
    case top
    case bottom
    case centerY
}

public enum HorizontalRelationType: Relation {
    case left
    case right
    case centerX
}

public enum DimensionRelationType: Relation {
    case width
    case height
}
